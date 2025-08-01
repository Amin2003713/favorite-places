import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSave});

  final void Function(File value) onSave;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  Future<void> takePicture() async {
    try {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        maxHeight: 600,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (imageFile == null) return;

      setState(() {
        selectedImage = File(imageFile.path);
      });

      widget.onSave(selectedImage!);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to take picture: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Image',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            alignment: Alignment.center,
            child: selectedImage == null
                ? Text(
                    "No image selected",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  )
                : Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
          ),
        ),

        const SizedBox(height: 12),
        IconButton.filledTonal(
          onPressed: takePicture,
          icon: const Icon(Icons.camera_alt),
          tooltip: selectedImage == null ? "Take Picture" : "Retake Picture",
          style: IconButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
