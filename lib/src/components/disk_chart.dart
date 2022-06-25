// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

class DiskChart extends StatefulWidget {
  const DiskChart({Key? key}) : super(key: key);

  @override
  State<DiskChart> createState() => _DiskChartState();
}

class _DiskChartState extends State<DiskChart> {
  List<Disk> disks = [];
  int totalSizeInGb = 0;
  String percentUsed = '';
  double decimalPercentUsed = 0;
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

  double sumAllUsedDisksInGb() {
    List<int> usedsBytes = disks.map((value) => value.usedSpace).toList();

    int sumUsedBytes = 0;
    for (var usedSpace in usedsBytes) {
      sumUsedBytes += usedSpace;
    }
    return toGigaByte(sumUsedBytes);
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
      double totalUsedInGb = sumAllUsedDisksInGb();
      int rawPercentage = ((100 * totalUsedInGb) / totalSizeInGb).ceil();
      decimalPercentUsed = rawPercentage / 100;
      percentUsed = rawPercentage.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Usage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 20.0,
          animationDuration: 300,
          percent: decimalPercentUsed,
          center: Text(
            "In use $percentUsed%",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          barRadius: const Radius.circular(4),
          progressColor: Colors.teal,
          padding: EdgeInsets.zero,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 18),
        ),
      ],
    );
  }
}
