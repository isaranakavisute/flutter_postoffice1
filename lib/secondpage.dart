import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:postoffice_queuesystem/takepicture.dart';
import 'package:postoffice_queuesystem/services/serviceApi.dart';
import 'package:postoffice_queuesystem/models/queue.dart';
import 'dart:io';
//import 'package:mac_address/mac_address.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:postoffice_queuesystem/scanner.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

//import 'package:flutter/material.dart'

class Secondpage extends StatefulWidget {
  const Secondpage({super.key});

  @override
  State<Secondpage> createState() => _Secondpage();
}

class _Secondpage extends State<Secondpage> {
  int? queuenumber = 0;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getQueueNumber(
            queuetype: 'normal', postcode: '99999', macaddress: 'AABBCCDDEEFF');
      });
    });
  }

  Future<void> getQueueNumber(
      {required String queuetype,
      required String postcode,
      required String macaddress}) async {
    //get device mac address
    //String platformVersion;
    //try {
    //macaddress = await GetMac.macAddress;
    //} on PlatformException {}

    //await Printing.layoutPdf(
    //  onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
    //      format: format,
    //    html: '<html><body><p>Hello!</p></body></html>',
    // ));

    final queue = await ServiceApi.getQueueNumber(
        queuetype: queuetype, postcode: postcode, macaddress: macaddress);

    final _postalDetail =
        await ServiceApi.getPostalDetailById(qrcode_id: "EF194701965TH");
    //print(_postalDetail.fr_address);
    //inspect(_postalDetail.fr_address);

    setState(() {
      queuenumber = queue.qreceipt;
    });
  }

  Future<void> PrintCapturedWidget(Uint8List capturedImage) async {
    final doc = pw.Document();
    final directory = (await getApplicationDocumentsDirectory()).path;

    File myfile = File('${directory}/qr.png');
    final Uint8List byteList = await myfile.readAsBytes();
    doc.addPage(pw.Page(
        /*pageFormat:
            const PdfPageFormat(58 * PdfPageFormat.mm, 58 * PdfPageFormat.mm),*/
        margin: const pw.EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        build: (pw.Context context) {
          return pw.Center(
              //child: pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.cover));
              child: pw.Image(pw.MemoryImage(byteList)));

          /*
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Padding(
                    padding: pw.EdgeInsets.only(left: 100.0),
                    child: pw.Image(pw.MemoryImage(byteList),
                        alignment: pw.Alignment.center))
              ]);
          */
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * 0.20,
                    height: size.height * 0.20,
                    child: Image.asset('assets/images/thp_logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * 0.20,
                    height: size.height * 0.20,
                    child: Image.asset('assets/images/thp_address.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Screenshot(
              controller: screenshotController,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('หมายเลขคิวของท่าน')),
                    Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Text(queuenumber.toString(),
                            style:
                                TextStyle(fontSize: 100, color: Colors.blue))),
                  ]),
            ),
            Padding(
                padding: EdgeInsets.all(1.0),
                child: SizedBox(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  child: Image.asset('assets/images/download.png'),
                )
                //),
                ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ร่วมรักษาโลกโดยการไม่พิมพ์กระดาษ',
                      style: TextStyle(fontSize: 10, color: Colors.green)),
                  Text('โปรดใช้โทรศัพท์มือถือถ่ายรูปเลขคิวของท่าน',
                      style: TextStyle(fontSize: 10, color: Colors.green))
                ],
              ),
              //),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.06,
                  width: double.infinity,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                  child: Center(
                      child: Text(
                        'ถ่ายรูปแล้ว',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * 0.20,
                    height: size.height * 0.20,
                     child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.06,
                  width: double.infinity,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                  child: Center(
                      child: Text(
                        'พิมพ์บัตรคิว',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
                  ),
                ),
              ],
            ),
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    //flex: 5,
                    height: size.height * 0.12,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Scanner() /*Takepicture()*/));
                      },
                      child: Container(
                        //height: size.height * 0.06,
                        //width: size.width * 0.40,
                        //width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.blue),
                        child: Center(
                            child: Text(
                          'ถ่ายรูปแล้ว',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    //flex: 5,
                    height: size.height * 0.12,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () async {
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        screenshotController.captureAndSave(directory,
                            fileName: "qr.png");

                        screenshotController
                            .capture(delay: Duration(milliseconds: 10))
                            .then((capturedImage) async {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(capturedImage!);
                          PrintCapturedWidget(capturedImage!);
                        });
                      },
                      child: Container(
                        //height: size.height * 0.06,
                        //width: size.width * 0.40,
                        //width: double.infinity,
                        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.blue),
                        child: Center(
                            child: Text(
                          'พิมพ์บัตรคิว',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.06,
                  width: double.infinity,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                  child: Center(
                      child: Text(
                        'รับบัตรคิว',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return RegisterPage();
                  // }));
                },
                child: Container(
                  height: size.height * 0.06,
                  width: double.infinity,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                  child: Center(
                      child: Text(
                        'พิมพ์จ่าหน้า',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("This is 2nd page")
            ),
            */
          ],
        ),
      ),

      /*
      bottomNavigationBar: Container(
        height: size.height * 0.10,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.80,
                //height: size.height * 0.20,
                child: Image.asset('assets/images/footer.png'),
              ),
            )
          ],
        ),
      ),
      */
    );
  }
}
