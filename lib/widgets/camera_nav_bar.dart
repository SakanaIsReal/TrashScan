import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'info_sheet.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CameraNavBar extends StatelessWidget {
  final CameraController cameraController;

  const CameraNavBar({required this.cameraController, super.key});

  @override
  Widget build(BuildContext context) {
    return _CameraNavBarStateful(cameraController: cameraController);
  }
}

class _CameraNavBarStateful extends StatefulWidget {
  final CameraController cameraController;
  const _CameraNavBarStateful({required this.cameraController});

  @override
  State<_CameraNavBarStateful> createState() => _CameraNavBarState();
}

class _CameraNavBarState extends State<_CameraNavBarStateful> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: _isUploading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.camera_alt, size: 36, color: Colors.black),
              onPressed: _isUploading ? null : _captureAndUpload,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndUpload() async {
    setState(() => _isUploading = true);

    try {
      final image = await widget.cameraController.takePicture();

      final uri = Uri.parse(
          'https://yolo-server-511756204750.asia-southeast1.run.app/predict');
      final request = http.MultipartRequest('POST', uri);


      request.fields['secret_key'] = 'b2a83fdc5d934e198ac94ee3e46d45d0';
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('📦 Server Response: $responseBody');
       final json = jsonDecode(responseBody);
      final int? classId = json['class_id'];

      if (classId != null) {
        showModalBottomSheet(
          context: context,
          constraints: const BoxConstraints(maxHeight: 1400),
          showDragHandle: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return InfoSheet(
              type: InfoSheetType.information,
              trash_id: classId, 
            );
          },
        );
      } else {
        showModalBottomSheet(
          context: context,
          constraints: const BoxConstraints(maxHeight: 1400),
          showDragHandle: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return InfoSheet(
              type: InfoSheetType.error,
              trash_id: 0, 
            );
          },
        );
      }
    } catch (e) {
      print('❌ Upload failed: $e');
    }

    setState(() => _isUploading = false);
  }
}
