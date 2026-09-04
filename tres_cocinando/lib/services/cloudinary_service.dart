import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final cloudinary = CloudinaryPublic(
    '',
    '',
    cache: false,
  );

  static Future<String?> subirImagen(
    String imagePath,
  ) async {
    try {
      final response =
          await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          //folder: '',
        ),
      );

      return response.secureUrl;
    } catch (e) {
      print(
        'Error subiendo imagen: $e',
      );

      return null;
    }
  }
}