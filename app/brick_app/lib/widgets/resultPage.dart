import 'package:brick_app/HomeScreen.dart';
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
                  onPressed: (() {
                    setEnd();
                    CamController.to.mode.value = MODE.MODE_SELECTION.index;
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("End"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
