import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timstotimer/home.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  Timer? _timer;
  int hour = 0;
  int seconds = 0;
  int minutes = 0;
  String timeToDisplay = "";
  bool started = true;
  bool stopped = false;
  int timefortimer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "HH",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 60,
                        value: hour,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "MM",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 60,
                        value: minutes,
                        onChanged: (val) {
                          setState(() {
                            minutes = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SS",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 60,
                        value: seconds,
                        onChanged: (val) {
                          setState(() {
                            seconds = val;
                          });
                        })
                  ],
                ),
              ],
            )),
        Expanded(
          flex: 3,
          child: Text(
            timeToDisplay,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 15.0,
                    ),
                  ),
                  onPressed: () {
                    started ? start() : null;
                  },
                  child: const Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopped ? stop() : null;
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 15.0,
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Stop",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ],
    ));
  }

  void start() {
    timefortimer = (hour * 3600) + (minutes * 60) + (seconds);
    debugPrint(timefortimer.toString());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        stopped = true;
        started = false;
        if (timefortimer < 1) {
          stopped = false;
          started = true;

          _timer?.cancel();
          timeToDisplay = "";
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
        } else if (timefortimer < 60) {
          timefortimer = timefortimer - 1;
          timeToDisplay = timefortimer.toString();
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          debugPrint("time :" + m.toString());
          int s = timefortimer - (60 * m);
          debugPrint("seconds: $s");
          timeToDisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      _timer?.cancel();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
      timeToDisplay = "";
      stopped = false;
      started = true;
    });
  }
}
