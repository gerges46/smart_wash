import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/admin/admin_order_details/widgets/edit_order_dialog.dart';
import 'package:smart_clean/features/admin/admin_order_details/widgets/order_appbar.dart';
import 'package:smart_clean/features/admin/admin_order_details/widgets/order_info_card.dart';
import 'package:smart_clean/features/admin/admin_order_details/widgets/order_status_card.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/cubit/dashboard_cubit.dart';

class AdminOrderDetailsView extends StatefulWidget {
  final Map<String, dynamic> order;
  const AdminOrderDetailsView({super.key, required this.order});

  @override
  State<AdminOrderDetailsView> createState() => _AdminOrderDetailsViewState();
}

class _AdminOrderDetailsViewState extends State<AdminOrderDetailsView> {
  late String service;
  late String time;
  late String location;
  late String status;
  late bool isPaid;

  final List<String> statusList = [
    AppStrings.bookingStatusPending,
    AppStrings.bookingStatusInProgress,
    AppStrings.bookingStatusCompleted,
  ];

  @override
  void initState() {
    super.initState();
    service = widget.order['service'] ?? "غسيل خارجي";
    time = widget.order['time'] ?? 'غير محدد';
    location = widget.order['address'] ?? 'غير محدد';
    status = widget.order['status'] ?? 'قيد الانتظار';
    isPaid = widget.order['isPaid'] ?? false;
  }

  Future<void> _openEditDialog() async {
  showEditOrderDialog(
    context: context,
    currentService: service,
    currentTime: time,
    currentLocation: location,
    currentStatus: status,
    currentPrice: double.tryParse(widget.order['price'].toString().replaceAll('ج.م', '').trim()) ?? 0,
    servicesList: AppStrings.services,
    statusList: statusList,
    onSave: (newService, newTime, newLocation, newStatus, newPrice) async {
      setState(() {
        service = newService;
        time = newTime;
        location = newLocation;
        status = newStatus;
        widget.order['price'] = newPrice;
      });

      final cubit = BlocProvider.of<DashboardCubit>(context);

      await cubit.updateBooking(
        userId: widget.order['userId'],
        bookingId: widget.order['id'],
        updatedData: {
          'service': newService,
          'time': newTime,
          'address': newLocation,
          'status': newStatus,
          'price': newPrice,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ تم تحديث بيانات الطلب بنجاح"),
          backgroundColor: Colors.green,
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: OrderAppBar(
        title: AppStrings.orderDetails,
        onEdit: _openEditDialog,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p20.w),
        child: ListView(
          children: [
            OrderInfoCard(
              icon: Icons.person,
              title: "العميل",
              value: widget.order['client'] ?? 'غير معروف',
            ),
            // ✅ رقم الموبايل (غير قابل للتعديل)
            OrderInfoCard(
              icon: Icons.phone,
              title: "رقم الموبايل",
              value: widget.order['phone'] ?? 'غير متوفر',
            ),

            OrderInfoCard(
              icon: Icons.cleaning_services,
              title: "الخدمة",
              value: service,
            ),
            OrderInfoCard(
              icon: Icons.price_change,
              title: "السعر",
              value: "${widget.order['price'] ?? '0'} ج.م",
            ),
            OrderInfoCard(
              icon: Icons.access_time,
              title: "الوقت",
              value: time,
            ),
            OrderInfoCard(
              icon: Icons.location_on_outlined,
              title: "الموقع",
              value: location,
            ),

            // 🔹 حقل جديد: حالة الدفع
            Card(
              color: isPaid ? Colors.green[50] : Colors.red[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.only(bottom: 16.h),
              child: ListTile(
                leading: Icon(
                  isPaid ? Icons.check_circle : Icons.cancel,
                  color: isPaid ? Colors.green : Colors.red,
                ),
                title: const Text(
                  "حالة الدفع",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  isPaid ? "✅ مدفوع" : "❌ غير مدفوع",
                  style: TextStyle(
                    color: isPaid ? Colors.green : Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            OrderStatusCard(status: status),

            SizedBox(height: 20.h),

            ElevatedButton.icon(
              onPressed: _openEditDialog,
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text("تعديل الطلب",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    EdgeInsets.symmetric(horizontal: 50.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
