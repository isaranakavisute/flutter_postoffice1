//import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:postoffice_queuesystem/testpage2.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:postoffice_queuesystem/flutter_usb_printer.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ScreenshotController screenshotController = ScreenshotController();
  List<Map<String, dynamic>> devices = [];
  List<Printer> printers = [];
  FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
  bool connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    //_getDevicelist();
    //_buildList(devices);
    //if (devices.isNotEmpty)
    //_connect(int.parse(devices[0]['vendorId']),
    //   int.parse(devices[0]['productId']));
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future findPrinters() async {
    //return await Printing.listPrinters();
    //List<Printer> printers;
    setState(() async {
      printers = await Printing.listPrinters();
    });
  }

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();

    //print(" length: ${results.length}");

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
      _getDevicelist();
      if (devices.isNotEmpty)
        _connect(int.parse(devices[0]['vendorId']),
            int.parse(devices[0]['productId']));

      //findPrinters();
      //printers[0]

      final doc = pw.Document();
      final directory = (await getApplicationDocumentsDirectory()).path;
      File myfile = File('${directory}/qr.png');
      final Uint8List byteList = await myfile.readAsBytes();

      var data = Uint8List.fromList(
          utf8.encode("This is a raw byte printer testing."));

      //await flutterUsbPrinter.write(byteList);

      await flutterUsbPrinter.write(data);

      //Uint8List.fromList(utf8.encode(input));

      // doc.addPage(pw.Page(
      //     margin: const pw.EdgeInsets.only(top: 10),
      //     build: (pw.Context context) {
      //       return pw.Center(child: pw.Image(pw.MemoryImage(byteList)));
      //     }));
      // await Printing.layoutPdf(
      //     onLayout: (PdfPageFormat format) async => doc.save());

      // final res = await Printing.directPrintPdf(
      //     printer: printers[0],
      //     onLayout: (PdfPageFormat format) async => doc.save(),
      //     usePrinterSettings: true);
    } on PlatformException {}
  }

  print_via_sdk1() async {
    //await flutterUsbPrinter.print_via_sdk();

    final directory = (await getApplicationDocumentsDirectory()).path;
    File myfile = File('${directory}/qr.jpg');
    //Image myimage = Image.file(myfile);
    final Uint8List byteList = await myfile.readAsBytes();
    List<int> imageBytes = await myfile.readAsBytesSync();
    var data = Uint8List.fromList(imageBytes);
    String base64Image = base64Encode(imageBytes);
    //final ByteData byteData = byteList.buffer.asByteData(); // ByteData
    //final ByteData byteData = ByteData.sublistView(byteList);
    //final ByteData byteData = myimage.
    //final ByteData byteData = pw.MemoryImage(byteList);
    //Image myimage = pw.Image(pw.MemoryImage(byteList));
    final ByteData byteData = ByteData.view(byteList.buffer);

    //await flutterUsbPrinter.print_via_sdk(byteData);
    //await flutterUsbPrinter.print_via_sdk(byteList);
    //await flutterUsbPrinter.print_via_sdk(data);
    await flutterUsbPrinter.print_via_sdk1(base64Image);
  }

  print_via_sdk2() async {
    //await flutterUsbPrinter.print_via_sdk();

    final directory = (await getApplicationDocumentsDirectory()).path;
    File myfile = File('${directory}/qr.jpg');
    //Image myimage = Image.file(myfile);
    final Uint8List byteList = await myfile.readAsBytes();
    List<int> imageBytes = await myfile.readAsBytesSync();
    var data = Uint8List.fromList(imageBytes);
    String base64Image = base64Encode(imageBytes);
    //final ByteData byteData = byteList.buffer.asByteData(); // ByteData
    //final ByteData byteData = ByteData.sublistView(byteList);
    //final ByteData byteData = myimage.
    //final ByteData byteData = pw.MemoryImage(byteList);
    //Image myimage = pw.Image(pw.MemoryImage(byteList));
    final ByteData byteData = ByteData.view(byteList.buffer);

    //await flutterUsbPrinter.print_via_sdk(byteData);
    //await flutterUsbPrinter.print_via_sdk(byteList);
    //await flutterUsbPrinter.print_via_sdk(data);
    await flutterUsbPrinter.print_via_sdk2(base64Image);
  }

  print_via_sdk3() async {
    //await flutterUsbPrinter.print_via_sdk();

    final directory = (await getApplicationDocumentsDirectory()).path;
    File myfile = File('${directory}/qr.jpg');
    //Image myimage = Image.file(myfile);
    final Uint8List byteList = await myfile.readAsBytes();
    List<int> imageBytes = await myfile.readAsBytesSync();
    var data = Uint8List.fromList(imageBytes);
    String base64Image = base64Encode(imageBytes);
    //final ByteData byteData = byteList.buffer.asByteData(); // ByteData
    //final ByteData byteData = ByteData.sublistView(byteList);
    //final ByteData byteData = myimage.
    //final ByteData byteData = pw.MemoryImage(byteList);
    //Image myimage = pw.Image(pw.MemoryImage(byteList));
    final ByteData byteData = ByteData.view(byteList.buffer);

    //await flutterUsbPrinter.print_via_sdk(byteData);
    //await flutterUsbPrinter.print_via_sdk(byteList);
    //await flutterUsbPrinter.print_via_sdk(data);
    await flutterUsbPrinter.print_via_sdk3(base64Image);
  }

  List<Widget> _buildList(List<Map<String, dynamic>> devices) {
    return devices
        .map((device) => new ListTile(
              onTap: () {
                _connect(int.parse(device['vendorId']),
                    int.parse(device['productId']));
              },
              leading: new Icon(Icons.usb),
              title: new Text(
                  device['manufacturer'] + "**" + device['productName']),
              subtitle:
                  new Text(device['vendorId'] + "**" + device['productId']),
            ))
        .toList();
  }

  Future<void> PrintCapturedWidget(Uint8List capturedImage) async {
    final doc = pw.Document();
    final directory = (await getApplicationDocumentsDirectory()).path;

    //File myfile = File('${directory}/qr.png');
    File myfile = File('${directory}/qr.jpg');
    final Uint8List byteList = await myfile.readAsBytes();
    doc.addPage(pw.Page(
        //pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(top: 10),
        build: (pw.Context context) {
          return pw.Center(
              //child: pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.cover));
              child: pw.Image(pw.MemoryImage(byteList)));
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
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
    _portraitModeOnly();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber, title: Text("")),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              /*
              Row(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Row(
                      //mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                //mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.25,
                                    height: size.height * 0.05,
                                    child: Container(
                                        //decoration: BoxDecoration(border: Border.all()),
                                        child: Image.asset(
                                            'assets/images/thp_logo.png')),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.25,
                                    height: size.height * 0.05,
                                    child: Container(
                                        //decoration: BoxDecoration(border: Border.all()),
                                        child: Image.asset(
                                            'assets/images/thp_address.png')),
                                  ),
                                ],
                              ),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8.0),
                                child:
                                    Text("Free Text สำหรับลูกค้าใส่รายละเอียด"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, left: 8.0),
                                child: Text("SKU1001 x 1"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, left: 8.0),
                                child: Text("SKU1001 x 5"),
                              ),
                            ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                        right: 8.0),
                                    child: SizedBox(
                                      width: size.width * 0.25,
                                      height: size.height * 0.05,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: Column(
                                            children: [
                                              Text("V 2,000"),
                                              Text("COD 1,250"),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                        right: 8.0),
                                    child: SizedBox(
                                      width: size.width * 0.50,
                                      height: size.height * 0.10,
                                      child: Container(
                                          //decoration: BoxDecoration(border: Border.all()),
                                          child: Column(
                                        children: [
                                          Text("ETA 25 มิ.ย."),
                                          Text("Print: THPC POS ครั้งที่ 1"),
                                          Text("User: admin"),
                                        ],
                                      )),
                                    ),
                                  ),
                                ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text("ผู้ส่ง: นายทดสอบ ใจดี"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text("1000 ถนนพหลโยธิน"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 8.0),
                                child: Text("ผู้รับ: นายหนุ่ม ไปรษณีย์"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text("85 ม.7 ถนนหลวง"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text("ต.ลิ้นฟ้า อ.จตุพรพักตรพิมาน"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text("จ. ร้อยเอด"),
                              ),
                            ]),
                            Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 8.0),
                                child: Text(""),
                              ),
                            ]),
                            //SizedBox(height: 0.050),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //SizedBox(height: 0.050),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //SizedBox(height: 0.035),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.18,
                                                height: size.height * 0.035,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: Colors.black,
                                                  ),
                                                  child: Center(
                                                    child: Text('ลส',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.18,
                                                height: size.height * 0.035,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text('45180',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.40,
                                                height: size.height * 0.055,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('EBKLS',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10)),
                                                      Text('12345678XJ-1/51',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10)),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.18,
                                                height: size.height * 0.035,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text('1003',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.18,
                                                height: size.height * 0.035,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text('1789',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),

                                      /*QrImageView(
                          data: '1234567890',
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                        */
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      QrImageView(
                                        data: '1234567890',
                                        version: QrVersions.auto,
                                        size: 150.0,
                                      ),
                                    ],
                                  ),
                                ]),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              */
              Screenshot(
                controller: screenshotController,
                child: Container(
                  child: Column(
                    children: [
                      /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.25,
                              height: size.height * 0.05,
                              child: Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  child: Image.asset(
                                      'assets/images/thp_logo.png')),
                            ),
                            SizedBox(
                              width: size.width * 0.25,
                              height: size.height * 0.05,
                              child: Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  child: Image.asset(
                                      'assets/images/thp_address.png')),
                            ),
                          ]),*/
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child:
                                  Text("Free Text สำหรับลูกค้าใส่รายละเอียด"),
                            ),
                          ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                          child: Text("SKU1001 x 1"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                          child: Text("SKU1001 x 5"),
                        ),
                      ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 8.0,
                                  left: 8.0,
                                  right: 0.0),
                              child: SizedBox(
                                width: size.width * 0.25,
                                height: size.height * 0.10,
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Column(
                                      children: [
                                        Text("V 2,000"),
                                        Text("COD 1,250"),
                                      ],
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 8.0,
                                  left: 8.0,
                                  right: 0.0),
                              child: SizedBox(
                                width: size.width * 0.45,
                                height: size.height * 0.10,
                                child: Container(
                                    //decoration: BoxDecoration(border: Border.all()),
                                    child: Column(
                                  children: [
                                    Text("ETA 25 มิ.ย."),
                                    Text("Print: THPC POS ครั้งที่ 1"),
                                    Text("User: admin"),
                                  ],
                                )),
                              ),
                            ),
                          ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text("ผู้ส่ง: นายทดสอบ ใจดี"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text("1000 ถนนพหลโยธิน"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                          child: Text("ผู้รับ: นายหนุ่ม ไปรษณีย์"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text("85 ม.7 ถนนหลวง"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text("ต.ลิ้นฟ้า อ.จตุพรพักตรพิมาน"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text("จ. ร้อยเอด"),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(""),
                        ),
                      ]),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(""),
                        ),
                      ]),
                      //SizedBox(height: 0.050),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //SizedBox(height: 0.050),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //SizedBox(height: 0.035),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: size.width * 0.18,
                                          height: size.height * 0.035,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.black,
                                            ),
                                            child: Center(
                                              child: Text('ลส',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: size.width * 0.18,
                                          height: size.height * 0.035,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text('45180',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: size.width * 0.40,
                                          height: size.height * 0.055,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('EBKLS',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                                Text('12345678XJ-1/51',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                              ],
                                            )),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: size.width * 0.18,
                                          height: size.height * 0.035,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text('1003',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: size.width * 0.18,
                                          height: size.height * 0.035,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text('1789',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),

                                /*QrImageView(
                          data: '1234567890',
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                        */
                              ],
                            ),
                            Column(
                              children: [
                                QrImageView(
                                  data: '1234567890',
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Print Birch ใบเสร็จ',
                        style: TextStyle(fontSize: 8)),
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             Testpage2() ));

                      //_print();

                      final directory =
                          (await getApplicationDocumentsDirectory()).path;

                      // screenshotController.captureAndSave(directory,
                      //     fileName: "qr.png");

                      await screenshotController.captureAndSave(directory,
                          fileName: "qr.jpg");

                      final externalStorageFolder =
                          await getExternalStorageDirectory();

                      // Fluttertoast.showToast(
                      //     msg: externalStorageFolder!.path + "/Downloads",
                      //     toastLength: Toast.LENGTH_LONG,
                      //     fontSize: 20,
                      //     backgroundColor: Colors.green);

                      final public_directory =
                          externalStorageFolder!.absolute.path + "/Download";
                      await screenshotController
                          .captureAndSave(public_directory, fileName: "qr.jpg");

                      screenshotController
                          .capture(delay: Duration(milliseconds: 10))
                          .then((capturedImage) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();

                        await imagePath.writeAsBytes(capturedImage!);

                        //_print();
                        //PrintCapturedWidget(capturedImage!);
                        print_via_sdk1();
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Print Birch Label',
                        style: TextStyle(fontSize: 8)),
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             Testpage2() ));

                      //_print();

                      final directory =
                          (await getApplicationDocumentsDirectory()).path;

                      // screenshotController.captureAndSave(directory,
                      //     fileName: "qr.png");

                      await screenshotController.captureAndSave(directory,
                          fileName: "qr.jpg");

                      final externalStorageFolder =
                          await getExternalStorageDirectory();

                      // Fluttertoast.showToast(
                      //     msg: externalStorageFolder!.path + "/Downloads",
                      //     toastLength: Toast.LENGTH_LONG,
                      //     fontSize: 20,
                      //     backgroundColor: Colors.green);

                      final public_directory =
                          externalStorageFolder!.absolute.path + "/Download";
                      await screenshotController
                          .captureAndSave(public_directory, fileName: "qr.jpg");

                      screenshotController
                          .capture(delay: Duration(milliseconds: 10))
                          .then((capturedImage) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();

                        await imagePath.writeAsBytes(capturedImage!);

                        //_print();
                        //PrintCapturedWidget(capturedImage!);
                        print_via_sdk2();
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Print Epson Receipt',
                        style: TextStyle(fontSize: 8)),
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             Testpage2() ));

                      //_print();

                      final directory =
                          (await getApplicationDocumentsDirectory()).path;

                      // screenshotController.captureAndSave(directory,
                      //     fileName: "qr.png");

                      await screenshotController.captureAndSave(directory,
                          fileName: "qr.jpg");

                      final externalStorageFolder =
                          await getExternalStorageDirectory();

                      // Fluttertoast.showToast(
                      //     msg: externalStorageFolder!.path + "/Downloads",
                      //     toastLength: Toast.LENGTH_LONG,
                      //     fontSize: 20,
                      //     backgroundColor: Colors.green);

                      final public_directory =
                          externalStorageFolder!.absolute.path + "/Download";
                      await screenshotController
                          .captureAndSave(public_directory, fileName: "qr.jpg");

                      screenshotController
                          .capture(delay: Duration(milliseconds: 10))
                          .then((capturedImage) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();

                        await imagePath.writeAsBytes(capturedImage!);

                        //_print();
                        //PrintCapturedWidget(capturedImage!);
                        print_via_sdk3();
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
