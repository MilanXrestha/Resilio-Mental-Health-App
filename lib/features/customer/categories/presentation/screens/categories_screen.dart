import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/category_card_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryEntity? selectedCategory;
  final ValueChanged<bool>? onSearchActiveChanged;

  const CategoryScreen({
    super.key,
    this.selectedCategory,
    this.onSearchActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<CategoryBloc>();
        // Add the event in post-frame callback to ensure widget is mounted
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            bloc.add(const LoadCategoriesEvent());
          }
        });
        return bloc;
      },
      child: CategoryView(
        selectedCategory: selectedCategory,
        onSearchActiveChanged: onSearchActiveChanged,
      ),
    );
  }
}

class CategoryView extends StatefulWidget {
  final CategoryEntity? selectedCategory;
  final ValueChanged<bool>? onSearchActiveChanged;

  const CategoryView({
    super.key,
    this.selectedCategory,
    this.onSearchActiveChanged,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  final ValueNotifier<bool> _isSearchActive = ValueNotifier(false);
  final FocusNode _searchFocusNode = FocusNode();
  int _crossAxisCount = 2;
  static const String _gridLayoutKey = 'category_grid_layout';

  @override
  void initState() {
    super.initState();
    _loadGridLayout();
    _searchController.addListener(_onSearchTextChanged);
    _searchFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchFocusNode.removeListener(_onFocusChanged);
    _searchFocusNode.dispose();
    _searchController.dispose();
    _searchQuery.dispose();
    _isSearchActive.dispose();
    super.dispose();
  }

  Future<void> _loadGridLayout() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _crossAxisCount = prefs.getInt(_gridLayoutKey) ?? 2;
    });
  }

  Future<void> _saveGridLayout(int crossAxisCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_gridLayoutKey, crossAxisCount);
  }

  void _toggleGridView() {
    setState(() {
      _crossAxisCount = _crossAxisCount % 3 + 1;
      _saveGridLayout(_crossAxisCount);
    });
  }

  void _onSearchTextChanged() {
    _searchQuery.value = _searchController.text.toLowerCase();
  }

  void _onFocusChanged() {
    if (_searchFocusNode.hasFocus != _isSearchActive.value) {
      setState(() {
        _isSearchActive.value = _searchFocusNode.hasFocus;
        widget.onSearchActiveChanged?.call(!_searchFocusNode.hasFocus);
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive.value = !_isSearchActive.value;
      widget.onSearchActiveChanged?.call(!_isSearchActive.value);
      if (!_isSearchActive.value) {
        _searchController.clear();
        _searchQuery.value = '';
        FocusScope.of(context).unfocus();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _searchFocusNode.requestFocus();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          if (_isSearchActive.value) {
            _toggleSearch();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildAppBar(),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 2.h,
                      ),
                      sliver: _buildContent(state),
                    );
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 80.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 64.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: _isSearchActive,
            builder: (context, isSearchActive, child) {
              return Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF121212)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: Theme.of(context).brightness == Brightness.dark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: IconButton(
                        icon: isSearchActive
                            ? const Icon(
                                Icons.chevron_left,
                                size: 30,
                              )
                            : SvgPicture.asset(
                                'assets/icons/svg/ic_search.svg',
                                width: 24.sp,
                                height: 24.sp,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade700,
                                  BlendMode.srcIn,
                                ),
                              ),
                        onPressed: _toggleSearch,
                        tooltip: isSearchActive ? 'Close Search' : 'Search',
                      ),
                    ),
                    Expanded(
                      child: isSearchActive
                          ? TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                              decoration: InputDecoration(
                                hintText: 'Search categories...',
                                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade600,
                                    ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: false,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 4.w,
                                ),
                                suffixIcon: ValueListenableBuilder<String>(
                                  valueListenable: _searchQuery,
                                  builder: (context, searchQuery, child) {
                                    return searchQuery.isNotEmpty
                                        ? IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/icons/svg/ic_clear.svg',
                                              width: 24.sp,
                                              height: 24.sp,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).brightness == Brightness.dark
                                                    ? Colors.grey.shade400
                                                    : Colors.grey.shade700,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            onPressed: () {
                                              _searchController.clear();
                                              _searchQuery.value = '';
                                            },
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'Categories',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                    ),
                    if (!isSearchActive)
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/svg/ic_grid.svg',
                          width: 24.sp,
                          height: 24.sp,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: _toggleGridView,
                        tooltip: 'Toggle Grid View',
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerUI(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: _crossAxisCount == 1 ? 2.0 : 0.8,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return Shimmer.fromColors(
          baseColor: isDarkMode
              ? const Color(0xFF1E1E1E)
              : const Color(0xFFF5F5F5),
          highlightColor: isDarkMode
              ? const Color(0xFF2C2C2C)
              : Colors.white,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                width: 1.w,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E1E1E)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        );
      }, childCount: 6),
    );
  }

  Widget _buildContent(CategoryState state) {
    if (state is CategoryLoading) {
      return _buildShimmerUI(context);
    }

    if (state is CategoryError) {
      return SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/no_data.json',
              width: 250.w,
              height: 250.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.h),
            Text(
              'Error loading categories. Please try again.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 16.sp,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context.read<CategoryBloc>().add(const LoadCategoriesEvent());
              },
              child: Text(
                'Retry',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    if (state is CategoryLoaded) {
      return ValueListenableBuilder<String>(
        valueListenable: _searchQuery,
        builder: (context, searchQuery, child) {
          final filteredCategories = state.categories
              .where(
                (category) => category.name.toLowerCase().contains(searchQuery),
              )
              .toList();

          if (filteredCategories.isEmpty) {
            return SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/no_data.json',
                      width: 250.w,
                      height: 250.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No categories found. Try adjusting your search.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade400
                                : Colors.black87,
                            fontSize: 14.sp,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: _crossAxisCount == 1 ? 2.0 : 0.8,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final category = filteredCategories[index];
              final fontSize = _crossAxisCount == 1
                  ? 18.sp
                  : _crossAxisCount == 2
                      ? 16.sp
                      : 14.sp;

              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      RouteNames.categoryDetail,
                      extra: CategoryCardEntity(
                        id: category.id,
                        name: category.name,
                        imageUrl: category.imageUrl,
                        description: category.description,
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: category.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          child: Icon(
                            Icons.image_not_supported,
                            size: 30.sp,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 10.w,
                        right: 10.w,
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 4.r,
                                offset: Offset(1.w, 1.h),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: filteredCategories.length),
          );
        },
      );
    }

    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
