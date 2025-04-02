import cv2
import requests
from deepface import DeepFace


def download_random_face():
    url = "https://thispersondoesnotexist.com"
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open("random_face.jpg", "wb") as file:
            for chunk in response.iter_content(1024):
                file.write(chunk)
        return "random_face.jpg"
    return None


def detect_emotion(image_path):
    try:
        analysis = DeepFace.analyze(img_path=image_path, actions=["emotion"])
        emotion = analysis[0]["dominant_emotion"]
        return emotion
    except Exception as e:
        return f"Error: {str(e)}"


def show_image_with_emotion(image_path, emotion):
    while True:
        img = cv2.imread(image_path)
        cv2.putText(
            img,
            emotion.capitalize(),
            (50, 50),
            cv2.FONT_HERSHEY_SIMPLEX,
            1,
            (0, 255, 0),
            2,
        )
        cv2.namedWindow("Detected Emotion", cv2.WINDOW_NORMAL)  # Make window resizable
        cv2.imshow("Detected Emotion", img)

        key = cv2.waitKey(0) & 0xFF  # Wait for key press
        if key == ord("q"):  # Press 'q' to quit
            break
        elif key == ord("r"):  # Press 'r' to refresh with a new image
            print("Downloading a new random face...")
            new_image_path = download_random_face()
            if new_image_path:
                print("Analyzing new emotion...")
                emotion = detect_emotion(new_image_path)
                print(f"New Detected Emotion: {emotion}")
                image_path = new_image_path
            else:
                print("Failed to download new image.")

    cv2.destroyAllWindows()


if __name__ == "__main__":
    print("Downloading a random face...")
    image_path = download_random_face()
    if image_path:
        print("Analyzing emotion...")
        emotion = detect_emotion(image_path)
        print(f"Detected Emotion: {emotion}")
        show_image_with_emotion(image_path, emotion)
    else:
        print("Failed to download image.")
