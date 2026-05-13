import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_content_cubit.dart';
import '../bloc/admin_content_state.dart';
import 'widgets/admin_widgets.dart';
import 'widgets/content_form_dialog.dart';

class AdminContentScreen extends StatefulWidget {
  const AdminContentScreen({super.key});

  @override
  State<AdminContentScreen> createState() => _AdminContentScreenState();
}

class _AdminContentScreenState extends State<AdminContentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchControllers = List.generate(5, (_) => TextEditingController());

  final _tabs = const [
    _TabInfo('Tips', Icons.lightbulb_outline_rounded, Color(0xFF10B981)),
    _TabInfo('Quotes', Icons.format_quote_rounded, Color(0xFF6366F1)),
    _TabInfo('Audio', Icons.headphones_rounded, Color(0xFFF59E0B)),
    _TabInfo('Video', Icons.videocam_rounded, Color(0xFFEC4899)),
    _TabInfo('Images', Icons.image_rounded, Color(0xFF0EA5E9)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<AdminContentCubit>().setTab(_tabController.index);
        _loadCurrentTab(_tabController.index);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCurrentTab(0));
  }

  void _loadCurrentTab(int i) {
    final cubit = context.read<AdminContentCubit>();
    switch (i) {
      case 0: cubit.loadTips(); break;
      case 1: cubit.loadQuotes(); break;
      case 2: cubit.loadAudio(); break;
      case 3: cubit.loadVideos(); break;
      case 4: cubit.loadImages(); break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final c in _searchControllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Content Management', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicator: BoxDecoration(
            color: _tabs[_tabController.index].color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w500),
          labelColor: _tabs[_tabController.index].color,
          unselectedLabelColor: context.textSecondaryColor,
          dividerColor: Colors.transparent,
          tabs: _tabs.map((t) => Tab(
            child: Row(
              children: [
                Icon(t.icon, size: 16.sp),
                SizedBox(width: 6.w),
                Text(t.label),
              ],
            ),
          )).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: _tabs[_tabController.index].color,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Add ${_tabs[_tabController.index].label}', style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TipsTab(searchController: _searchControllers[0]),
          _QuotesTab(searchController: _searchControllers[1]),
          _AudioTab(searchController: _searchControllers[2]),
          _VideoTab(searchController: _searchControllers[3]),
          _ImagesTab(searchController: _searchControllers[4]),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminContentCubit>(),
        child: ContentFormDialog(
          contentType: _tabs[_tabController.index].label.toLowerCase(),
          onSave: (data) async {
            final cubit = context.read<AdminContentCubit>();
            bool ok = false;
            switch (_tabController.index) {
              case 0: ok = await cubit.createTip(data); break;
              case 1: ok = await cubit.createQuote(data); break;
              case 2: ok = await cubit.createAudio(data); break;
              case 3: ok = await cubit.createVideo(data); break;
              case 4: ok = await cubit.createImage(data); break;
            }
            if (ok && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${_tabs[_tabController.index].label} created! 🚀'), backgroundColor: _tabs[_tabController.index].color, behavior: SnackBarBehavior.floating),
              );
            }
          },
        ),
      ),
    );
  }
}

// ─── Tips Tab ────────────────────────────────────────
class _TipsTab extends StatelessWidget {
  final TextEditingController searchController;
  const _TipsTab({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContentCubit, AdminContentState>(
      builder: (context, state) {
        final tips = state.maybeMap(loaded: (s) => s.tips, orElse: () => <dynamic>[]);
        final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: AdminSearchBar(
                controller: searchController,
                hint: 'Search tips...',
                onChanged: (v) => context.read<AdminContentCubit>().loadTips(search: v),
                onClear: () => context.read<AdminContentCubit>().loadTips(),
              ),
            ),
            Expanded(child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : tips.isEmpty
                ? AdminEmptyState(icon: Icons.lightbulb_outline_rounded, title: 'No tips yet', subtitle: 'Add your first tip with the + button')
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: tips.length,
                    itemBuilder: (_, i) => _ContentCard(
                      item: tips[i],
                      icon: Icons.lightbulb_rounded,
                      color: const Color(0xFF10B981),
                      titleKey: 'title',
                      subtitleKey: 'tip_text',
                      badgeKey: 'tip_type',
                      onDelete: (id) => context.read<AdminContentCubit>().deleteTip(id),
                      onEdit: (item) => _showEditDialog(context, item),
                    ),
                  )),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminContentCubit>(),
        child: ContentFormDialog(
          contentType: 'tips',
          existingData: item,
          onSave: (data) async => context.read<AdminContentCubit>().updateTip(item['id'], data),
        ),
      ),
    );
  }
}

