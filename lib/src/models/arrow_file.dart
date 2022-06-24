import 'package:flutter/material.dart';

class ArrowFile {
  String label;
  String favRunner;
  String dirPath;
  IconData icon;
  Color color;
  List<String> ext;
  bool recursiveSearch;
  ArrowFile(this.label, this.favRunner, this.dirPath, this.icon, this.color,
      this.ext, this.recursiveSearch);
}
