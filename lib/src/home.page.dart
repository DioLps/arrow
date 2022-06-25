// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'components/category_button.dart';
import 'components/disk_chart.dart';
import 'constants/categories.dart';
import 'models/arrow_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ArrowFile _lastSelected;
  late List<dynamic> _fileList;

  @override
  void initState() {
    super.initState();
    _fileList = [];
    _lastSelected = categories[0];

    _updateFileList(_getAllowedFileByCategory(categories[0], true));
  }

  void _updateFileList(List<dynamic> filteredFiles) {
    setState(() {
      _fileList = filteredFiles;
    });
  }

  void _selectArrowFile(
    ArrowFile selectedArrowFile,
  ) {
    setState(() {
      _lastSelected = selectedArrowFile;
    });
  }

  List<dynamic> _getAllowedFileByCategory(
      ArrowFile selectedArrowFile, bool recursive) {
    List<dynamic> foundFiles = [];
    try {
      List allFilesAndDirectories =
          Directory(selectedArrowFile.dirPath).listSync(recursive: recursive);

      for (var fileOrDir in allFilesAndDirectories) {
        String fileExt = ".${fileOrDir.path.split('.').last}";
        bool isFileAndHadAllowedExt =
            fileOrDir is File && selectedArrowFile.ext.contains(fileExt);
        if (isFileAndHadAllowedExt || fileExt == ".app") {
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
    try {
      if (kDebugMode) {
        print('Launching...');
      }

      Process.run(_lastSelected.favRunner, [path]);
    } catch (error) {
      if (kDebugMode) {
        print("Error trying to Launch ${_lastSelected.favRunner}");
        print("Error: \n $error");
      }
    }
  }

  Widget listBuilder() {
    if (_fileList.isEmpty) {
      return const Text(
        'No Items',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      if (_lastSelected.ext.contains('.app')) {
        return Expanded(
          child: GridView.count(
            crossAxisCount: 6,
            children: _fileList.map((fileItem) {
              String filePath = fileItem.path.toString().replaceAll(' ', '\\ ');

              dynamic fileRef;
              bool canReadRef = false;
              try {
                fileRef = File("${filePath}/Contents/Resources/AppIcon.icns");
                canReadRef = fileRef.lengthSync() > 0;
              } catch (e) {
                if (kDebugMode) {
                  print("Couldn't catch the file at: $filePath");
                }
                fileRef = null;
                canReadRef = false;
              }

              return Column(
                children: [
                  canReadRef
                      ? Image.file(
                          fileRef,
                          height: 60,
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 60,
                        ),
                  Text(
                    fileItem.path.split('/').last,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }).toList(),
          ),
        );
      }

      return Expanded(
        child: ListView.separated(
          itemCount: _fileList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                runFile(_fileList[index].path);
              },
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            const DiskChart(),
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
                            _selectArrowFile(currentArrowFile);
                            List<dynamic> foundFiles =
                                _getAllowedFileByCategory(currentArrowFile,
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
            listBuilder()
          ],
        ),
      ),
    );
  }
}
