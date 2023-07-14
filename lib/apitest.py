import requests
import tkinter as tk
from tkinter import filedialog

# Specify the API endpoint URL
url = 'https://predict-cqs4omzwnq-km.a.run.app/predict'  
# video path
# video_path = "C:/Users\PHILIP\Downloads\Brawl breaks out in cafe __ Viral Video UK.mp4"
def select_video_file():
    # create a Tkinter file dialog and allow the user to select a file
    root = tk.Tk()
    root.withdraw()  # hides the root window

    # prompt the user to select a video file
    file_path = filedialog.askopenfilename(filetypes=[("Video Files", "*.mp4;*.avi;*.mkv")])

    return file_path

video_path = select_video_file()
# video_path = "C:/Users/PHILIP/Downloads/Brawl breaks out in cafe __ Viral Video UK.mp4"


# Open the video file in binary mode and send it as a request
with open(video_path, 'rb') as file:
    response = requests.post(url, files={'file': file, },)

# Print the response from the API
# print(file)
print(response.content)












# our requirements.txt file
# Flask
# gunicorn
# tensorflow
# numpy
# scikit-image
# opencv-python
# tkinter
# requests