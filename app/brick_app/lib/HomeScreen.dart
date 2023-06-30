import 'dart:convert';
import 'package:brick_app/widgets/calibrationPage.dart';
import 'package:brick_app/widgets/measurementPage.dart';
import 'package:brick_app/widgets/stackTexts.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/cameraController.dart';
import 'functions/functions.dart';
import 'widgets/modeSelectionPage.dart';
import 'widgets/modelingPage.dart';
import 'package:http/http.dart' as http;

import 'widgets/resultPage.dart';

late List<CameraDescription> cameras;

enum MODE { MODE_SELECTION, CALIBRATION, MODELING, MEASUREMENT, RESULT }

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  // late StreamSubscription<CameraImage> _imageStreamSubscription;
  int calib = 0;
  int baseline = 0;
  int modeling = 0;
  dynamic data;
  var url;
  @override
  void initState() {
    super.initState();

    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _imageStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brick Height Measurement')),
      body: Obx(
        () => Column(
          children: [
            if (CamController.to.mode.value != MODE.RESULT.index) ...{
              Stack(
                children: [
                  CameraPreview(_controller),
                  if (CamController.to.mode.value ==
                      MODE.CALIBRATION.index) ...{
                    calibTitle,
                    calibNum(data),
                  } else if (CamController.to.mode.value ==
                      MODE.MODELING.index) ...{
                    modelingTitle,
                    baselineNum(data),
                    modelingNum(data),
                  } else if (CamController.to.mode.value ==
                      MODE.MEASUREMENT.index) ...{
                    measurementTitle,
                  }
                ],
              ),
            } else ...{
              CamController.to.img,
            },
            const SizedBox(height: 10),
            if (CamController.to.mode.value == MODE.MODE_SELECTION.index)
              modeSelectionPage,
            if (CamController.to.mode.value == MODE.CALIBRATION.index)
              calibrationPage,
            if (CamController.to.mode.value == MODE.MODELING.index)
              modelingPage,
            if (CamController.to.mode.value == MODE.MEASUREMENT.index)
              measurementPage,
            if (CamController.to.mode.value == MODE.RESULT.index) resultPage,
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _initializeCamera() async {
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg);

    await _controller.initialize().then((value) {
      setState(() {});
    });

    if (_controller.value.isInitialized) {
      // Start the image stream
      _controller.startImageStream((CameraImage image) async {
        // Process the image and send it to the server
        if (CamController.to.mode.value == MODE.CALIBRATION.index ||
            CamController.to.mode.value == MODE.MODELING.index) {
          url = Uri.parse('http://34.71.86.212:5000/get-calib');
          if (CamController.to.mode.value == MODE.MODELING.index)
            url = Uri.parse('http://34.71.86.212:5000/get-modeling');
          var response = await http.get(url);
          if (response.statusCode == 200) {
            setState(() {
              data = json.decode(response.body);
            });
          } else {
            print(
                'Failed to fetch heights. Status code: ${response.statusCode}');
          }
        }
        if (CamController.to.mode.value == 1 ||
            CamController.to.mode.value == 2) {
          url = Uri.parse('http://34.71.86.212:5000/get-mode');
          var response = await http.get(url);
          if (response.statusCode == 200) {
            var t = json.decode(response.body);
            if (t['mode'] == 0) {
              CamController.to.mode.value = MODE.MODE_SELECTION.index;
              setEnd();
            }
          }
        }
        sendImageToServer(image);
      });
    }
  }
}
