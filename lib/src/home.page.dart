// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'category_button.dart';
import 'constants/categories.dart';
import 'models/arrow_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _fileList = [];

  void _updateFileList(List<File> filteredFiles) {
    setState(() {
      _fileList = filteredFiles;
    });
  }

  List<File> _getAllowedFileByCategory(
      ArrowFile selectedArrowFile, bool recursive) {
    List<File> foundFiles = [];
    try {
      List allFilesAndDirectories =
          Directory(selectedArrowFile.dirPath).listSync(recursive: recursive);

      for (var fileOrDir in allFilesAndDirectories) {
        String fileExt = ".${fileOrDir.path.split('.').last}";
        bool isFileAndHadAllowedExt =
            fileOrDir is File && selectedArrowFile.ext.contains(fileExt);
        if (isFileAndHadAllowedExt) {
          foundFiles.add(fileOrDir);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error:/n $error");
      }
    }

    return foundFiles;
  }

  void runFile(String path) {
    // try {
    //   if (kDebugMode) {
    //     print('Launching...');
    //   }

    //   Process.run(_docsArrowFile.favRunner, [path]);
    // } catch (error) {
    //   if (kDebugMode) {
    //     print("Error trying to Launch ${_docsArrowFile.favRunner}");
    //     print("Error: \n $error");
    //   }
    // }
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
                  children: categories
                      .map(
                        (currentArrowFile) => CustomButton(
                          icon: currentArrowFile.icon,
                          color: currentArrowFile.color,
                          label: currentArrowFile.label,
                          onPressed: () {
                            List<File> foundFiles = _getAllowedFileByCategory(
                                currentArrowFile,
                                currentArrowFile.recursiveSearch);
                            _updateFileList(foundFiles);
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _fileList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    trailing: const Icon(
                      Icons.open_in_new,
                      color: Colors.black54,
                    ),
                    title: Text(
                      _fileList[index].path.split('/').last,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
