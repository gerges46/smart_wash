import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/user/booking/payment/payment_constants.dart';
import 'package:smart_clean/features/user/booking/payment/payment_option_card.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';

class PaymentView extends StatefulWidget {
  final String bookingId;
  const PaymentView({super.key, required this.bookingId});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String _selectedMethod = PaymentMethods.cash; // الافتراضي: الدفع عند التنفيذ

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();
    cubit.setBookingId(widget.bookingId);

    return WillPopScope(
      onWillPop: () => cubit.confirmExit(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(AppStrings.paymentTitle),
          backgroundColor: AppColors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () async {
              final shouldExit = await cubit.confirmExit(context);
              if (shouldExit && context.mounted) Navigator.pop(context);
            },
          ),
        ),

        // ✅ BlocConsumer: بنسمع الحالات ونعرض الرسائل بناءً عليها
        body: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state.isPaid) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ تم الدفع بنجاح!"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bookingDetailsRoute,
                (route) => false,
              );
            }

        
          },

          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20.w,
                vertical: AppPadding.p24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.selectPaymentMethod,
                      style: PaymentTextStyles.header),
                  SizedBox(height: AppSize.s20.h),

                  // 💳 بطاقة بنكية
                  PaymentOptionCard(
                    title: "بطاقة بنكية",
                    value: PaymentMethods.card,
                    icon: Icons.credit_card,
                    selected: _selectedMethod == PaymentMethods.card,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethods.card),
                  ),

                  // 👛 محفظة إلكترونية
                  PaymentOptionCard(
                    title: "محفظة إلكترونية",
                    value: PaymentMethods.wallet,
                    icon: Icons.account_balance_wallet,
                    selected: _selectedMethod == PaymentMethods.wallet,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethods.wallet),
                  ),

                  // 💵 دفع عند التنفيذ
                  PaymentOptionCard(
                    title: "دفع عند التنفيذ",
                    value: PaymentMethods.cash,
                    icon: Icons.money,
                    selected: _selectedMethod == PaymentMethods.cash,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethods.cash),
                  ),

                  const Spacer(),

                  // 🟩 زر التأكيد والدفع
                  GestureDetector(
                    onTap: state.isPaying
                        ? null
                        : () async {
                            if (_selectedMethod == PaymentMethods.cash) {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("تأكيد الدفع عند التنفيذ"),
                                  content: const Text(
                                      "هل أنت متأكد أنك تريد الدفع عند التنفيذ؟"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("إلغاء"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text("تأكيد"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("✅ تم تأكيد الدفع عند التنفيذ."),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.bookingDetailsRoute,
                                  (route) => false,
                                );
                              }
                            } else {
                              cubit.pay(context);
                            }
                          },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: AppPadding.p18.h),
                      decoration: PaymentBoxDecorations.confirmButton,
                      child: Center(
                        child: state.isPaying
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text("تأكيد والدفع",
                                style: PaymentTextStyles.buttonText),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
