class ContentItemEntity {
  final String id;
  final String title;
  final String description;
  final String contentType;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? author;
  final DateTime createdAt;

  const ContentItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.contentType,
    this.mediaUrl,
    this.thumbnailUrl,
    this.author,
    required this.createdAt,
  });

  factory ContentItemEntity.fromMap(String type, Map<String, dynamic> data) {
    return ContentItemEntity(
      id: data['id'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      contentType: type,
      mediaUrl: data['mediaUrl'] as String?,
      thumbnailUrl: data['thumbnailUrl'] as String?,
      author: data['author'] as String?,
      createdAt: DateTime.tryParse(data['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
