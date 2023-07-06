import 'dart:convert';

import 'package:brick_app/widgets/HomePage.dart';
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(
                        255, 15, 15, 1), // Background color
                  ),
                  onPressed: (() {
                    setEnd();
                    CamController.to.mode.value = MODE.MODE_SELECTION.index;
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("종료"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(42, 54, 75, 1), // Background color
                  ),
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
                  child: const RotatedBox(quarterTurns: 1, child: Text("측정"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(42, 54, 75, 1), // Background color
                  ),
                  onPressed: (() async {
                    setCapture();
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("촬영"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
