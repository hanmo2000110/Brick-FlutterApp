import base64
import io
from flask import Flask, jsonify, render_template, request, send_file, render_template
import numpy as np
import cv2

app = Flask(__name__)

# Global variable to store the most recent image
streamed_image = None
end = False
capture = False
calib = 0
baseline = 0
modeling = 0
mode = 0
image_data = []


@app.route('/upload-stream', methods=['POST'])
def upload_stream():
    global streamed_image

    content_type = request.headers['Content-Type']
    if content_type != 'application/octet-stream':
        return 'Invalid content type', 400

    byte_list = bytearray()
    while True:
        chunk = request.stream.read(1024)
        if not chunk:
            break
        byte_list.extend(chunk)

    img_arr = np.frombuffer(byte_list, dtype=np.uint8)
    img = cv2.imdecode(img_arr, cv2.IMREAD_COLOR)

    streamed_image = img

    return 'Image stream received and processed'


@app.route('/get-streamed-image', methods=['GET'])
def get_streamed_image():
    global streamed_image

    if streamed_image is None:
        return 'No streamed image available', 404

    # rotated_image = cv2.rotate(streamed_image, cv2.ROTATE_90_CLOCKWISE)
    _, img_encoded = cv2.imencode('.jpg', streamed_image)

    file_object = io.BytesIO(img_encoded.tobytes())

    file_object.seek(0)
    file_object.content_type = 'image/jpeg'

    return send_file(file_object, mimetype='image/jpeg', as_attachment=True, download_name="streamed_image.jpg")

@app.route('/set-measured-image', methods=['POST'])
def process_image():
    global image_data
    frame_bytes = request.get_data()

    frame_arr = np.frombuffer(frame_bytes, np.uint8)

    frame = cv2.imdecode(frame_arr, cv2.IMREAD_COLOR)
    
    ret, jpeg = cv2.imencode('.jpg', frame)
    frame_bytes = jpeg.tobytes()

    # Convert the frame bytes to Uint8List
    image_data = list(frame_bytes)

    # Return the image data as JSON response
    return jsonify({'imageData': image_data})

#-------------------------------------Getter-----------------------------------------

@app.route('/get-mode', methods=['GET'])
def get_mode():
    global mode
    if mode == 0 :
        calib = 0
        baseline = 0
        modeling = 0
    return jsonify({'mode':mode})

@app.route('/get-calib', methods=['GET'])
def get_calib():
    global calib
    return jsonify({'calib':calib})

@app.route('/get-capture', methods=['GET'])
def get_capture():
    global capture
    result = {'capture':capture}
    capture = False
    return jsonify(result)

@app.route('/get-end', methods=['GET'])
def get_end():
    global end
    result = {'end':end}
    end = False
    return jsonify(result)

@app.route('/get-modeling', methods=['GET'])
def get_modeling():
    global modeling
    global baseline
    return jsonify({'modeling':modeling,'baseline':baseline})

@app.route('/get-measured-image', methods=['GET'])
def get_measured_image():
    global image_data
    return jsonify({'image_data':image_data})

#-------------------------------------Setter-----------------------------------------

@app.route('/set-mode', methods=['POST'])
def set_mode():
    global mode
    mode = request.get_json()['mode']
    return 'saved'

@app.route('/set-calib', methods=['POST'])
def set_calib():
    global calib
    calib = request.get_json()['calib']
    return 'saved'

@app.route('/set-capture', methods=['POST'])
def set_capture():
    global capture
    capture = request.get_json()['capture']
    return 'saved'

@app.route('/set-end', methods=['POST'])
def set_end():
    global end
    end = request.get_json()['end']
    return 'saved'

@app.route('/set-modeling', methods=['POST'])
def set_modeling():
    global modeling
    global baseline
    modeling = request.get_json()['modeling']
    baseline = request.get_json()['baseline']
    return 'saved'

@app.route('/reset', methods=['GET'])
def reset():
    global capture
    global end
    global calib
    global baseline
    global modeling
    capture = False
    end = False
    calib = 0
    baseline = 0
    modeling = 0

    return 'saved'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
