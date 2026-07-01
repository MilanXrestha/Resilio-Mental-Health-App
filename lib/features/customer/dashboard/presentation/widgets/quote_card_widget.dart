import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../domain/entities/quote_entity.dart';

class QuoteCardWidget extends StatelessWidget {
  final QuoteEntity quote;
  final VoidCallback? onTap;

  const QuoteCardWidget({
    super.key,
    required this.quote,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Explicit theme-aware surface — prevents white flash in dark mode
    final cardColor = isDarkMode
        ? const Color(0xFF1E1E2C)
        : Colors.white;

    return SizedBox(
      width: 260.w,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? cardColor.withOpacity(0.85)
                      : cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.06),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.06),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.w),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.format_quote_rounded,
                          size: 24.sp,
                          color: context.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '"${quote.quoteText}"',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            if (quote.authorIconUrl?.isNotEmpty ?? false) ...[
                              CircleAvatar(
                                radius: 10.r,
                                backgroundColor: context.primaryColor.withValues(alpha: 0.1),
                                child: ClipOval(
                                  child: Image.network(
                                    quote.authorIconUrl!,
                                    width: 20.r,
                                    height: 20.r,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Icon(
                                      Icons.person_rounded,
                                      size: 12.sp,
                                      color: context.primaryColor.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                            ],
                            Expanded(
                              child: Text(
                                '— ${quote.author}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  color: context.textSecondaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          PremiumTagWidget(
            isPremium: quote.isPremium,
            top: 12,
            right: 12,
          ),
        ],
      ),
    );
  }
}
