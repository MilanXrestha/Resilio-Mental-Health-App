import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/l10n/app_localizations.dart';
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
          _showFeedback(AppLocalizations.of(context)!.bizPaymentFailed, isSuccess: false);
        },
        onPaymentCancellation: (result) {
          _showFeedback(AppLocalizations.of(context)!.bizPaymentCancelled, isSuccess: false);
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
        title: Text(AppLocalizations.of(context)!.bizCancelSubscription, style: theme.textTheme.titleLarge),
        content: Text(AppLocalizations.of(context)!.bizCancelSubscriptionConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocalizations.of(context)!.bizNo)),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.bizYes, style: const TextStyle(color: Colors.red)),
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

  Widget _buildHeroBanner(bool isDarkMode, ThemeData theme) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFF667EEA), const Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, size: 12.sp, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          AppLocalizations.of(context)!.bizPremiumMembership,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.bizElevateWellnessJourney,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppLocalizations.of(context)!.bizUnlockPremiumContent,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 6.h,
                    children: [
                      _benefitChip(AppLocalizations.of(context)!.bizUnlimitedContent),
                      _benefitChip(AppLocalizations.of(context)!.bizExpertTips),
                      _benefitChip(AppLocalizations.of(context)!.bizAdFree),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Image.asset(
              'assets/icons/png/wellness_logo.png',
              width: 80.w,
              height: 80.w,
              opacity: const AlwaysStoppedAnimation(0.9),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefitChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
    final l10n = AppLocalizations.of(context)!;
    final buttonText = isCurrentPlan ? l10n.bizCurrentPlan : (isUpgrade ? l10n.bizUpgradeNow : l10n.bizSubscribeNow);
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: context.textPrimaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Transaction History',
            onPressed: () => context.pushNamed(RouteNames.transactionHistory),
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
            return _SubscriptionShimmer(isDarkMode: isDarkMode);
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
                // Hero banner
                if (!isSubscriptionActive) _buildHeroBanner(isDarkMode, theme),
                if (!isSubscriptionActive) SizedBox(height: 24.h),

                Text(
                  isSubscriptionActive ? 'Your Subscription' : 'Choose Your Plan',
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

class _SubscriptionShimmer extends StatelessWidget {
  final bool isDarkMode;
  const _SubscriptionShimmer({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final base = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlight = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Hero banner placeholder
            Container(
              height: 140.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Carousel placeholder
            Container(
              height: 260.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            SizedBox(height: 24.h),
            // CTA button placeholder
            Container(
              height: 52.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
