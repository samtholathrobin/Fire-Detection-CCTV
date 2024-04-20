import websockets
import asyncio
import cv2, base64
from ultralytics import YOLO

model=YOLO("fire_detektor.pt")

port = 5000

print("Started server on port : ", port)

async def transmit(websocket1, path):
    print("Client Connected !")
    await websocket1.send("Connection Established")
    try :
        cap = cv2.VideoCapture("<Video Stream Link>")
        
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

start_server = websockets.serve(transmit, host="192.168.56.1", port=port)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
