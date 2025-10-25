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
    const adminEmail = "admin@smartclean.com";
    const adminPassword = "123456";

    // 🔹 تحقق هل المستخدم هو الأدمن
    bool isAdmin = (email == adminEmail && password == adminPassword);

    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = cred.user;

    // ✅ لو المستخدم أدمن → مايبعتش رسالة تحقق بالبريد
    if (isAdmin) {
      await _firestore.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'admin',
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess(user: user, isAdmin: true));
      return;
    }

    // 🔸 المستخدم العادي → إرسال رسالة تحقق بالبريد
    await user!.sendEmailVerification();

    // تسجيل الخروج لغاية ما يفعل الإيميل
    await _auth.signOut();

    emit(AuthFailure(
      message:
          "تم إرسال رسالة تحقق إلى بريدك الإلكتروني. من فضلك فعّل حسابك ثم سجّل الدخول.",
    ));
  } on FirebaseAuthException catch (e) {
    // 🔹 حالة البريد موجود مسبقًا
    if (e.code == 'email-already-in-use') {
      try {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = cred.user;
        bool isAdmin = (email == "admin@smartclean.com" && password == "123456");

        if (isAdmin) {
          await _firestore.collection('users').doc(user!.uid).set({
            'name': name,
            'email': email,
            'phone': phone,
            'role': 'admin',
            'createdAt': FieldValue.serverTimestamp(),
          });

          emit(AuthSuccess(user: user, isAdmin: true));
          return;
        }

        await user!.reload();
        if (!user.emailVerified) {
          await _auth.signOut();
          emit(AuthFailure(
            message:
                "هذا البريد مسجل مسبقًا ولم يتم تفعيله بعد. تحقق من بريدك واضغط على رابط التفعيل.",
          ));
          return;
        }

        // البريد متحقق منه → نحفظ بياناته كمستخدم عادي
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AuthSuccess(user: user, isAdmin: false));
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
