import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class PaymentHistoryView extends StatefulWidget {
  const PaymentHistoryView({super.key});

  @override
  State<PaymentHistoryView> createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends State<PaymentHistoryView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _filter = "الكل"; // 🧩 فلتر الحالة
  List<Map<String, dynamic>> _payments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    try {
      setState(() => _isLoading = true);
      final user = _auth.currentUser;
      if (user == null) return;

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookings')
          .get();

      final data = snapshot.docs.map((doc) {
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

      setState(() {
        _payments = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading payments: $e");
      setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredPayments {
    if (_filter == "الكل") return _payments;
    return _payments.where((p) => p["status"] == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("سجل الدفعات"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 🔽 شريط الفلترة
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton("الكل"),
                      _buildFilterButton("مدفوعة"),
                      _buildFilterButton("غير مدفوعة"),
                    ],
                  ),
                ),

                Expanded(
                  child: _filteredPayments.isEmpty
                      ? const Center(child: Text("لا توجد بيانات"))
                      : ListView.builder(
                          padding: EdgeInsets.all(16.w),
                          itemCount: _filteredPayments.length,
                          itemBuilder: (context, index) {
                            final payment = _filteredPayments[index];
                            final isPaid = payment["status"] == "مدفوعة";

                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        payment["service"]!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          color: isPaid
                                              ? Colors.green.shade100
                                              : Colors.red.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Text(
                                          payment["status"]!,
                                          style: TextStyle(
                                            color: isPaid
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text("رقم الفاتورة: ${payment["id"]}"),
                                  Text("تاريخ الدفع: ${payment["date"]}"),
                                  Text("طريقة الدفع: ${payment["method"]}"),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "المبلغ: ${payment["amount"]} ج.م",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = _filter == label;
    return ElevatedButton(
      onPressed: () => setState(() => _filter = label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? AppColors.primary : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}
