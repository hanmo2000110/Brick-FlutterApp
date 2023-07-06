import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'widgets/HomePage.dart';
import 'binding/binding.dart';

void main() async {
  // Initialize the camera
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brick Height Measurement',
      theme: ThemeData.dark(),
      home: CameraScreen(),
      initialBinding: InitBinding(),
    );
  }
}
