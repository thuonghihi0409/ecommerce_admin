import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class MultiImagePickerWidget extends StatefulWidget {
  final Function(List<Uint8List>)? onSuccess;
  final bool allowMultiple;
  final bool isShowDescription;

  const MultiImagePickerWidget(
      {super.key,
      this.allowMultiple = true,
      this.onSuccess,
      this.isShowDescription = true});

  @override
  State<MultiImagePickerWidget> createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  List<Uint8List> _imageBytesList = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    List<XFile> files = [];

    if (widget.allowMultiple) {
      if (kIsWeb) {
        // pickMultiImage() on web allows multi selection
        files = await picker.pickMultiImage(imageQuality: 80);
      } else {
        files = await picker.pickMultiImage(imageQuality: 80);
      }
    } else {
      final singleFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (singleFile != null) {
        files.add(singleFile);
      }
    }

    for (final file in files) {
      final bytes = await file.readAsBytes();
      if (!widget.allowMultiple) {
        _imageBytesList = [];
      }
      setState(() {
        _imageBytesList.add(bytes);
      });
    }
    widget.onSuccess?.call(_imageBytesList);
  }

  void _removeImage(int index) {
    setState(() {
      _imageBytesList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          child: InkWell(
            onTap: _pickImages,
            child: Container(
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Nhấn để chọn ảnh"),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_imageBytesList.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_imageBytesList.length, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytesList[index],
                          width: 250,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (widget.allowMultiple)
                    const SizedBox(
                      width: 250,
                      child: CustomTextField(
                        contentPadding: EdgeInsets.all(1),
                        hintText: "Mo ta",
                      ),
                    )
                ],
              );
            }),
          )
      ],
    );
  }
}
