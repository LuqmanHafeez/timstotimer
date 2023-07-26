import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timstotimer/stopwatch.dart';
import 'package:timstotimer/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? tb;
  int hour = 0;
  int minutes = 0;
  int seconds = 0;
  String timeToDisplay = "";
  bool started = true;
  bool stopped = false;
  int timefortimer = 0;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    tb = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch"),
        centerTitle: true,
        bottom: TabBar(
          tabs: const [
            Text("Timer"),
            Text("StopWatch"),
          ],
          controller: tb,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelPadding: const EdgeInsets.only(bottom: 10.0),
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: TabBarView(
        children: [
          Time(),
          StopWatch(),
        ],
        controller: tb,
      ),
    );
  }
}
