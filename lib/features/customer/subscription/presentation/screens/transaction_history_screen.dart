import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_event.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_state.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(LoadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: const Text('Transaction History'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SubscriptionLoaded) {
            final transactions = state.transactions;

            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  'No transactions found',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                final isCompleted = tx.status == 'completed';

                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Colors.black26 : Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? (isDarkMode ? Colors.green.withValues(alpha: 0.2) : Colors.green.shade50)
                              : (isDarkMode ? Colors.orange.withValues(alpha: 0.2) : Colors.orange.shade50),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check_circle : Icons.pending,
                          color: isCompleted ? Colors.green : Colors.orange,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tx.planId} Plan',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              DateFormat('MMM dd, yyyy • hh:mm a').format(tx.createdAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: context.textSecondaryColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Ref: ${tx.paymentProviderTransactionId}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 10.sp,
                                color: context.textSecondaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${tx.currency} ${tx.amount.toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.textPrimaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            tx.status.toUpperCase(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? context.successColor : context.warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Failed to load history'));
        },
      ),
    );
  }
}
