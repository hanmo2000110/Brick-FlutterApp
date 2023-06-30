import 'package:brick_app/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CamController extends GetxController {
  static CamController get to => Get.find();
  late Image img;
  late RxInt mode = 0.obs;
  List<int>? imageData;

  Future<void> onInit() async {
    super.onInit();
    mode.value = MODE.MODE_SELECTION.index;
  }

  Future<void> loadImage() async {
    try {
      final response = await http
          .get(Uri.parse("http://34.71.86.212:5000/get-measured-image"));
      if (response.statusCode == 200) {
        // Retrieve the image data as bytes
        imageData = response.bodyBytes;
      } else {
        // Request failed
        print('Failed to retrieve image. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
  }
}
