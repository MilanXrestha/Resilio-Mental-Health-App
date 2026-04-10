class GameModel {
  final String id;
  final String title;
  final String description;
  final String animationPath;
  final String type;
  final Map<String, dynamic> config;
  final int sortOrder;

  const GameModel({
    required this.id,
    required this.title,
    required this.description,
    required this.animationPath,
    required this.type,
    required this.config,
    this.sortOrder = 0,
  });
}
