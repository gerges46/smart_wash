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

  @override
  void initState() {
    // TODO: implement initState
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
        final bookings = state.adminBookings; 
        final completedCount =
            bookings.where((e) => e["status"] == AppStrings.bookingStatusCompleted).length;
        final pendingCount =
            bookings.where((e) => e["status"] == AppStrings.bookingStatusPending).length;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const DashboardAppBar(),
          body: Column(
            children: [
              DashboardSummary(
                total: bookings.length,
                completed: completedCount,
                pending: pendingCount,
              ),
              Expanded(
                child: state.loading
                    ? const Center(child: CircularProgressIndicator())
                    : bookings.isEmpty
                        ? const Center(child: Text("لا توجد حجوزات حتى الآن"))
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              final order = bookings[index];
                             AdminDashboardHelper.getStatusColor(order['status']);
                             AdminDashboardHelper.getStatusIcon(order['status']);

                              return OrderCard(order: order); // استخدمنا OrderCard جاهز
                            },
                          ),
              ),
            ],
          ),
          floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              backgroundColor: AppColors.secondary,
              heroTag: "fab1", // ✅ حل الخطأ
              onPressed: () {
                final parentContext = context; // نستخدمه داخل الـDialog
                showDialog(
                  context: context,
                  builder: (context) {
                    String? selectedService;
                    final priceController = TextEditingController();

                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.white,
                      title: Row(
                        children: const [
                          Icon(Icons.edit, color: AppColors.primary),
                          SizedBox(width: 8),
                          Text(
                            "تعديل سعر الخدمات",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "اختر الخدمة:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              hint: const Text("اختر الخدمة"),
                              value: selectedService,
                              items: const [
                                DropdownMenuItem(
                                  value: "غسيل خارجي",
                                  child: Text("غسيل خارجي"),
                                ),
                                DropdownMenuItem(
                                  value: "غسيل داخلي",
                                  child: Text("غسيل داخلي"),
                                ),
                                DropdownMenuItem(
                                  value: "تلميع كامل",
                                  child: Text("تلميع كامل"),
                                ),
                                DropdownMenuItem(
                                  value: "تنظيف المحرك",
                                  child: Text("تنظيف المحرك"),
                                ),
                              ],
                              onChanged: (value) {
                                selectedService = value;
                              },
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "اكتب السعر الجديد (بالريال السعودي):",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "70",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            final name = selectedService;
                            final priceText = priceController.text.trim();

                            if (name == null || priceText.isEmpty) {
                              ScaffoldMessenger.of(parentContext).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "يرجى اختيار الخدمة وكتابة السعر الجديد."),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            final price = double.tryParse(priceText);
                            if (price == null) {
                              ScaffoldMessenger.of(parentContext).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "السعر يجب أن يكون رقمًا صحيحًا."),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            final result = await parentContext
                                .read<DashboardCubit>()
                                .addService(name, price);

                            Navigator.of(context, rootNavigator: true).pop();

                            String msg = result == "updated"
                                ? 'تم تحديث سعر "$name" بنجاح ✅'
                                : result == "added"
                                    ? 'تمت إضافة الخدمة "$name" بنجاح ✅'
                                    : 'حدث خطأ أثناء الحفظ ❌';

                            final color = result == "error"
                                ? Colors.red
                                : Colors.green;

                            ScaffoldMessenger.of(parentContext).showSnackBar(
                              SnackBar(
                                content: Text(msg),
                                backgroundColor: color,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          },
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            "تأكيد",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
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
              heroTag: "fab2", // ✅ حل الخطأ
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
        ),
        );
      },
    );
  }
}

