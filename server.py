import websockets
import asyncio
import cv2, base64
from ultralytics import YOLO
import socket
from fastapi import FastAPI
from typing import Union
import uvicorn

hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)
model=YOLO("fire_detektor.pt")
port = 5000
websocket_link="ws://"+IPAddr+":"+str(port)

async def transmit(websocket1, path):
    print("Client Connected !")
    await websocket1.send("Connection Established")
    try :

        cap = cv2.VideoCapture(<Video Stream Link>)
        
        while cap.isOpened():
            d="0"
            _, frame = cap.read()
            results = model.predict(frame, stream=False)
            for i in results:
                if len(i.boxes)>1:
                    a=i.names[i.boxes.cls[0].item()]
                    if a=="Fire":
                        d="1"
                    elif a=="Smoke":
                        d="2"
            encoded = cv2.imencode('.jpg', frame)[1]
            data = str(base64.b64encode(encoded))
            d+=data[2:len(data)-1]
            await websocket1.send(d)

        cap.release()

    except websockets.connection.ConnectionClosed as e:
        print("Client Disconnected !")
        cap.release()

start_server = websockets.serve(transmit, host=IPAddr, port=port)
print("Ready to Connect")
app=FastAPI()
@app.get("/")
async def read_root():
    return {"websocket": websocket_link}

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
