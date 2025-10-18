import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class AdminOrderDetailsView extends StatefulWidget {
  final Map order;
  const AdminOrderDetailsView({super.key, required this.order});

  @override
  State<AdminOrderDetailsView> createState() => _AdminOrderDetailsViewState();
}

class _AdminOrderDetailsViewState extends State<AdminOrderDetailsView> {
  late String service;
  late String time;
  late String location;
  late String status;

  final List<String> servicesList = [
    "غسيل خارجي",
    "غسيل داخلي",
    "تلميع كامل",
    "تنظيف المحرك",
  ];

  final List<String> statusList = ["قيد الانتظار", "قيد التنفيذ", "مكتمل"];

  @override
  void initState() {
    super.initState();
    service = widget.order['service'] ?? "غسيل خارجي";
    time = widget.order['time'] ?? 'غير محدد';
    location = widget.order['location'] ?? 'غير محدد';
    status = widget.order['status'] ?? 'قيد الانتظار';
  }

  void _showEditDialog() {
    final locationController = TextEditingController(text: location);
    String newStatus = status;
    String newService = service;
    String newTime = time;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "تعديل الطلب",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // ✅ Dropdown لاختيار الخدمة بالعربي
                DropdownButtonFormField<String>(
                  value: servicesList.contains(newService)
                      ? newService
                      : servicesList.first,
                  decoration: const InputDecoration(labelText: "الخدمة"),
                  items: servicesList
                      .map(
                        (service) => DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    newService = value!;
                  },
                ),

                const SizedBox(height: 10),

                // ✅ اختيار التاريخ من الكلندر
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        newTime =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    child: Text(
                      "الوقت: $newTime",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                // ✅ إدخال العنوان
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "الموقع",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // ✅ Dropdown لاختيار الحالة
                DropdownButtonFormField<String>(
                  value: statusList.contains(newStatus)
                      ? newStatus
                      : "قيد الانتظار",
                  decoration: const InputDecoration(labelText: "الحالة"),
                  items: statusList
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) {
                    newStatus = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  service = newService;
                  time = newTime;
                  location = locationController.text;
                  status = newStatus;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تعديل الطلب بنجاح ✅")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text("حفظ"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.95),
                AppColors.secondary.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              AppStrings.orderDetails,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: _showEditDialog,
                tooltip: "تعديل الطلب",
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p20.w),
        child: Column(
          children: [
            _orderCard(
              Icons.person,
              "العميل",
              widget.order['client'] ?? 'غير معروف',
            ),
            _orderCard(Icons.cleaning_services, "الخدمة", service),
            _orderCard(Icons.access_time, "الوقت", time),
            _orderCard(Icons.location_on_outlined, "الموقع", location),
            _statusCard(status),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _showEditDialog,
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "تعديل الطلب",
                style: TextStyle(color: AppColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 14.h),
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

  Widget _orderCard(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(String status) {
    final Color color = status == "مكتمل"
        ? Colors.green
        : status == "قيد التنفيذ"
        ? Colors.orange
        : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.flag, color: color),
          ),
          SizedBox(width: 14.w),
          Text(
            "الحالة:",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
