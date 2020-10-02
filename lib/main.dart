import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: pomodoro(),
  ));
}

class pomodoro extends StatefulWidget {
  @override
  _pomodoroState createState() => _pomodoroState();
}

class _pomodoroState extends State<pomodoro> {
  double percent = 0.0;
  static int TimeInMin = 25;
  int TimeInSec = TimeInMin * 60;

  Timer timer;
  _startTimer() {
    int Time = TimeInMin * 60;
    double SecPercent = (Time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMin--;
          }
          if (Time % SecPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMin = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        leading: IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {}),
        title: Text(
          "pomodoro clock".toUpperCase(),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 20.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1542bf), Color(0xff51a8ff)],
              begin: FractionalOffset(0.5, 1)),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 200.0,
                lineWidth: 20.0,
                progressColor: Colors.white,
                center: Text(
                  "$TimeInMin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Expanded(
              child: Container(
                width: 350.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(28.0),
                    topLeft: Radius.circular(28.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Study Time",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Pause Time",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28.0),
                        child: RaisedButton(
                          splashColor: Colors.lightBlueAccent,
                          onPressed: _startTimer,
                          color: Colors.blue,
                          elevation: 20.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Start Studying",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
