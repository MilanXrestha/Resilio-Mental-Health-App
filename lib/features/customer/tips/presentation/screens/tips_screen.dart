import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/tip_entity.dart';
import '../bloc/tip_bloc.dart';
import '../bloc/tip_event.dart';
import '../bloc/tip_state.dart';
import '../widgets/tip_card_widget.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create a fresh TipBloc from the service locator — never try to read
      // one from the parent context, since this screen can be pushed as a
      // standalone route where no TipBloc provider exists above it.
      create: (_) => getIt<TipBloc>()..add(const LoadFeaturedTips(limit: 20)),
      child: const _TipsView(),
    );
  }
}

class _TipsView extends StatelessWidget {
  const _TipsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Wellness Tips',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: context.backgroundColor,
      ),
      body: BlocBuilder<TipBloc, TipState>(
        builder: (context, state) {
          // Loading
          if (state is TipLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.primaryColor,
              ),
            );
          }

          // Error
          if (state is TipError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.r,
                      color: Colors.red.shade300,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Failed to load tips',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Loaded
          if (state is TipLoaded) {
            if (state.tips.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 64.r,
                      color: context.textSecondaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No tips available',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TipBloc>().add(RefreshTips());
              },
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.tips.length,
                itemBuilder: (context, index) {
                  final tip = state.tips[index];
                  return TipCardWidget(
                    tip: tip,
                    onTap: () => _showTipDetail(context, tip),
                  );
                },
              ),
            );
          }

          // Default
          return Container();
        },
      ),
    );
  }

  void _showTipDetail(BuildContext context, TipEntity tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TipDetailSheet(tip: tip),
    );
  }
}

class _TipDetailSheet extends StatelessWidget {
  final TipEntity tip;

  const _TipDetailSheet({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getGradientColorForType(context),
            _getGradientColorForType(context).withOpacity(0.85),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Type badge
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tip.tipTypeString,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              if (tip.isFeatured) ...[
                SizedBox(width: 8.w),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber.shade300,
                  size: 24.r,
                ),
              ],
            ],
          ),

          SizedBox(height: 16.h),

          // Title
          Text(
            tip.title,
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Tip content
          Text(
            tip.tipText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.95),
              height: 1.6,
            ),
          ),

          if (tip.author.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Divider(color: Colors.white.withOpacity(0.3)),
            SizedBox(height: 16.h),
            Row(
              children: [
                if (tip.authorIconUrl.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(tip.authorIconUrl),
                    onBackgroundImageError: (_, __) => null,
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.author,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Wellness Expert',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Color _getGradientColorForType(BuildContext context) {
    switch (tip.tipType) {
      case TipType.relationshipBooster:
        return const Color(0xFFFF6B6B);
      case TipType.lettingGo:
        return const Color(0xFF4ECDC4);
      case TipType.communication:
        return const Color(0xFFFFE66D);
      case TipType.selfCare:
        return const Color(0xFF95E1D3);
      case TipType.mindfulness:
        return const Color(0xFFA8E6CF);
      case TipType.general:
        return context.primaryColor;
      case TipType.unknown:
        return Colors.grey.shade600;
    }
  }
}
