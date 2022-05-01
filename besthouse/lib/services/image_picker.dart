import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<List<File>?> getImagesFromGallery() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      return pickedImages.map((e) => File(e.path)).toList();
    }
    return null;
  }
}
