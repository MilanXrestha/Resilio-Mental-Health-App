import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CloudinaryService {
  static const String _cloudName = 'dczb26ev1';
  static const String _uploadPreset = 'Wellness_App';

  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    _cloudName,
    _uploadPreset,
    cache: false,
  );

  /// Uploads a profile image to Cloudinary.
  /// Stored under: resilio/profile/{userId}/avatar
  /// Returns the secure URL of the uploaded image.
  Future<String> uploadProfileImage(File file, String userId) async {
    final folder = 'resilio/profile/$userId';

    final response = await _cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        file.path,
        folder: folder,
        publicId: 'avatar_${DateTime.now().millisecondsSinceEpoch}', // unique ID to bypass caching
        resourceType: CloudinaryResourceType.Image,
      ),
    );

    return response.secureUrl;
  }
}
