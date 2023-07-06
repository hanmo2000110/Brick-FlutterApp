import 'package:brick_app/functions/functions.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import '../controller/cameraController.dart';

get calibrationPage => Expanded(
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
                  onPressed: (() {
                    setCapture();
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("촬영"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
