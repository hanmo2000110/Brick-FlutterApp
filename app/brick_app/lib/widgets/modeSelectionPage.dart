import 'package:brick_app/controller/cameraController.dart';
import 'package:brick_app/functions/functions.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

get modeSelectionPage => Expanded(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(42, 54, 75, 1), // Background color
                  ),
                  onPressed: (() {
                    // sendSpaceClicked();
                    setMode(3);
                    CamController.to.mode.value = MODE.MEASUREMENT.index;
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
                  onPressed: (() {
                    setMode(2);
                    CamController.to.mode.value = MODE.MODELING.index;
                    // sendSpaceClicked();
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("모델링"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(42, 54, 75, 1), // Background color
                  ),
                  onPressed: (() {
                    setMode(1);
                    CamController.to.mode.value = MODE.CALIBRATION.index;
                    // sendSpaceClicked();
                  }),
                  child: const RotatedBox(quarterTurns: 1, child: Text("보정"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
