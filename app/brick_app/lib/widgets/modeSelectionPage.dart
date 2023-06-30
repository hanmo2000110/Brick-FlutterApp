import 'package:brick_app/controller/cameraController.dart';
import 'package:brick_app/functions/functions.dart';
import 'package:flutter/material.dart';

import '../HomeScreen.dart';

get modeSelectionPage => Expanded(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() {
                    // sendSpaceClicked();
                    setMode(3);
                    CamController.to.mode.value = MODE.MEASUREMENT.index;
                  }),
                  child: const RotatedBox(
                      quarterTurns: 1, child: Text("Measurement"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() {
                    setMode(2);
                    CamController.to.mode.value = MODE.MODELING.index;
                    // sendSpaceClicked();
                  }),
                  child: const RotatedBox(
                      quarterTurns: 1, child: Text("Modeling"))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: (() {
                    setMode(1);
                    CamController.to.mode.value = MODE.CALIBRATION.index;
                    // sendSpaceClicked();
                  }),
                  child: const RotatedBox(
                      quarterTurns: 1, child: Text("Calibration"))),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
