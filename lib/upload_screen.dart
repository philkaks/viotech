import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'results.dart';
import 'testvsync.dart';

class UploadScreen extends StatefulWidget {
  final String filePath;

  UploadScreen({required this.filePath});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  double progress = 0;

  @override
  void initState() {
    super.initState();
    uploadFile();
  }

  Future<void> uploadFile() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://predict-cqs4omzwnq-km.a.run.app/predict'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', widget.filePath),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      // File uploaded successfully
      var responseBody = await response.stream.bytesToString();
      var parsedResponse = jsonDecode(responseBody);

      String fight = parsedResponse['fight'].toString();
      String percentageOfFight = parsedResponse['percentageoffight'].toString();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            fight: fight,
            percentageOfFight: percentageOfFight,
          ),
        ),
      );
    }

    response.stream.listen(
      (List<int> event) {
        setState(() {
          progress = response.contentLength != null
              ? event.length / response.contentLength!
              : 0;
        });
      },
      onError: () {
        print('Error encountered while uploading please try again.');
      },
      onDone: () {
        print('Upload complete');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget uploadButton() {
      AnimationController animationController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: TestVSync(), // You need to provide a valid TickerProvider.
      );
      Color colorValue = const Color.fromARGB(
          255, 0, 0, 40); // Assuming you have a color value

      Animation<Color?>? colorAnimation = ColorTween(
        begin: colorValue,
        end: colorValue,
      ).animate(animationController);

      // Here, the begin and end values are the same, creating a static color animation.

      // Now you can pass the colorAnimation to the parameter expecting Animation<Color?>?.

      return SizedBox(
        height: 100,
        child: ElevatedButton(
            onPressed: () {},
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
                  CircularProgressIndicator.adaptive(
                    valueColor: colorAnimation,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                  ),
                  const Expanded(
                    child: Text(
                      'Uploading video.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 0, 0, 40),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 40),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome..',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '......to Violence Detection Tech.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
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
}
