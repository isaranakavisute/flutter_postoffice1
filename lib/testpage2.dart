import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_usb_printer/flutter_usb_printer.dart';
//import 'package:usb_thermal_printer_web/usb_thermal_printer_web.dart';
//import 'package:flutter_usb_printer.dart';
import 'package:postoffice_queuesystem/flutter_usb_printer.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:printing/printing.dart';

class Testpage2 extends StatefulWidget {
  const Testpage2({super.key});

  @override
  State<Testpage2> createState() => _Testpage2State();
}

class _Testpage2State extends State<Testpage2> {
  List<Map<String, dynamic>> devices = [];
  FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
  bool connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    //_getDevicelist();
    print_via_sdk();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  Future<List<Printer>> findPrinters() async {
    return await Printing.listPrinters();
  }

  print_via_sdk() async {
    //await flutterUsbPrinter.print_via_sdk();
  }

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();

    print(" length: ${results.length}");
    setState(() {
      devices = results;
    });
  }

  _connect(int vendorId, int productId) async {
    bool? returned = false;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if (returned!) {
      setState(() {
        connected = true;
      });
    }
  }

  _print() async {
    try {
      var data = Uint8List.fromList(
          utf8.encode("This is a raw byte printer testing."));
      await flutterUsbPrinter.write(data);
      // await FlutterUsbPrinter.printRawData("text");
      // await FlutterUsbPrinter.printText("Testing ESC POS printer...");
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
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

  // @override
  // Widget build(BuildContext context) {
  //   //_landscapeModeOnly();
  //   return Scaffold(
  //       appBar: AppBar(title: Text("Print Screen")),
  //       body: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [Text("This is a test")],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('USB PRINTER'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () => _getDevicelist()),
            connected == true
                ? new IconButton(
                    icon: new Icon(Icons.print),
                    onPressed: () {
                      _print();
                    })
                // : new Container(),
                : new IconButton(
                    icon: new Icon(Icons.print),
                    onPressed: () async {
                      await print_via_sdk();
                    })
          ],
        ),
        body: devices.length > 0
            ? new ListView(
                scrollDirection: Axis.vertical,
                children: _buildList(devices),
              )
            // ? new Column(
            //     children: [
            //       new ListView(
            //         scrollDirection: Axis.vertical,
            //         children: _buildList(devices),
            //       ),
            //       new ElevatedButton(
            //         child: Text('Print It'),
            //         onPressed: () async {
            //           await print_via_sdk();
            //         },
            //       ),
            //     ],
            //   )
            : null,
      ),
    );
  }

  List<Widget> _buildList(List<Map<String, dynamic>> devices) {
    return devices
        .map((device) => new ListTile(
              onTap: () {
                //_connect(int.parse(device['vendorId']),int.parse(device['productId']));
              },
              leading: new Icon(Icons.usb),
              title: new Text(
                  device['manufacturer'] + "**" + device['productName']),
              subtitle:
                  new Text(device['vendorId'] + "**" + device['productId']),
            ))
        .toList();
  }
}
