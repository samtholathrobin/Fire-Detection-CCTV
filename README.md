# FireDetection-CCTV

## Introduction
In an era where safety and surveillance are paramount concerns, harnessing the power of technology to mitigate risks is not just prudent but necessary. Introducing our innovative project: a state-of-the-art Object Detection Model integrated within a Closed-Circuit Television (CCTV) system designed specifically to detect and alert for instances of fire and smoke.

We introduce an object detection model-based CCTV monitoring application that allows users to detect fire and smoke in a room even from remote locations. This is achieved with the help of a Python server and an application built using the Google Flutter framework.

## Key Features
- **Precise Object Detection:** Powered by advanced machine learning algorithms, our model accurately identifies fire and smoke instances in real-time video streams.
- **Python Server Integration:** The Python server orchestrates backend operations including data processing, analysis, and communication with the Flutter application.
- **Flutter Application Interface:** Our user-friendly Flutter application provides a seamless interface for users to monitor live feeds, receive alerts, and access historical data from any device.
- **Scalability and Adaptability:** Designed with scalability in mind, our system can be easily integrated into existing CCTV infrastructure, making it an ideal solution for diverse environments ranging from homes to industrial complexes.

## Working
The video from the CCTV or video source is projected onto a web server. This video source is then picked up by the Python server and object detection is performed on this video. The object detection model predicts or identifies the existence of fire or smoke in the video stream.

The images from the video stream are then converted into base64 encoding and the result of the model's prediction is appended to this encoded data. This data stream is then sent via websockets created within the server.

The Flutter app receives this data, decodes it, and presents the video stream and the result of the object detection model through its visually striking UI. The application also has an alarm feature which is activated during the course of a fire.

## Code Implementation
[Include code snippets or link to code files here if available]

## Working of Object Detection Model
[Add details about the object detection model's working]

## Mobile Application
[Provide details about the mobile application and its features]

## Future Optimizations
- **Cloud Hosting:** Hosting this server on the cloud would allow us to support multiple CCTVs, creating a more varied workspace that can be used by multiple CCTVs or users. This would enhance the robustness and compliance of the application.
- **Enhanced GPU Systems:** Running this server on a more powerful GPU system would enable faster object detection, resulting in lower latency and quicker response times.
- **Camera Technology Upgrade:** Upgrading the camera technology would provide better input data to the Python server and the object detection model, leading to improved output.

## Conclusion
In an age where proactive safety measures are indispensable, our Object Detection Model powered CCTV Fire and Smoke Detection System stands at the forefront of innovation. By seamlessly integrating Python server technology with a user-centric Flutter application, we empower individuals and organizations to safeguard their environments with unprecedented precision and efficiency.

In essence, our system represents a paradigm shift in fire safety technology. It is not merely a tool for detection but a comprehensive solution that empowers individuals and organizations to protect what matters most. As we continue to refine and innovate upon our system, we are committed to advancing the frontiers of safety, ensuring that communities worldwide can thrive in environments free from the threat of fire and smoke hazards.

## Screenshots
![image](https://github.com/samtholathrobin/Fire-Detection-CCTV/assets/103640421/7ac53b11-3311-4650-b1cf-890f1e2e60d5)


## Documentation
[Link to the full presentation](https://docs.google.com/presentation/d/1x54yeFI9ejM1lHZsxtJz5mLCaHmWg1sn/edit?usp=sharing&ouid=101720786551020325731&rtpof=true&sd=true)
