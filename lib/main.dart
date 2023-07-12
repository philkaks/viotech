import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 40),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '......to Violence Detection Tech.',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              )),
            ),
            const SizedBox(
              height: 100,
            ),
            uploadButton(),
          ],
        ),
      ),
    );
  }

  Widget uploadButton() {
    return SizedBox(
      height: 100,
      child: ElevatedButton(
          onPressed: () async {
            try {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['mp4'],
              );
              if (result != null && result.files.isNotEmpty) {
                String filePath = result.files.first.path.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadScreen(filePath: filePath),
                  ),
                );
              }
            } catch (e) {
              // Handle exception here
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(
                        'Invalid file format. Please select an MP4 video.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 255, 166, 0)),
            enableFeedback: true,
            elevation: const MaterialStatePropertyAll(15.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 50,
                  Icons.upload_file_rounded,
                  color: Color.fromARGB(255, 0, 0, 40),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                ),
                Text(
                  'Upload video',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 40),
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
