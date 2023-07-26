import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  String timeToDisplay = "00 : 00 : 00";
  bool start = true;
  bool stop = false;
  bool reset = false;
  var stopWatch = Stopwatch();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              timeToDisplay,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
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
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 15.0,
                  ),
                ),
                onPressed: () {
                  stopPressed();
                },
                child: const Text(
                  "Stop",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  resetPressed();
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 15.0,
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          //flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 55.0,
                        vertical: 25.0,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  onPressed: () {
                    start ? startPressed() : null;
                  },
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void startPressed() {
    stopWatch.start();
    stop = true;
    start = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeToDisplay = stopWatch.elapsed.inHours.toString() +
            ":" +
            (stopWatch.elapsed.inMinutes % 60).toString() +
            ":" +
            (stopWatch.elapsed.inSeconds % 60).toString();
      });
    });
  }

  void stopPressed() {
    setState(() {
      reset = true;
      stopWatch.stop();
      _timer?.cancel();
    });
  }

  void resetPressed() {
    setState(() {
      stop = false;
      reset = false;
      start = true;
      stopWatch.reset();
      timeToDisplay = "00 : 00 : 00";
    });
  }
}
