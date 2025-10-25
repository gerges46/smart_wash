import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_clean/core/routes/app_router.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit({required this.bookingId}) : super(RatingInitial());
  
  final String bookingId;
  double rating = 4.0;
  final TextEditingController noteController = TextEditingController();
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateRating(double value) {
    rating = value;
    emit(RatingUpdated(rating));
  }

  // دالة للتحقق من صحة البيانات
  bool _validateInput() {
    if (rating < 1) {
      emit(RatingError('الرجاء اختيار تقييم من 1 إلى 5 نجوم'));
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    try {
      // التحقق من صحة البيانات أولاً
      if (!_validateInput()) return;
      
      emit(RatingLoading());
      
      final user = _auth.currentUser;
      if (user == null) {
        emit(RatingError('يجب تسجيل الدخول أولاً'));
        return;
      }

      // 1. جلب بيانات المستخدم علشان نأخذ الـ name
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final userName = userDoc.data()?['name'] ?? 'مستخدم';

      // 2. حفظ التقييم في subcollection داخل الـ booking
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookings')
          .doc(bookingId)
          .collection('ratings')
          .add({
        'rating': rating,
        'note': noteController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'userName': userName,
        'userEmail': user.email,
      });

      // 3. تحديث الـ booking نفسه بإضافة حقل التقييم
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookings')
          .doc(bookingId)
          .update({
        'isRated': true,
        'rating': rating,
        'ratedAt': FieldValue.serverTimestamp(),
      });

      emit(RatingSuccess());
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("شكراً لتقييمك! 🎉"))
      );
      
      _navigateToNextScreen(context);

    } catch (e) {
      emit(RatingError('حدث خطأ في حفظ التقييم: $e'));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: $e"))
      );
    }
  }

  // دالة الـ Skip
  void skipRating(BuildContext context) {
    // ممكن نحفظ في الـ booking إن المستخدم skip التقييم
    _markAsSkipped();
    _navigateToNextScreen(context);
  }

  Future<void> _markAsSkipped() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('bookings')
            .doc(bookingId)
            .update({
          'isRated': false,
          'ratingSkipped': true,
          'ratedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error marking as skipped: $e');
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context, 
      Routes.bottomNavRoute, 
      (_) => false
    );
  }

  @override
  Future<void> close() {
    noteController.dispose();
    return super.close();
  }
}