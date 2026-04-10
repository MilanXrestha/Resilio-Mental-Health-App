import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../../../favorites/presentation/bloc/favorite_event.dart';
import '../../../favorites/presentation/bloc/favorite_state.dart';

class FavoriteScreen extends StatefulWidget {
  final Function(bool) onSearchActiveChanged;

  const FavoriteScreen({
    super.key,
    required this.onSearchActiveChanged,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: context.backgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            title: Text(
              'My Favorites',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 3.h,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: context.primaryColor,
                  labelColor: context.primaryColor,
                  unselectedLabelColor: context.textSecondaryColor.withOpacity(0.6),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  tabAlignment: TabAlignment.start,
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Audio'),
                    Tab(text: 'Videos'),
                    Tab(text: 'Quotes'),
                    Tab(text: 'Tips'),
                    Tab(text: 'Images'),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return _buildEmptyState();
              }

              return TabBarView(
                controller: _tabController,
                children: [
                  _buildFavoriteGrid(state.favorites, FavoriteType.audio),
                  _buildFavoriteGrid(state.favorites, FavoriteType.video),
                  _buildFavoriteGrid(state.favorites, FavoriteType.quote),
                  _buildFavoriteGrid(state.favorites, FavoriteType.tip),
                  _buildFavoriteGrid(state.favorites, FavoriteType.image),
                ],
              );
            }

            if (state is FavoriteError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_rounded,
              size: 64.sp,
              color: context.primaryColor.withOpacity(0.4),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Nothing here yet',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Tap the heart icon on any content to save it to your favorites.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteGrid(List<FavoriteEntity> allFavorites, FavoriteType type) {
    final filtered = allFavorites.where((f) => f.contentType == type).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForType(type),
              size: 48.sp,
              color: context.textSecondaryColor.withOpacity(0.2),
            ),
            SizedBox(height: 12.h),
            Text(
              'No favorite ${type.name} yet',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: context.textSecondaryColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: type == FavoriteType.quote || type == FavoriteType.tip ? 1.0 : 0.8,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final favorite = filtered[index];
        return _buildFavoriteCard(favorite);
      },
    );
  }

  Widget _buildFavoriteCard(FavoriteEntity favorite) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    color: context.primaryColor.withOpacity(0.1),
                    child: Icon(
                      _getIconForType(favorite.contentType),
                      size: 32.sp,
                      color: context.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${favorite.contentId.substring(0, 8)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Added ${timeago(favorite.createdAt)}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: context.textSecondaryColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 4.r,
              right: 4.r,
              child: IconButton(
                icon: Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 18.sp),
                onPressed: () {
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context.read<FavoriteBloc>().add(ToggleFavorite(
                          userId: authState.user.id,
                          contentId: favorite.contentId,
                          contentType: favorite.contentType,
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(FavoriteType type) {
    switch (type) {
      case FavoriteType.audio:
        return Icons.music_note_rounded;
      case FavoriteType.video:
      case FavoriteType.longVideo:
      case FavoriteType.shortVideo:
        return Icons.play_circle_filled_rounded;
      case FavoriteType.quote:
        return Icons.format_quote_rounded;
      case FavoriteType.tip:
        return Icons.lightbulb_rounded;
      case FavoriteType.image:
        return Icons.image_rounded;
    }
  }

  String timeago(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}
