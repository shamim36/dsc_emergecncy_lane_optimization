import 'package:dsc_emergecncy_lane_optimization/Pages/customAppBar.dart';
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
      home: const MyHomePage(title: 'DSC LaneOpt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title), // Using widget.title here to access the title from MyHomePage
      body: Center(
        child: Text('Welcome to ${widget.title}'),
      ),
    );
  }
}
