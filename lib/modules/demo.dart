import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Ringtone> ringtones = [];

  @override
  void initState() {
    super.initState();
    getRingtones();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getRingtones() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final temp = await FlutterSystemRingtones.getRingtoneSounds();
      setState(() {
        ringtones = temp;
      });
    } on PlatformException {
      debugPrint('Failed to get platform version.');
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(onTap: () {}, child: const Text('Plugin example app')),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: ringtones.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(ringtones[index].title),
                subtitle: Text(ringtones[index].uri),
                onTap: () {
                  // _flutterSystemRingtonesPlugin.playRingtone(ringtones[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Future<void> convertUriToFile() async {
  //   try {
  //     String uriString = 'content://sample.txt'; // Uri string
  //
  //     // Don't pass uri parameter using [Uri] object via uri.toString().
  //     // Because uri.toString() changes the string to lowercase which causes this package to misbehave
  //
  //     // If you are using uni_links package for deep linking purpose.
  //     // Pass the uri string using getInitialLink() or linkStream
  //
  //     File file = await toFile(uriString);
  //     log("file---->${file.path}"); // Converting uri to file
  //   } on UnsupportedError catch (e) {
  //     print(e.message); // Unsupported error for uri not supported
  //   } on IOException catch (e) {
  //     print(e); // IOException for system error
  //   } catch (e) {
  //     print(e); // General exception
  //   }
  // }
}
