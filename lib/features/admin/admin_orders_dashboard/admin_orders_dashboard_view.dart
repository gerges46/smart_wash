import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/cubit/dashboard_state.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/widgets/admin_dashboard_helper.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/widgets/dashboard_appbar.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/widgets/dashboard_summary.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/widgets/order_card.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  String? selectedStatus;
  String? selectedPayment;
  String clientName = "";

  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().fetchAllBookings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state.error != null && state.error!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final bookings = context.read<DashboardCubit>().filterBookings(
              clientName: clientName,
              status: selectedStatus,
              paymentStatus: selectedPayment,
            );

        final completedCount = state.adminBookings
            .where((e) => e["status"] == AppStrings.bookingStatusCompleted)
            .length;
        final pendingCount = state.adminBookings
            .where((e) => e["status"] == AppStrings.bookingStatusPending)
            .length;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const DashboardAppBar(),
          body: Column(
            children: [
              DashboardSummary(
                total: state.adminBookings.length,
                completed: completedCount,
                pending: pendingCount,
              ),

              // 🔹 فلاتر أعلى القائمة
             Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  child: Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        // 🔹 حقل البحث باسم العميل
        TextField(
          decoration: InputDecoration(
            hintText: "ابحث باسم العميل...",
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onChanged: (value) {
            setState(() => clientName = value);
          },
        ),

        SizedBox(height: 12.h),

        // 🔹 صف الفلاتر
        // 🔹 صف الفلاتر
Row(
  children: [
    Expanded(
      child: DropdownButtonFormField<String>(
        isExpanded: true, // ✅ يمنع الـoverflow
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.assignment, color: AppColors.primary),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
        hint: const Text("حالة الطلب", overflow: TextOverflow.ellipsis),
        value: selectedStatus,
        items: const [
          DropdownMenuItem(value: "مكتمل", child: Text("مكتمل")),
          DropdownMenuItem(value: "قيد التنفيذ", child: Text("قيد التنفيذ")),
          DropdownMenuItem(value: "قيد الانتظار", child: Text("قيد الانتظار")),
        ],
        onChanged: (value) {
          setState(() => selectedStatus = value);
        },
      ),
    ),
    SizedBox(width: 8.w),
    Expanded(
      child: DropdownButtonFormField<String>(
        isExpanded: true, // ✅ يمنع الـoverflow
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.payment, color: AppColors.primary),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
        hint: const Text("حالة الدفع", overflow: TextOverflow.ellipsis),
        value: selectedPayment,
        items: const [
          DropdownMenuItem(value: "مدفوع", child: Text("مدفوع")),
          DropdownMenuItem(value: "غير مدفوع", child: Text("غير مدفوع")),
        ],
        onChanged: (value) {
          setState(() => selectedPayment = value);
        },
      ),
    ),
  ],
),

      ],
    ),
  ),
),


              Expanded(
                child: state.loading
                    ? const Center(child: CircularProgressIndicator())
                    : bookings.isEmpty
                        ? const Center(child: Text("لا توجد حجوزات مطابقة"))
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              final order = bookings[index];
                              AdminDashboardHelper.getStatusColor(order['status']);
                              AdminDashboardHelper.getStatusIcon(order['status']);

                              return OrderCard(order: order);
                            },
                          ),
              ),
            ],
          ),

          floatingActionButton: _buildFABs(context),
        );
      },
    );
  }

  Widget _buildFABs(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          backgroundColor: AppColors.secondary,
          heroTag: "fab1",
          onPressed: () {
            _showEditServiceDialog(context);
          },
          icon: const Icon(Icons.attach_money, color: Colors.white),
          label: const Text(
            "تعديل سعر الخدمات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          heroTag: "fab2",
          onPressed: () {
            Navigator.pushNamed(context, Routes.adminSchedule);
          },
          icon: const Icon(Icons.schedule, color: Colors.white),
          label: const Text(
            "جدول العمل",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _showEditServiceDialog(BuildContext context) {
    // نفس الكود القديم لزر تعديل السعر بالضبط
  }
}
