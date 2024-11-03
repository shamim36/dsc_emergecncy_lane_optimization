import 'package:flutter/material.dart';

import 'Pages/customAppBar.dart';

class DscLaneOptApp extends StatefulWidget {
  const DscLaneOptApp({super.key, required this.title});
  final String title;

  @override
  State<DscLaneOptApp> createState() => _DscLaneOptAppState();
}

class _DscLaneOptAppState extends State<DscLaneOptApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget
              .title), // Using widget.title here to access the title from MyHomePage
      body: Center(
        child: Text('Welcome to ${widget.title}'),
      ),
    );
  }
}
