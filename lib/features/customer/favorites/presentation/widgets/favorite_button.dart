import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/services/auth_token_service.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';
import 'package:Resilio/features/customer/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:Resilio/features/customer/favorites/presentation/bloc/favorite_event.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/favorite_state.dart';

/// Heart toggle for favorites. Uses rounded [InkWell] (not [IconButton]) so the
/// ripple matches bordered action buttons. Set [bordered] to match Share/Save chrome.
class FavoriteButton extends StatefulWidget {
  final String contentId;
  final FavoriteType contentType;
  final double? size;
  final Color? color;
  /// Inner padding when [bordered] is false.
  final EdgeInsetsGeometry? padding;

  /// When true, draws the same frosted border + fill as image viewer action buttons.
  final bool bordered;

  /// Padding inside the border when [bordered] is true (default 12).
  final EdgeInsetsGeometry? borderedPadding;

  const FavoriteButton({
    super.key,
    required this.contentId,
    required this.contentType,
    this.size,
    this.color,
    this.padding,
    this.bordered = false,
    this.borderedPadding,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  String? _resolveUserId(AuthState auth) {
    if (auth is AuthAuthenticated) return auth.user.id;
    final stored = getIt<AuthTokenService>().userId;
    if (stored != null && stored.isNotEmpty) return stored;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _requestStatusCheck();
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget reused for a different item (e.g. list recycling) → re-check.
    if (oldWidget.contentId != widget.contentId) {
      _requestStatusCheck();
    }
  }

  // Loads THIS item's favorite status once, regardless of bloc state. Fixes
  // the bug where only the very first heart (FavoriteInitial) ever checked,
  // leaving later hearts stuck showing an incorrect un-favorited state.
  void _requestStatusCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userId = _resolveUserId(context.read<AuthBloc>().state);
      if (userId == null || userId.isEmpty) return;
      context.read<FavoriteBloc>().add(
            CheckFavoriteStatus(
              userId: userId,
              contentId: widget.contentId,
              contentType: widget.contentType,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        var isFavorited = false;

        // Check if we have the status loaded
        if (state is FavoritesLoaded) {
          isFavorited = state.favoriteStatusMap[widget.contentId] ?? false;
        }

        final iconSize = widget.size ?? 22.sp;
        final unfilled = widget.color ?? Colors.white.withValues(alpha: 0.9);
        // Filled heart uses the theme accent so it matches both light & dark
        // backgrounds instead of a fixed red.
        final iconColor = isFavorited ? context.primaryColor : unfilled;

        void onTap() {
          final userId = _resolveUserId(context.read<AuthBloc>().state);
          if (userId == null || userId.isEmpty) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              const SnackBar(content: Text('Sign in to save favorites')),
            );
            return;
          }
          context.read<FavoriteBloc>().add(
                ToggleFavorite(
                  userId: userId,
                  contentId: widget.contentId,
                  contentType: widget.contentType,
                ),
              );
        }

        final radius = widget.bordered ? 16.r : 12.r;
        final heart = Icon(
          isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: iconColor,
          size: iconSize,
        );

        final child = widget.bordered
            ? Container(
                padding: widget.borderedPadding ?? EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: heart,
              )
            : Padding(
                padding: widget.padding ?? EdgeInsets.all(8.r),
                child: heart,
              );

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: child,
          ),
        );
      },
    );
  }
}
