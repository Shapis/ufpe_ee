import speech_recognition as sr
from pydub import AudioSegment

audio_file = "camoes.wav"
sound = AudioSegment.from_mp3(audio_file)
sound.export("audio_convertido.wav", format="wav")

recognizer = sr.Recognizer()

with sr.AudioFile("audio_convertido.wav") as source:
    audio = recognizer.record(source)

try:
    text = recognizer.recognize_google(audio, language="pt")
    print("Texto reconhecido: " + text)

except sr.UnknownValueError:
    print("Google Speech Recognition nao conseguiu entender o audio")
except sr.RequestError:
    print("Nao consegui obter resultados do Google Speech Recognition")
