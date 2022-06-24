import 'package:flutter/material.dart';
import 'dart:io';

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({Key? key}) : super(key: key);
  @override
  State<ApplicationsListPage> createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage> {
  List fileList = [];

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() {
    setState(() {
      // use your folder name insted of resume.
      // fileList = Directory("/usr/share/applications/").listSync();
      try {
        List allFilesAndDirectories = Directory("/Applications").listSync();

        for (var fileOrDir in allFilesAndDirectories) {
          if (fileOrDir is File) {
            // print((fileOrDir as dynamic).name);
          } else if (fileOrDir is Directory) {
            fileList.add("Caminho: ${fileOrDir.path}");
          }
        }
      } catch (e) {
        print(e);
      }
    });
  }

  // Build Part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: fileList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    fileList[index].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
