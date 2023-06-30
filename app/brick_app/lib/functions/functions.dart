import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

Future<void> sendImageToServer(CameraImage image) async {
  // Convert the camera image to bytes
  var bytes = image.planes[0].bytes;
  // Make a POST request to the server with the image bytes
  var response = await http.post(
    Uri.parse(
        'http://34.71.86.212:5000/upload-stream'), // Replace with your Flask server IP address
    body: bytes,
    headers: {'Content-Type': 'application/octet-stream'},
  );

  if (response.statusCode != 200) {
    print(
        'Error sending image. Status code: ${response.statusCode} \n ${response.body}');
  }
}

List<int> cameraImageToBytes(CameraImage image) {
  // Convert the image to bytes based on the format and planes
  // You may need to adapt this code based on the specific format and planes of your camera image
  List<int> bytes = [];
  for (var plane in image.planes) {
    bytes.addAll(plane.bytes);
  }
  return bytes;
}

void setCapture() async {
  var response = await http.post(
    Uri.parse('http://34.71.86.212:5000/set-capture'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'capture': true}),
  );

  if (response.statusCode == 200) {
    print('set-capture request sent successfully');
  } else {
    print(
        'Error sending space clicked request. Status code: ${response.statusCode}');
  }
}

void setEnd() async {
  setMode(0);
  var response = await http.post(
    Uri.parse('http://34.71.86.212:5000/set-end'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'end': true}),
  );

  if (response.statusCode == 200) {
    print('set-end request sent successfully');
  } else {
    print(
        'Error sending space clicked request. Status code: ${response.statusCode}');
  }
}

void setMode(int i) async {
  var response = await http.post(
    Uri.parse('http://34.71.86.212:5000/set-mode'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'mode': i}),
  );

  if (response.statusCode == 200) {
    print('set-mode request sent successfully');
  } else {
    print(
        'Error sending space clicked request. Status code: ${response.statusCode}');
  }
}
