import base64
import io
from flask import Flask, jsonify, render_template, request, send_file, render_template
import numpy as np
import cv2

app = Flask(__name__)

# Global variable to store the most recent image
streamed_image = None
isEscClicked = False
isSpaceClicked = False
heightL = -1
heightR = -1
calib = 0
bottomB = 0
modeling = 0



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

    # Process the image as needed
    # Example: Convert to grayscale
    # img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Store the streamed image
    streamed_image = img

    # Return a response indicating success
    return 'Image stream received and processed'


@app.route('/get-streamed-image', methods=['GET'])
def get_streamed_image():
    global streamed_image

    if streamed_image is None:
        return 'No streamed image available', 404

    # rotated_image = cv2.rotate(streamed_image, cv2.ROTATE_90_CLOCKWISE)

    # Convert the image to JPEG
    _, img_encoded = cv2.imencode('.jpg', streamed_image)

    # Create an in-memory file-like object
    file_object = io.BytesIO(img_encoded.tobytes())

    # Set the file object's content type as image/jpeg
    file_object.seek(0)
    file_object.content_type = 'image/jpeg'

    # Return the file object as a response
    return send_file(file_object, mimetype='image/jpeg', as_attachment=True, download_name="streamed_image.jpg")


@app.route('/get-webpage', methods=['GET'])
def get_webpage():
    global streamed_image

    if streamed_image is None:
        return 'No streamed image available', 404

    # Rotate the image by 90 degrees clockwise
    rotated_image = cv2.rotate(streamed_image, cv2.ROTATE_90_CLOCKWISE)

    # Convert the rotated image to JPEG format
    _, img_encoded = cv2.imencode('.jpg', rotated_image)

    # Convert the image bytes to base64
    img_base64 = base64.b64encode(img_encoded).decode('utf-8')

    # Render the HTML template and pass the image data
    return render_template('streamed_image.html', image_data=img_base64)


@app.route('/space-clicked', methods=['POST'])
def space_clicked():
    global isSpaceClicked

    # Set isSpaceClicked to True
    isSpaceClicked = True

    return 'Space Clicked'


@app.route('/esc-clicked', methods=['POST'])
def esc_clicked():
    global isEscClicked

    # Set isEscClicked to True
    isEscClicked = True

    return 'Esc Clicked'


@app.route('/is-esc-clicked', methods=['GET'])
def is_esc_clicked():
    global isEscClicked

    # Return the value of isEscClicked as a JSON response
    return jsonify({'isEscClicked': isEscClicked})


@app.route('/is-space-clicked', methods=['GET'])
def is_space_clicked():
    global isSpaceClicked

    # Return the value of isSpaceClicked as a JSON response
    return jsonify({'isSpaceClicked': isSpaceClicked})


@app.route('/reset-clicked-variables', methods=['POST'])
def reset_clicked_variables():
    global isSpaceClicked, isEscClicked

    # Reset the variables to False
    isSpaceClicked = False
    isEscClicked = False

    return 'Clicked variables reset successfully'

@app.route('/send-height', methods=['POST'])
def receive_float_values():
    global heightL
    global heightR
    global calib
    global bottomB
    global modeling

    data = request.get_json()
    heightL = data['left']
    heightR = data['right']
    calib = data['calib']
    bottomB = data['bottomB']
    modeling = data['modeling']

    return 'saved'


@app.route('/get-height', methods=['GET'])
def get_height():
    global heightL
    global heightR
    global calib
    global bottomB
    global modeling

    return jsonify({'heightL':heightL,'heightR':heightR,'calib':calib,'bottomB':bottomB,'modeling':modeling})



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
