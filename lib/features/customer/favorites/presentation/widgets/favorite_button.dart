import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/services/auth_token_service.dart';
import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';
import 'package:Resilio/features/customer/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:Resilio/features/customer/favorites/presentation/bloc/favorite_event.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/favorite_state.dart';

/// Heart toggle for favorites. Uses rounded [InkWell] (not [IconButton]) so the
/// ripple matches bordered action buttons. Set [bordered] to match Share/Save chrome.
class FavoriteButton extends StatelessWidget {
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

  String? _resolveUserId(AuthState auth) {
    if (auth is AuthAuthenticated) return auth.user.id;
    final stored = getIt<AuthTokenService>().userId;
    if (stored != null && stored.isNotEmpty) return stored;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        var isFavorited = false;
        if (state is FavoritesLoaded) {
          isFavorited = state.favoriteStatusMap[contentId] ?? false;
        }

        final iconSize = size ?? 22.sp;
        final unfilled = color ?? Colors.white.withValues(alpha: 0.9);
        final iconColor = isFavorited ? Colors.redAccent : unfilled;

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
                  contentId: contentId,
                  contentType: contentType,
                ),
              );
        }

        final radius = bordered ? 16.r : 12.r;
        final heart = Icon(
          isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: iconColor,
          size: iconSize,
        );

        final child = bordered
            ? Container(
                padding: borderedPadding ?? EdgeInsets.all(12.r),
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
                padding: padding ?? EdgeInsets.all(8.r),
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
