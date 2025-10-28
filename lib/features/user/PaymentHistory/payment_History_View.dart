import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/PaymentHistory/cubit/payment_history_cubit.dart';
import 'package:smart_clean/features/user/PaymentHistory/widgets/payment_filter_bar.dart';
import 'package:smart_clean/features/user/PaymentHistory/widgets/payment_item_card.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentHistoryCubit()..loadPayments(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text("سجل الدفعات"),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
          builder: (context, state) {
            if (state is PaymentHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaymentHistoryError) {
              return Center(child: Text(state.message));
            } else if (state is PaymentHistoryLoaded) {
              final payments = state.payments;

              return Column(
                children: [
                  PaymentFilterBar(
                    selectedFilter: state.selectedFilter,
                    onFilterChanged: (filter) =>
                        context.read<PaymentHistoryCubit>().filterPayments(filter),
                  ),
                  Expanded(
                    child: payments.isEmpty
                        ? const Center(child: Text("لا توجد بيانات"))
                        : ListView.builder(
                            padding: EdgeInsets.all(16.w),
                            itemCount: payments.length,
                            itemBuilder: (context, index) {
                              return PaymentItemCard(payment: payments[index]);
                            },
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
