import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_event.dart';
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_state.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(1);

  final List<Map<String, dynamic>> _plans = [
    {
      'planId': 'GOLD',
      'name': 'Monthly',
      'price': 50.0,
      'duration': '1 month',
      'tier': 1,
      'benefits': [
        'Access to all premium tips and quotes',
        'Priority notifications',
        'Monthly exclusive content',
      ],
    },
    {
      'planId': 'PLATINUM',
      'name': '3 Months',
      'price': 135.0,
      'duration': '3 months',
      'tier': 2,
      'benefits': [
        'All monthly benefits',
        '10% savings compared to monthly',
        'Early access to new features',
      ],
      'recommended': true,
    },
    {
      'planId': 'DIAMOND',
      'name': 'Annual',
      'price': 480.0,
      'duration': '12 months',
      'tier': 3,
      'benefits': [
        'All quarterly benefits',
        '20% savings compared to monthly',
        'Annual exclusive wellness guide',
      ],
    },
  ];

  static const String _clientId = 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
  static const String _secretKey = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(LoadSubscription());
  }

  int _getPlanTier(String planId) {
    return _plans.firstWhere((p) => p['planId'] == planId, orElse: () => _plans.first)['tier'] as int;
  }

  double _getUpgradeSavings(String currentPlanId, String newPlanId) {
    if (currentPlanId == 'GOLD' && newPlanId == 'PLATINUM') return 10.0;
    if (currentPlanId == 'GOLD' && newPlanId == 'DIAMOND') return 20.0;
    if (currentPlanId == 'PLATINUM' && newPlanId == 'DIAMOND') return 10.0;
    return 0.0;
  }

  void _showFeedback(String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? context.successColor : context.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  void _subscribeToPlan(Map<String, dynamic> plan) {
    final productId = 'plan_${plan['planId']}_${DateTime.now().millisecondsSinceEpoch}';
    final productName = '${plan['name']} Subscription';
    final amount = plan['price'].toString();

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: _clientId,
          secretId: _secretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: productId,
          productName: productName,
          productPrice: amount,
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          context.read<SubscriptionBloc>().add(PurchaseSubscription(
            planId: plan['planId'],
            status: 'active',
            paymentProvider: 'esewa',
            paymentProviderTransactionId: result.refId,
            amount: plan['price'],
            currency: 'NPR',
          ));
        },
        onPaymentFailure: (result) {
          _showFeedback('Payment failed', isSuccess: false);
        },
        onPaymentCancellation: (result) {
          _showFeedback('Payment cancelled', isSuccess: false);
        },
      );
    } catch (e) {
      _showFeedback(e.toString(), isSuccess: false);
    }
  }

  void _showCancelConfirmation() async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Subscription', style: theme.textTheme.titleLarge),
        content: const Text('Are you sure you want to cancel your subscription?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // API call to cancel not fully defined in proto, for now update to cancelled
      context.read<SubscriptionBloc>().add(const PurchaseSubscription(
        planId: 'CANCELLED',
        status: 'cancelled',
        paymentProvider: 'none',
        paymentProviderTransactionId: '',
        amount: 0.0,
        currency: 'NPR',
      ));
    }
  }

  Widget _buildPlanCard({
    required Map<String, dynamic> plan,
    required bool isDarkMode,
    required bool isActiveCard,
    required String? currentPlanId,
    required bool isSubscriptionActive,
  }) {
    final isCurrentPlan = isSubscriptionActive && plan['planId'] == currentPlanId;
    final isUpgrade = currentPlanId != null && isSubscriptionActive && _getPlanTier(plan['planId']) > _getPlanTier(currentPlanId);
    final savings = isUpgrade ? _getUpgradeSavings(currentPlanId, plan['planId']) : 0.0;
    final buttonText = isCurrentPlan ? 'Current Plan' : (isUpgrade ? 'Upgrade Now' : 'Subscribe Now');
    final buttonEnabled = !isCurrentPlan;

    final theme = Theme.of(context);
    final borderColor = isDarkMode ? context.primaryColor : context.textPrimaryColor;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Transform.scale(
        scale: isActiveCard ? 1.05 : 0.95,
        child: Container(
          width: 280.w,
          height: 320.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode ? [Colors.grey[850]!, Colors.grey[900]!] : [Colors.white, Colors.grey.shade100],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor, width: isActiveCard ? 2.w : 1.w),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black54 : Colors.grey.withValues(alpha: 0.2),
                blurRadius: isActiveCard ? 10.r : 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan['name'], style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  Text('NPR ${plan['price'].toStringAsFixed(2)} / ${plan['duration']}',
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    if (savings > 0)
                      Text('Save $savings% by upgrading!',
                          style: theme.textTheme.bodySmall?.copyWith(color: context.primaryColor, fontWeight: FontWeight.bold)),
                    SizedBox(height: 25.h),
                    ...plan['benefits'].map<Widget>((benefit) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, size: 18.sp, color: context.primaryColor),
                            SizedBox(width: 6.w),
                            Expanded(child: Text(benefit, style: theme.textTheme.bodySmall)),
                          ],
                        ),
                      )),
                  const Spacer(),
                    ElevatedButton(
                      onPressed: buttonEnabled ? () => _subscribeToPlan(plan) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCurrentPlan
                            ? Colors.grey
                            : (isDarkMode ? context.primaryColor : context.textPrimaryColor),
                        foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(buttonText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: const Text('Go Premium'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigator.pushNamed(context, RouteNames.transactionHistoryScreen);
            },
          ),
        ],
      ),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionPurchaseSuccess) {
            _showFeedback('Subscription successful!', isSuccess: true);
          } else if (state is SubscriptionPurchaseFailure) {
            _showFeedback(state.message, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading || state is SubscriptionPurchaseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isSubscriptionActive = false;
          String? currentPlanId;
          DateTime? endDate;
          int currentTier = 0;

          if (state is SubscriptionLoaded) {
            isSubscriptionActive = state.subscription.isActive;
            currentPlanId = state.subscription.planId;
            endDate = state.subscription.endDate;
            currentTier = isSubscriptionActive ? _getPlanTier(currentPlanId) : 0;
          }

          final visiblePlans = isSubscriptionActive
              ? _plans.where((p) => _getPlanTier(p['planId']) >= currentTier).toList()
              : List.from(_plans);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSubscriptionActive ? 'Your Subscription' : 'Unlock All Premium Content',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.h),
                if (isSubscriptionActive) ...[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[850] : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Plan', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.h),
                        Text('${currentPlanId?.toUpperCase()} Plan'),
                        if (endDate != null) Text('Ends on ${DateFormat('MMM dd, yyyy').format(endDate)}'),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: _showCancelConfirmation,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Cancel Subscription', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                SizedBox(
                  height: 420.h,
                  child: CarouselSlider.builder(
                    itemCount: visiblePlans.length,
                    options: CarouselOptions(
                      height: 350.h,
                      enlargeCenterPage: true,
                      viewportFraction: 0.75,
                      onPageChanged: (index, _) => _currentIndex.value = index,
                    ),
                    itemBuilder: (context, index, _) {
                      return ValueListenableBuilder<int>(
                        valueListenable: _currentIndex,
                        builder: (context, activeIndex, _) {
                          return _buildPlanCard(
                            plan: visiblePlans[index],
                            isDarkMode: isDarkMode,
                            isActiveCard: activeIndex == index,
                            currentPlanId: currentPlanId,
                            isSubscriptionActive: isSubscriptionActive,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
