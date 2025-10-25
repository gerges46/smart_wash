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

  /// ✅ تسجيل الخروج من الحساب
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(ProfileInitial()); // رجّع الحالة إلى البداية
    } catch (e) {
      emit(ProfileError("Logout failed: $e"));
    }
  }
}
