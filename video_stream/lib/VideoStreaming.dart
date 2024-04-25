import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_stream/websocket.dart';
import 'package:audioplayers/audioplayers.dart';


class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final WebSocket _socket = WebSocket("ws://192.168.56.1:5000");

  final audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    _isAlarmOn=true;
    String filePath='fireAlarm2.mp3';
    Timer.periodic(const Duration(seconds: 1), (timer) async { 
      if(_isConnected && _isAlarmOn){
        await audioPlayer.play(AssetSource(filePath));
      }
    });

  }
  Future<void> stopSound() async {
    _isAlarmOn=false;
        await audioPlayer.stop();
  }



  bool _isConnected = false;
  bool _fireOn=false;
  bool _isAlarmOn=false;
  void connect(BuildContext context) async {
    _socket.connect();
    setState(() {
      _isConnected = true;
    });
  }

  void disconnect() {
    _socket.disconnect();
    setState(() {
      _isConnected = false;
    });
  }
  //NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    _fireOn=false;
    connect(context);
    super.initState();
  }

  bool _showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Live Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              _isConnected
                  ? StreamBuilder(
                      stream: _socket.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          Timer.periodic(const Duration(seconds: 10), (timer) {
                            if (!snapshot.hasData) {
                              setState(() {
                                _showErrorMessage = true;
                              });
                            } else {
                              setState(() {
                                _showErrorMessage = false;
                              });
                            }
                          });
                          return Center(
                              child: !_showErrorMessage
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      "Unable to detect CCTV",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ));
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return const Center(
                            child: Text("Connection Closed !"),
                          );
                        }

                        //FIRE STATUS
                        _fireOn=snapshot.data.toString()[0]=='1';
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              color: (_fireOn)
                                  ? Colors.red
                                  : Colors.green,
                              child: Stack(children: [
                                Image.memory(
                                  Uint8List.fromList(
                                    base64Decode(
                                      (snapshot.data.toString().substring(1)),
                                    ),
                                  ),
                                  gaplessPlayback: true,
                                  excludeFromSemantics: true,
                                ),
                                Positioned(
                                    right: 4,
                                    top: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.redAccent),
                                      child: const Text(
                                        'LIVE',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    )),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: Text(
                                (_fireOn)
                                    ? "Fire Detected"
                                    : "Safe Environment",
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 150,
                            ),
                            InkWell(
                              onTap: () {
                                
                                if(_fireOn || _isAlarmOn){
                                  !_isAlarmOn? playSound():stopSound();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: Text(
                                  _isAlarmOn?"Stop Alarm":"Ring Alarm",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                disconnect();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: const Text(
                                  'Disconnect',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            
                          ],
                        );
                      },
                    )
                  : const Text("Initiate Connection")
            ],
          ),
        ),
      ),
    );
  }
}
