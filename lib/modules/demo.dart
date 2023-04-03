// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show PlatformException;
// import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<Ringtone> ringtones = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getRingtones();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> getRingtones() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       final temp = await FlutterSystemRingtones.getRingtoneSounds();
//       setState(() {
//         ringtones = temp;
//       });
//     } on PlatformException {
//       debugPrint('Failed to get platform version.');
//     }
//
//     if (!mounted) return;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: GestureDetector(onTap: () {}, child: const Text('Plugin example app')),
//         ),
//         body: Center(
//           child: ListView.builder(
//             itemCount: ringtones.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title: Text(ringtones[index].title),
//                 subtitle: Text(ringtones[index].uri),
//                 onTap: () {
//                   // _flutterSystemRingtonesPlugin.playRingtone(ringtones[index]);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future<void> convertUriToFile() async {
//   //   try {
//   //     String uriString = 'content://sample.txt'; // Uri string
//   //
//   //     // Don't pass uri parameter using [Uri] object via uri.toString().
//   //     // Because uri.toString() changes the string to lowercase which causes this package to misbehave
//   //
//   //     // If you are using uni_links package for deep linking purpose.
//   //     // Pass the uri string using getInitialLink() or linkStream
//   //
//   //     File file = await toFile(uriString);
//   //     log("file---->${file.path}"); // Converting uri to file
//   //   } on UnsupportedError catch (e) {
//   //     print(e.message); // Unsupported error for uri not supported
//   //   } on IOException catch (e) {
//   //     print(e); // IOException for system error
//   //   } catch (e) {
//   //     print(e); // General exception
//   //   }
//   // }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AdjustableAlarm extends StatefulWidget {
  @override
  _AdjustableAlarmState createState() => _AdjustableAlarmState();
}

class _AdjustableAlarmState extends State<AdjustableAlarm> {
  int _interval = 5; // Default interval is set to 5 minutes
  int _secondsBefore = 0; // Default seconds before is set to 0 seconds
  Timer? _timer; // Timer variable to hold the timer
  bool _isRunning = false; // Boolean to keep track if alarm is running or not

// Function to start the alarm
  void _startAlarm() {
    _timer = Timer.periodic(Duration(minutes: _interval), (timer) {
      FlutterRingtonePlayer.playAlarm();
      Future.delayed(Duration(seconds: _secondsBefore), () {
        FlutterRingtonePlayer.playAlarm();
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

// Function to stop the alarm
  void _stopAlarm() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Adjustable Alarm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Interval: $_interval minutes",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_interval > 1) {
                      setState(() {
                        _interval--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  "$_interval",
                  style: TextStyle(fontSize: 36),
                ),
                IconButton(
                  onPressed: () {
                    if (_interval < 60) {
                      setState(() {
                        _interval++;
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Seconds Before: $_secondsBefore seconds",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_secondsBefore > 0) {
                      setState(() {
                        _secondsBefore--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  "$_secondsBefore",
                  style: TextStyle(fontSize: 36),
                ),
                IconButton(
                  onPressed: () {
                    if (_secondsBefore < 60) {
                      setState(() {
                        _secondsBefore++;
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!_isRunning) {
                  _startAlarm();
                } else {
                  _stopAlarm();
                }
              },
              child: Text(_isRunning ? "Stop Alarm" : "Start Alarm"),
            ),
          ],
        ),
      ),
    );
  }
}
