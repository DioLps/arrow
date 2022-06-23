import 'package:flutter/material.dart';

import 'src/appications-list.page.dart';
// import 'src/home.page.dart';

class ArrowApp extends StatelessWidget {
  const ArrowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arrow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ApplicationsListPage(),
    );
  }
}

void main() {
  runApp(const ArrowApp());
}
