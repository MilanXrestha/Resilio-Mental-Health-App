import 'dart:io';

void main() async {
  final dir = Directory('lib/features/customer/games');
  
  if (!dir.existsSync()) {
    print('Directory not found');
    return;
  }
  
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (final file in files) {
    var content = await file.readAsString();
    var changed = false;
    
    final replacements = {
      'AppColors.darkTextPrimary': 'Theme.of(context).colorScheme.onSurface',
      'AppColors.lightTextPrimary': 'Theme.of(context).colorScheme.onSurface',
      'AppColors.darkTextSecondary': 'Theme.of(context).colorScheme.onSurfaceVariant',
      'AppColors.lightTextSecondary': 'Theme.of(context).colorScheme.onSurfaceVariant',
      'AppColors.darkSurface': 'Theme.of(context).colorScheme.surface',
      'AppColors.lightSurface': 'Theme.of(context).colorScheme.surface',
      'AppColors.darkBackground': 'Theme.of(context).colorScheme.background',
      'AppColors.lightBackground': 'Theme.of(context).colorScheme.background',
      'AppColors.darkTextHint': 'Theme.of(context).colorScheme.onSurface.withOpacity(0.5)',
      'AppColors.lightTextHint': 'Theme.of(context).colorScheme.onSurface.withOpacity(0.5)',
      'AppColors.primary': 'Theme.of(context).primaryColor',
      'AppColors.error': 'Theme.of(context).colorScheme.error',
      'AppColors.shadow': 'Colors.black26',
      'entry.mood': 'entry.moodLabel',
      'entry.timestamp': 'entry.createdAt',
      'Future<List<dynamic>> getUserMoodEntries': 'Future<List<MoodEntryModel>> getUserMoodEntries',
      'Future<List<dynamic>>': 'Future<List<MoodEntryModel>>',
    };
    
    for (var entry in replacements.entries) {
      if (content.contains(entry.key)) {
        content = content.replaceAll(entry.key, entry.value);
        changed = true;
      }
    }
    
    if (changed) {
      await file.writeAsString(content);
      print('Updated ${file.path}');
    }
  }
  print('Done');
}
