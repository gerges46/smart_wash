import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit() : super(PaymentHistoryLoading());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _payments = [];

  Future<void> loadPayments() async {
    try {
      emit(PaymentHistoryLoading());
      final user = _auth.currentUser;
      if (user == null) {
        emit(const PaymentHistoryError("المستخدم غير مسجل الدخول"));
        return;
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookings')
          .get();

      _payments = snapshot.docs.map((doc) {
        final d = doc.data();
        return {
          "id": doc.id,
          "service": d['service'] ?? "غير محدد",
          "amount": d['price']?.toString() ?? "0",
          "status": d['paymentStatus'] ?? "غير مدفوعة",
          "date": d['paymentDate'] ?? "",
          "method": d['paymentMethod'] ?? "نقدي",
        };
      }).toList();

      emit(PaymentHistoryLoaded(payments: _payments));
    } catch (e) {
      emit(PaymentHistoryError("حدث خطأ أثناء تحميل البيانات"));
    }
  }

  void filterPayments(String filter) {
    if (state is PaymentHistoryLoaded) {
      final allPayments = _payments;
      if (filter == "الكل") {
        emit(PaymentHistoryLoaded(payments: allPayments, selectedFilter: filter));
      } else {
        final filtered =
            allPayments.where((p) => p["status"] == filter).toList();
        emit(PaymentHistoryLoaded(payments: filtered, selectedFilter: filter));
      }
    }
  }
}
