import 'package:flutter/material.dart';

get calibTitle => const Positioned(
      top: 20,
      right: 20,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Calibration Mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

get modelingTitle => const Positioned(
      top: 20,
      right: 20,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Modeling Mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

get measurementTitle => const Positioned(
      top: 20,
      right: 20,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Measurement Mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

get calibNum => ((data) {
      return Positioned(
        top: 20,
        left: 20,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            '# Capture: ${data['calib'] ?? 0} / 3 ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });

get baselineNum => ((data) {
      return Positioned(
        top: 20,
        left: 50,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            'Baseline: ${data['baseline'] ?? 0}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });

get modelingNum => ((data) {
      return Positioned(
        top: 20,
        left: 15,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            '# Capture: ${data['modeling'] ?? 0} / 5',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
