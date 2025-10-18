import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/user/booking/payment/payment_constants.dart';
import 'package:smart_clean/features/user/booking/payment/payment_option_card.dart';

class PaymentView extends StatefulWidget {
  final bool prebooking;
  const PaymentView({super.key, this.prebooking = false});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String _method = PaymentMethods.cash;

  void _pay() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.successTitle),
        content: const Text(AppStrings.paymentSuccess),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bookingDetailsRoute,
                (route) => false,
              );
            },
            child: const Text(AppStrings.okay),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.paymentTitle),
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20.w,
          vertical: AppPadding.p24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟦 العنوان
            Text(
              AppStrings.selectPaymentMethod,
              style: PaymentTextStyles.header,
            ),
            SizedBox(height: AppSize.s20.h),

            // 💳 خيارات الدفع
            PaymentOptionCard(
              title: AppStrings.payOnService,
              value: PaymentMethods.cash,
              icon: Icons.money,
              selected: _method == PaymentMethods.cash,
              onTap: () => setState(() => _method = PaymentMethods.cash),
            ),
            PaymentOptionCard(
              title: AppStrings.payByCard,
              value: PaymentMethods.card,
              icon: Icons.credit_card,
              selected: _method == PaymentMethods.card,
              onTap: () => setState(() => _method = PaymentMethods.card),
            ),
            PaymentOptionCard(
              title: AppStrings.walletPayment,
              value: PaymentMethods.wallet,
              icon: Icons.account_balance_wallet,
              selected: _method == PaymentMethods.wallet,
              onTap: () => setState(() => _method = PaymentMethods.wallet),
            ),

            const Spacer(),

            // 🟩 زر التأكيد
            GestureDetector(
              onTap: _pay,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: AppPadding.p18.h),
                decoration: PaymentBoxDecorations.confirmButton,
                child: Center(
                  child: Text(
                    AppStrings.confirmAndPay,
                    style: PaymentTextStyles.buttonText,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s40.h),
          ],
        ),
      ),
    );
  }
}
