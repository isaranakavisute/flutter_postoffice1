//import 'package:flutterclass1/models/news.dart';
//import 'package:flutterclass1/services/serviceApi.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:postoffice_queuesystem/models/postalDetail.dart';
import 'package:postoffice_queuesystem/services/serviceApi.dart';
//import 'package:flutterclass1/widget/AlertDialogYesNo.dart';
//import 'package:flutterclass1/widget/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Printpage extends StatefulWidget {
  Printpage({super.key, required this.id});
  String id;
  @override
  State<Printpage> createState() => _PrintpageState();
}

class _PrintpageState extends State<Printpage> {
  PostalDetail? postalDetail;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPostalDetailById();
    });
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      screenshotController.captureAndSave(directory, fileName: "qr.png");
      screenshotController
          .capture(delay: Duration(milliseconds: 10))
          .then((capturedImage) async {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        PrintCapturedWidget(capturedImage!);
      }).catchError((onError) {
        print(onError);
      });
    });
    _forceLandscape();
  }

  Future<void> getPostalDetailById() async {
    try {
      final _postalDetail =
          await ServiceApi.getPostalDetailById(qrcode_id: widget.id);
      //if (_postalDetail != null) {
      setState(() {
        postalDetail = _postalDetail;
      });
      //}
    } on Exception catch (e) {}

    //await Printing.layoutPdf(
    //onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
    //format: format,
    //html: '<html><body><p>Hello!</p></body></html>',
    //));
  }

  Future<void> send_printer() async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
              format: format,
              html: '<html><body><p>Hello!</p></body></html>',
            ));
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  Future<void> PrintCapturedWidget(Uint8List capturedImage) async {
    final doc = pw.Document();
    final directory = (await getApplicationDocumentsDirectory()).path;

    File myfile = File('${directory}/qr.png');
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

  Future<void> _forceLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _forcePortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  void dispose() async {
    _forcePortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    print(widget.id);
    //send_printer();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Print Page'),
      ),
      body: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          return Column(
            children: [
              orientation == Orientation.portrait
                  ? Screenshot(
                      controller: screenshotController,
                      child: Container(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(height: 100),
                              Text(
                                "TEST",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                postalDetail!.fr_address!,
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                postalDetail!.fr_address!,
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.left,
                              ),
                              /*
                              Text(postalDetail!.det_county!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.pay_amount!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_tel!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.cod_amount!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_postcode!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.dimension!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.service_items!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_name!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_address!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.cod_account!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_moo!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.app!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.tracking!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_district!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_country_iso!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.price!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.merchant!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.weight!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.sta!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_district!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.itm!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.itm_sku!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_county!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_country_iso!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_gps!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.pay_id!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_tel!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.serv!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.log!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_province!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_name!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.fr_moo!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_province!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_gps!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.det_postcode!,
                                  style: TextStyle(fontSize: 10)),
                              Text(postalDetail!.distance!,
                                  style: TextStyle(fontSize: 10)),
                              QrImageView(
                                data: 'EF194701965TH',
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                              */

                              /*
                              ElevatedButton(
                                child: Text('Print It'),
                                onPressed: () async {
                                  final directory =
                                      (await getApplicationDocumentsDirectory())
                                          .path;
                                  screenshotController.captureAndSave(directory,
                                      fileName: "qr.png");
                                  screenshotController
                                      .capture(
                                          delay: Duration(milliseconds: 10))
                                      .then((capturedImage) async {
                                    final directory =
                                        await getApplicationDocumentsDirectory();
                                    final imagePath = await File(
                                            '${directory.path}/image.png')
                                        .create();
                                    await imagePath
                                        .writeAsBytes(capturedImage!);

                                    PrintCapturedWidget(capturedImage!);
                                  }).catchError((onError) {
                                    print(onError);
                                  });
                                },
                              ),
                              */
                            ]),
                      )))
                  : SizedBox(),
              ElevatedButton(
                child: Text('Print It'),
                onPressed: () async {
                  final directory =
                      (await getApplicationDocumentsDirectory()).path;

                  screenshotController.captureAndSave(directory,
                      fileName: "qr.png");

                  /*
                                                showDialog(
                            useSafeArea: false,
                            context: context,
                            builder: (context) => Scaffold(
                                  appBar:
                                      AppBar(title: Text("Saved screenshot at:")),
                                  body: Center(
                                      child: Column(children: [
                                    Text('${directory}/qr.png'),
                                    Image.file(File('${directory}/qr.png')),
                                  ])),
                                ));
                                */

                  screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    //PrintCapturedWidget(capturedImage!);
                    //ShowCapturedWidget(context, capturedImage!);
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        await File('${directory.path}/image.png').create();

                    //print(imagePath.toString());
                    /*
                                                  showDialog(
                            useSafeArea: false,
                            context: context,
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                  title: Text("Captured widget screenshot")),
                              body: Center(child: Text(imagePath.toString())),
                            ),
                                                  );
                                                  */

                    await imagePath.writeAsBytes(capturedImage!);

                    PrintCapturedWidget(capturedImage!);

                    /*
                                                  showDialog(
                            useSafeArea: false,
                            context: context,
                            builder: (context) => Scaffold(
                              appBar: AppBar(title: Text("Saved screenshot at:")),
                              body: Center(child: Text(imagePath.toString())),
                            ),
                                                  );
                                                  */
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
