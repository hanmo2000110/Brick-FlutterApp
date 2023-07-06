import 'package:brick_app/widgets/HomePage.dart';
import 'package:brick_app/controller/cameraController.dart';
import 'package:brick_app/functions/functions.dart';
import 'package:flutter/material.dart';

Uri url = Uri.parse('http://34.71.86.212:5000/get-measured-image');

get resultPage => Expanded(
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
          ],
        ),
      ),
    );
