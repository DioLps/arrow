// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

class DiskChart extends StatefulWidget {
  const DiskChart({Key? key}) : super(key: key);

  @override
  State<DiskChart> createState() => _DiskChartState();
}

class _DiskChartState extends State<DiskChart> {
  List<Disk> disks = [];
  int totalSizeInGb = 0;
  @override
  void initState() {
    super.initState();
    initDiskSpaceState();
  }

  double toGigaByte(int bytes) {
    return bytes / (1000 * 1000 * 1000);
  }

  int toGigaByteRounded(int bytes) {
    return bytes ~/ (1000 * 1000 * 1000);
  }

  Future<void> initDiskSpaceState() async {
    // Initializes the DiskSpace class.
    final diskSpace = DiskSpace();

    // Scan for disks in the system.
    await diskSpace.scan();

    // A list of disks in the system.

    setState(() {
      disks = diskSpace.disks;
      totalSizeInGb = toGigaByteRounded(disks.last.totalSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Discs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
        ),
        ...disks.map(
          (disk) {
            double totalUsedInGb = toGigaByte(disk.usedSpace);
            double percentUsed = (100 * totalUsedInGb) / totalSizeInGb;
            print('percentUsed');
            print(percentUsed.ceil());
            return Row(
              children: [
                Text(
                  disk.usedSpace.toStringAsFixed(0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ).toList(),
        const Padding(
          padding: EdgeInsets.only(bottom: 32),
        ),
      ],
    );

    // Column(
    //   children: [
    //     const Padding(
    //       padding: EdgeInsets.only(bottom: 12),
    //     ),
    //   ],
    // );
  }
}
