// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'category_button.dart';

class ArrowFile {
  String label;
  String favRunner;
  List<String> ext;
  ArrowFile(this.label, this.favRunner, this.ext);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _fileList = 0;
  final ArrowFile _docsArrowFile = ArrowFile(
    'Docs',
    'code',
    [
      '.txt',
      '.js',
      '.doc',
      '.docx',
      '.odt',
      '.tex',
      '.wpd',
    ],
  );

  // void _filterFileList() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  void runFile(String path) {
    try {
      if (kDebugMode) {
        print('Launching...');
      }

      Process.run(_docsArrowFile.favRunner, [path]);
    } catch (error) {
      if (kDebugMode) {
        print("Error trying to Launch ${_docsArrowFile.favRunner}");
        print("Error: \n $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Categories',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      icon: Icons.article,
                      color: Colors.green,
                      label: _docsArrowFile.label,
                      onPressed: () {
                        // Todo: Get list of files
                      },
                    ),
                    CustomButton(
                      icon: Icons.image,
                      color: Colors.lightBlue,
                      label: "Images",
                      onPressed: () {},
                    ),
                    CustomButton(
                      icon: Icons.video_collection,
                      color: Colors.pinkAccent,
                      label: "Videos",
                      onPressed: () {},
                    ),
                    CustomButton(
                      icon: Icons.note,
                      color: Colors.orangeAccent,
                      label: "Music",
                      onPressed: () {},
                    ),
                    CustomButton(
                      icon: Icons.error,
                      color: Colors.red,
                      label: "Unknown",
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