// ─── Quotes Tab ───────────────────────────────────────
class _QuotesTab extends StatelessWidget {
  final TextEditingController searchController;
  const _QuotesTab({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContentCubit, AdminContentState>(
      builder: (context, state) {
        final quotes = state.maybeMap(loaded: (s) => s.quotes, orElse: () => <dynamic>[]);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: AdminSearchBar(controller: searchController, hint: 'Search quotes...', onChanged: (v) => context.read<AdminContentCubit>().loadQuotes(search: v), onClear: () => context.read<AdminContentCubit>().loadQuotes()),
            ),
            Expanded(child: quotes.isEmpty
              ? AdminEmptyState(icon: Icons.format_quote_rounded, title: 'No quotes yet')
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: quotes.length,
                  itemBuilder: (_, i) => _ContentCard(
                    item: quotes[i],
                    icon: Icons.format_quote_rounded,
                    color: const Color(0xFF6366F1),
                    titleKey: 'quote_text',
                    subtitleKey: 'author',
                    badgeKey: 'quote_type',
                    onDelete: (id) => context.read<AdminContentCubit>().deleteQuote(id),
                    onEdit: (item) => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AdminContentCubit>(),
                        child: ContentFormDialog(contentType: 'quotes', existingData: item, onSave: (d) async => context.read<AdminContentCubit>().updateQuote(item['id'], d)),
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}

// ─── Audio Tab ────────────────────────────────────────
class _AudioTab extends StatelessWidget {
  final TextEditingController searchController;
  const _AudioTab({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContentCubit, AdminContentState>(
      builder: (context, state) {
        final audio = state.maybeMap(loaded: (s) => s.audio, orElse: () => <dynamic>[]);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: AdminSearchBar(controller: searchController, hint: 'Search audio...', onChanged: (v) => context.read<AdminContentCubit>().loadAudio(search: v), onClear: () => context.read<AdminContentCubit>().loadAudio()),
            ),
            Expanded(child: audio.isEmpty
              ? AdminEmptyState(icon: Icons.headphones_rounded, title: 'No audio tracks yet')
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: audio.length,
                  itemBuilder: (_, i) => _ContentCard(
                    item: audio[i],
                    icon: Icons.headphones_rounded,
                    color: const Color(0xFFF59E0B),
                    titleKey: 'title',
                    subtitleKey: 'artist_name',
                    badgeKey: 'is_featured',
                    onDelete: (id) => context.read<AdminContentCubit>().deleteAudio(id),
                    onEdit: (item) => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AdminContentCubit>(),
                        child: ContentFormDialog(contentType: 'audio', existingData: item, onSave: (d) async => context.read<AdminContentCubit>().updateAudio(item['id'], d)),
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}

// ─── Video Tab ────────────────────────────────────────
class _VideoTab extends StatelessWidget {
  final TextEditingController searchController;
  const _VideoTab({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContentCubit, AdminContentState>(
      builder: (context, state) {
        final videos = state.maybeMap(loaded: (s) => s.videos, orElse: () => <dynamic>[]);
        final vtFilter = state.maybeMap(loaded: (s) => s.videoTypeFilter, orElse: () => 'all');

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Column(
                children: [
                  AdminSearchBar(controller: searchController, hint: 'Search videos...', onChanged: (v) => context.read<AdminContentCubit>().loadVideos(search: v, videoType: vtFilter), onClear: () => context.read<AdminContentCubit>().loadVideos(videoType: vtFilter)),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      AdminFilterChip(label: 'All', isSelected: vtFilter == 'all', onTap: () => context.read<AdminContentCubit>().loadVideos(videoType: 'all'), selectedColor: const Color(0xFFEC4899)),
                      SizedBox(width: 8.w),
                      AdminFilterChip(label: '⚡ Shorts', isSelected: vtFilter == 'short', onTap: () => context.read<AdminContentCubit>().loadVideos(videoType: 'short'), selectedColor: const Color(0xFFEC4899)),
                      SizedBox(width: 8.w),
                      AdminFilterChip(label: '🎬 Long', isSelected: vtFilter == 'long', onTap: () => context.read<AdminContentCubit>().loadVideos(videoType: 'long'), selectedColor: const Color(0xFFEC4899)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: videos.isEmpty
              ? AdminEmptyState(icon: Icons.videocam_rounded, title: 'No videos yet')
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: videos.length,
                  itemBuilder: (_, i) => _ContentCard(
                    item: videos[i],
                    icon: Icons.videocam_rounded,
                    color: const Color(0xFFEC4899),
                    titleKey: 'title',
                    subtitleKey: 'video_type',
                    badgeKey: 'video_type',
                    onDelete: (id) => context.read<AdminContentCubit>().deleteVideo(id),
                    onEdit: (item) => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AdminContentCubit>(),
                        child: ContentFormDialog(contentType: 'videos', existingData: item, onSave: (d) async => context.read<AdminContentCubit>().updateVideo(item['id'], d)),
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}

// ─── Images Tab ───────────────────────────────────────
class _ImagesTab extends StatelessWidget {
  final TextEditingController searchController;
  const _ImagesTab({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContentCubit, AdminContentState>(
      builder: (context, state) {
        final images = state.maybeMap(loaded: (s) => s.images, orElse: () => <dynamic>[]);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: AdminSearchBar(controller: searchController, hint: 'Search images...', onChanged: (v) => context.read<AdminContentCubit>().loadImages(search: v), onClear: () => context.read<AdminContentCubit>().loadImages()),
            ),
            Expanded(child: images.isEmpty
              ? AdminEmptyState(icon: Icons.image_rounded, title: 'No images yet')
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: images.length,
                  itemBuilder: (_, i) => _ContentCard(
                    item: images[i],
                    icon: Icons.image_rounded,
                    color: const Color(0xFF0EA5E9),
                    titleKey: 'title',
                    subtitleKey: 'image_type',
                    badgeKey: 'is_featured',
                    onDelete: (id) => context.read<AdminContentCubit>().deleteImage(id),
                    onEdit: (item) => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AdminContentCubit>(),
                        child: ContentFormDialog(contentType: 'images', existingData: item, onSave: (d) async => context.read<AdminContentCubit>().updateImage(item['id'], d)),
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}

// ─── Shared Content Card ──────────────────────────────
class _ContentCard extends StatelessWidget {
  final dynamic item;
  final IconData icon;
  final Color color;
  final String titleKey;
  final String subtitleKey;
  final String badgeKey;
  final Future<bool> Function(String id) onDelete;
  final void Function(dynamic item) onEdit;

  const _ContentCard({
    required this.item,
    required this.icon,
    required this.color,
    required this.titleKey,
    required this.subtitleKey,
    required this.badgeKey,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final title = item[titleKey]?.toString() ?? 'Untitled';
    final subtitle = item[subtitleKey]?.toString() ?? '';
    final badgeVal = item[badgeKey];
    final badge = badgeVal is bool ? (badgeVal ? 'Featured' : '') : badgeVal?.toString() ?? '';
    final thumbnail = item['thumbnail_url'] as String? ?? item['cover_image_url'] as String? ?? item['image_url'] as String?;
    final isPremium = item['is_premium'] as bool? ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: thumbnail != null && thumbnail.isNotEmpty
                ? Image.network(thumbnail, width: 52.w, height: 52.w, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _IconBox(icon: icon, color: color))
                : _IconBox(icon: icon, color: color),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor), maxLines: 2, overflow: TextOverflow.ellipsis),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(subtitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (badge.isNotEmpty) AdminStatusBadge(label: badge.toUpperCase(), color: color),
                    if (isPremium) ...[
                      SizedBox(width: 6.w),
                      AdminStatusBadge(label: 'PREMIUM', color: const Color(0xFF8B5CF6)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.edit_rounded, size: 18.sp, color: context.primaryColor),
                onPressed: () => onEdit(item),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline_rounded, size: 18.sp, color: const Color(0xFFEF4444)),
                onPressed: () => _confirmDelete(context),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Delete Content', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            onPressed: () async {
              context.pop();
              await onDelete(item['id']?.toString() ?? '');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBox({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
      child: Icon(icon, color: color, size: 26.sp),
    );
  }
}

class _TabInfo {
  final String label;
  final IconData icon;
  final Color color;
  const _TabInfo(this.label, this.icon, this.color);
}
