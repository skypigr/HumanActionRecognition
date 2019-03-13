import cv2
from os import listdir
from os.path import isfile, join
 
# This is a demo of running face recognition on a video file and saving the results to a new video file.
#
# PLEASE NOTE: This example requires OpenCV (the `cv2` library) to be installed only to read from your webcam.
# OpenCV is *not* required to use the face_recognition library. It's only required if you want to run this
# specific demo. If you have trouble installing it, try any of the other demos that don't require it instead.
 
# Open the input movie file

def convertAviToMp4(inputFileName, startTime, stopTime, show=False):
    cap = cv2.VideoCapture(inputFileName)
    fps = cap.get(cv2.CAP_PROP_FPS)
    size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)), int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))

    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = cv2.VideoWriter(inputFileName[:-4]+'.mp4', fourcc, fps, size)

    print("Processing video: {0}".format(inputFileName))
    print("Frames per second: {0}".format(fps))

    startFrame = startTime * fps
    stopFrame = stopTime * fps
    i = 0
    while(True):
        if i==stopFrame:
            break
        ret, frame = cap.read()

        if i >= startFrame:
            out.write(frame)
        if ret and show:
            cv2.imshow('frame', frame)

        # c = cv2.waitKey(1)
        # if c & 0xFF == ord('q'):
        #     break

        i+=1

    cap.release()
    out.release()
    cv2.destroyAllWindows()

"""
    name = 'person13_boxing_d1_uncomp.avi'
    convertAviToMp4(name, 0, 2)
"""

if __name__ == "__main__":
    
    mypath = 'handclapping/'
    # collect all files in the given folder
    videoFiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

    for video in videoFiles:
        if len(video) >= 4 and video[-4:] == '.avi':
            name = mypath + video
            convertAviToMp4(name, 0, 2)
