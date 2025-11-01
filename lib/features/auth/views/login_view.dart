// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_clean/core/constants/app_color.dart';
// import 'package:smart_clean/core/constants/app_strings.dart';
// import 'package:smart_clean/core/constants/value_manager.dart';
// import 'package:smart_clean/core/widgets/custom_button.dart';
// import 'package:smart_clean/core/widgets/custom_text_form_filed.dart';

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: AppSize.s120.h),
//             Center(
//               child: CircleAvatar(
//                 radius: AppSize.s40.r,
//                 backgroundColor: AppColor.circleAvatarIconColor,
//                 child: Icon(
//                   Icons.login_outlined,
//                   size: AppSize.s40.r,
//                   color: AppColor.loginButtonColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: AppSize.s20.h),
//             Text(
//               "مرحباً بك",
//               style: TextStyle(
//                 fontSize: AppSize.s26.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: AppSize.s10.h),
//             Text(
//               "سجل دخولك للمتابعة",
//               style: TextStyle(
//                 fontSize: AppSize.s16.sp,
              
//               ),
//             ),
//             SizedBox(height: AppSize.s30.h),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
//                 child: Text(
//                   'AppSfiledEmailText',
//                   style: TextStyle(
//                     fontSize: AppSize.s16.sp,
//                     // color: AppColor.hintTextColor,
//                   ),
//                 ),
//               ),
//             ),
//             CustomTextFormField(
//               controller: TextEditingController(),
//               hint: AppStrings.filedEmailText,
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
//                 child: Text(
//                   AppStrings.filedPasswordText,
//                   style: TextStyle(
//                     fontSize: AppSize.s16.sp,
//                     // color: AppColor.hintTextColor,
//                   ),
//                 ),
//               ),
//             ),

//             CustomTextFormField(
//               controller: TextEditingController(),
//               hint: AppStrings.filedPasswordText,
//               isSecure: true,
//             ),
// SizedBox(height: AppSize.s10.h),
//             CustomButton(
//               onPressed: () {},
//               title: AppStrings.loginText,
//               color: AppColor.loginButtonColor,
//               textColor: AppColor.scaffoldBackgroundColor,
//             ),
//             SizedBox(height: AppSize.s20.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
             
//                 GestureDetector(
//                   onTap: () {
//                     // Navigate to the registration screen
//                   },
//                   child: Text(
//                     AppStrings.loginKnow,
//                     style: TextStyle(
//                       fontSize: AppSize.s14.sp,
//                       color: AppColor.loginButtonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                    Text(
//                   AppStrings.dontHaveAccount,
//                   style: TextStyle(
//                     fontSize: AppSize.s14.sp,
//                     color: AppColor.textfiledColor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
