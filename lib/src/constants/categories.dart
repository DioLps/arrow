import 'package:flutter/material.dart';

import '../models/arrow_file.dart';

List<ArrowFile> categories = [
  ArrowFile(
    'Docs',
    'code',
    '/Users/rodrigolopes/Documents',
    Icons.article,
    Colors.green,
    [
      '.txt',
      '.js',
      '.doc',
      '.docx',
      '.odt',
      '.tex',
      '.wpd',
    ],
  ),
  ArrowFile(
    'Images',
    'open',
    '/Users/rodrigolopes/Pictures',
    Icons.image,
    Colors.lightBlue,
    [
      '.bmp',
      '.jpg',
      '.jpeg',
      '.gif',
      '.png',
    ],
  ),
  ArrowFile(
    'Videos',
    'open',
    '/Users/rodrigolopes/Movies',
    Icons.video_collection,
    Colors.pinkAccent,
    [
      '.mp4',
      '.wmv',
      '.mov',
      '.avi',
    ],
  ),
  ArrowFile(
    'Músicas',
    'open',
    '/Users/rodrigolopes/Music',
    Icons.note,
    Colors.orangeAccent,
    [
      '.mp3',
      '.oga',
      '.wav',
      '.m4a',
      '.aac',
      '.midi',
    ],
  ),
  ArrowFile(
    'Apps',
    'open',
    '/Users/rodrigolopes/Applications',
    Icons.apps,
    Colors.deepPurple,
    ['.app'],
  )
];