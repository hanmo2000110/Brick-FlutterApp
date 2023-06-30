import 'dart:convert';

import 'package:brick_app/HomeScreen.dart';
import 'package:brick_app/controller/cameraController.dart';
import 'package:brick_app/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Uri url = Uri.parse('http://34.71.86.212:5000/get-measured-image');

get measurementPage => Expanded(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() {
                    setEnd();
                    CamController.to.mode.value = MODE.MODE_SELECTION.index;
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("End"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() async {
                    while (true) {
                      var response = await http.get(url);
                      if (response.statusCode == 200) {
                        final jsonData = jsonDecode(response.body);
                        List<int> imageData =
                            List<int>.from(jsonData['image_data']);
                        // List<int> imageData = response.bodyBytes;
                        CamController.to.img =
                            Image.memory(Uint8List.fromList(imageData));
                        CamController.to.mode.value = MODE.RESULT.index;
                        break;
                      } else {
                        // Request failed
                        print(
                            'Failed to retrieve image. Error: ${response.statusCode}');
                      }
                    }
                    CamController.to.mode.value = MODE.RESULT.index;
                  }),
                  child: const RotatedBox(
                      quarterTurns: 1, child: Text("Measure"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() async {
                    setCapture();
                  }),
                  child: const RotatedBox(
                      quarterTurns: 1, child: Text("Capture"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
