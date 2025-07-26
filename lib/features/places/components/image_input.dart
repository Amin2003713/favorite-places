import 'package:favorite_places/main.dart';
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() async {
    //   final imagePicker = ImagePicker();
    //   var image = await imagePicker.pickImage(
    //     source: ImageSource.camera,
    //     maxWidth: 600,
    //     maxHeight: 600,
    //     preferredCameraDevice: CameraDevice.rear,
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: theme.colorScheme.onPrimary),
      ),
      child: IconButton(onPressed: () => {}, icon: Icon(Icons.upload_file)),
    );
  }
}
