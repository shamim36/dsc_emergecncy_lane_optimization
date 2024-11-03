import 'package:dsc_emergecncy_lane_optimization/dscLaneOptApp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSC Emergency Lane Optimization',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 19, 90, 128)),
        useMaterial3: true,
      ),
      home: DscLaneOptApp(title: 'Dsc LaneOpt'),
    );
  }
}

