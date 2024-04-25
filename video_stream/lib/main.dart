import 'package:flutter/material.dart';
import 'package:video_stream/screens/homeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Stream',
      home: ConnectPage(),
      theme: ThemeData(textTheme: GoogleFonts.sourceSans3TextTheme()),
    );
  }
}
