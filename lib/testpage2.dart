import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Testpage2 extends StatefulWidget {
  const Testpage2({super.key});

  @override
  State<Testpage2> createState() => _Testpage2State();
}

class _Testpage2State extends State<Testpage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _landscapeModeOnly();
    return Scaffold(
        appBar: AppBar(title: Text("Print horizontal")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("This is a test")],
        ));
  }
}
