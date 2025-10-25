import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

const adminEmail = "admin@smartclean.com";
const adminPassword = "123456";

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());
 Future<void> registerUser({
  required String name,
  required String email,
  required String phone,
  required String password,
}) async {
  emit(AuthLoading());
  try {
    // 🟡 الخطوة 1: نحاول نجيب المستخدم الحالي لو موجود
    User? existingUser = _auth.currentUser;

    // 🟢 الخطوة 2: لو المستخدم مش موجود → نسجله
    if (existingUser == null) {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إرسال رسالة التحقق بالبريد
      await cred.user!.sendEmailVerification();

      // نعمل تسجيل خروج بعد الإرسال
      await _auth.signOut();

      emit(AuthFailure(
        message:
            "تم إرسال رسالة تحقق إلى بريدك الإلكتروني. من فضلك فعّل حسابك ثم سجّل الدخول.",
      ));
      return;
    }

    // 🟢 الخطوة 3: لو المستخدم موجود بالفعل
    await existingUser.reload(); // نحدث بياناته من السيرفر
    if (!existingUser.emailVerified) {
      emit(AuthFailure(
        message:
            "يجب تأكيد بريدك الإلكتروني أولاً. تحقق من بريدك واضغط على رابط التفعيل.",
      ));
      return;
    }

    // 🟢 الخطوة 4: لو البريد متحقق منه → نحفظه في Firestore
    await _firestore.collection('users').doc(existingUser.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    });

    emit(AuthSuccess(user: existingUser, isAdmin: false));
  } on FirebaseAuthException catch (e) {
    // لو البريد موجود بالفعل، نعمل فحص للتحقق بدل ما نرمي خطأ
    if (e.code == 'email-already-in-use') {
      try {
        // نسجل الدخول بالبريد القديم ونفحص التحقق
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        await cred.user!.reload();
        if (!cred.user!.emailVerified) {
          await _auth.signOut();
          emit(AuthFailure(
            message:
                "هذا البريد مسجل مسبقًا ولم يتم تفعيله بعد. تحقق من بريدك واضغط على رابط التفعيل.",
          ));
          return;
        }

        // البريد متحقق منه
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AuthSuccess(user: cred.user!, isAdmin: false));
        return;
      } catch (e2) {
        emit(AuthFailure(message: "فشل تسجيل الدخول بالبريد المسجل مسبقًا."));
        return;
      }
    }

    emit(AuthFailure(message: getFriendlyErrorMessage(e.code)));
  } catch (e) {
    emit(AuthFailure(message: getFriendlyErrorMessage(e.toString())));
  }
}



  // 🟣 تسجيل الدخول
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // لو أدمن
      if (email == adminEmail && password == adminPassword) {
        emit(AuthSuccess(user: null, isAdmin: true));
        return;
      }

      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user: cred.user!, isAdmin: false));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: getFriendlyErrorMessage(e.code)));
    } catch (e) {
      emit(AuthFailure(message: getFriendlyErrorMessage(e.toString())));
    }
  }

  // 🔴 تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthLoggedOut());
  }

  Future<void> resetPassword(String email) async {
  emit(AuthPasswordResetEmailSentLoading());
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    emit(AuthPasswordResetEmailSentSuccess());
  } on FirebaseAuthException catch (e) {
    emit(AuthPasswordResetEmailSentFailure(message: getFriendlyErrorMessage(e.code)));
  } catch (e) {
    emit(AuthPasswordResetEmailSentFailure(message: 'حدث خطأ أثناء إرسال رابط إعادة التعيين.'));
  }
}


  // 🟡 ترجمة أكواد الأخطاء من Firebase
  String getFriendlyErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'هذا البريد مستخدم بالفعل. جرّب بريدًا آخر.';
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا. استخدم كلمة أقوى.';
      case 'user-not-found':
        return 'المستخدم غير موجود.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      case 'invalid-credential':
        return 'بيانات الدخول غير صحيحة. تأكد من البريد وكلمة المرور.';
      default:
        return 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.';
    }
  }

  // 👁️‍🗨️ إظهار / إخفاء كلمة المرور
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }
}
