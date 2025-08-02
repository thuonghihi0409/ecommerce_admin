import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerService {
  final ImagePicker _picker = ImagePicker();

  ///  Xin quyền truy cập thư viện (Android)
  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }

  ///  Chọn 1 ảnh từ thư viện
  Future<String?> pickSingleImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return pickedFile?.path;
  }

  ///  Chọn nhiều ảnh từ thư viện
  Future<List<String>> pickMultipleImagesFromGallery() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 80,
    );
    return pickedFiles.map((file) => file.path).toList();
  }

  ///  Chụp ảnh từ camera
  Future<String?> captureImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    return pickedFile?.path;
  }

  /// Chọn video từ thư viện
  Future<String?> pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    return video?.path;
  }

  ///  Chọn nhiều loại file (tùy chọn thêm)
  Future<List<String>> pickFiles({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions ?? ['jpeg', 'png', 'mp4'],
    );

    if (result != null) {
      return result.paths.whereType<String>().toList();
    } else {
      log('Người dùng không chọn tệp nào.');
      return [];
    }
  }
}
