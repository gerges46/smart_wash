import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'widgets/profile_card.dart';
import 'widgets/option_tile.dart';
import 'cubit/profile_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserData();
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();

    showDialog(
      context: context,
      barrierDismissible: false, // ما يقفلهاش بالضغط برة
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: const Text(
            "تأكيد تسجيل الخروج",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "هل أنت متأكد أنك تريد تسجيل الخروج؟",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إلغاء
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[700],
              ),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // اغلق الرسالة
                await cubit.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text("تأكيد",style: TextStyle(color: AppColors.white),),
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Text(
          "الملف الشخصي",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileInitial) {
            // بعد تسجيل الخروج، يرجع المستخدم لشاشة تسجيل الدخول
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = {
              "name": state.name,
              "phone": state.phone,
              "email": state.email,
            };

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                children: [
                  ProfileCard(user: user),
                  SizedBox(height: 25.h),
                  OptionTile(
                    icon: Icons.history,
                    title: "سجل الدفعات",
                    onTap: () {},
                  ),
                  OptionTile(
                    icon: Icons.settings,
                    title: "الإعدادات",
                    onTap: () {},
                  ),
                  OptionTile(
                    icon: Icons.help_outline,
                    title: "مركز المساعدة",
                    onTap: () {},
                  ),
                  OptionTile(
                    icon: Icons.policy_outlined,
                    title: "سياسة الخصوصية",
                    onTap: () {},
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _showLogoutConfirmationDialog(context);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        "تسجيل الخروج",
                        style:
                            TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                "حدث خطأ: ${state.message}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
