import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserData() async {
    try {
      emit(ProfileLoading());

      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        emit(const ProfileError("User not logged in"));
        return;
      }

      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        final data = doc.data()!;
        emit(ProfileLoaded(
          name: data['name'] ?? 'No Name',
          email: data['email'] ?? 'No Email',
          phone: data['phone'] ?? 'No Phone',
        ));
      } else {
        emit(const ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }


Future<void> updateUserData({
  required String phone,
  required String currentPassword,
  String? newPassword,
}) async {
  try {
    emit(ProfileLoading());
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not found");

    // 🔄 تأكيد المصادقة بالباسورد الحالي
    await _auth.signInWithEmailAndPassword(
      email: user.email!,
      password: currentPassword,
    );

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred);

    // ✅ تحديث كلمة المرور لو المستخدم كتب جديد
    if (newPassword != null && newPassword.isNotEmpty) {
      await user.updatePassword(newPassword);
    }

    // ✅ تحديث رقم الموبايل فقط في Firestore
    await _firestore.collection('users').doc(user.uid).update({
      'phone': phone,
    });

    emit(ProfileSuccess("✅ تم حفظ التغييرات بنجاح"));
    await getUserData();
  } on FirebaseAuthException catch (e) {
    String message = "حدث خطأ غير متوقع، حاول مرة أخرى.";

    if (e.code == 'wrong-password') {
      message = "❌ كلمة المرور الحالية غير صحيحة.";
    } else if (e.code == 'requires-recent-login') {
      message =
          "⚠️ لحماية حسابك، يرجى تسجيل الدخول مرة أخرى قبل تعديل كلمة المرور.";
    }
    
    emit(ProfileError(message));
  } catch (e) {
    emit(ProfileError("حدث خطأ أثناء حفظ التغييرات، حاول لاحقًا."));
  }
}

  /// ✅ تسجيل الخروج من الحساب
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(ProfileInitial()); // رجّع الحالة إلى البداية
    } catch (e) {
      emit(ProfileError("Logout failed: $e"));
    }
  }

  Future<void> getUserNotifications() async {
  try {
    emit(ProfileLoading());

    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      emit(const ProfileError("User not logged in"));
      return;
    }

    final snapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    final notifications = snapshot.docs.map((doc) => doc.data()).toList();
    emit(ProfileNotificationsLoaded(notifications: notifications));
  } catch (e) {
    emit(ProfileError("فشل تحميل الإشعارات"));
  }
}

}
