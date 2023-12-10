//import 'package:flutterclass1/models/news.dart';
//import 'package:flutterclass1/services/serviceApi.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
    doc.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
          child: pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight));
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
                          child: Column(children: [
                        Text(postalDetail!.fr_address!),
                        Text(postalDetail!.fr_address!),
                        Text(postalDetail!.det_county!),
                        Text(postalDetail!.pay_amount!),
                        Text(postalDetail!.fr_tel!),
                        Text(postalDetail!.cod_amount!),
                        Text(postalDetail!.fr_postcode!),
                        Text(postalDetail!.dimension!),
                        Text(postalDetail!.service_items!),
                        Text(postalDetail!.det_name!),
                        Text(postalDetail!.det_address!),
                        Text(postalDetail!.cod_account!),
                        Text(postalDetail!.det_moo!),
                        Text(postalDetail!.app!),
                        Text(postalDetail!.tracking!),
                        Text(postalDetail!.fr_district!),
                        Text(postalDetail!.fr_country_iso!),
                        Text(postalDetail!.price!),
                        Text(postalDetail!.merchant!),
                        Text(postalDetail!.weight!),
                        Text(postalDetail!.sta!),
                        Text(postalDetail!.det_district!),
                        Text(postalDetail!.itm!),
                        Text(postalDetail!.itm_sku!),
                        Text(postalDetail!.fr_county!),
                        Text(postalDetail!.det_country_iso!),
                        Text(postalDetail!.fr_gps!),
                        Text(postalDetail!.pay_id!),
                        Text(postalDetail!.det_tel!),
                        Text(postalDetail!.serv!),
                        Text(postalDetail!.log!),
                        Text(postalDetail!.fr_province!),
                        Text(postalDetail!.fr_name!),
                        Text(postalDetail!.fr_moo!),
                        Text(postalDetail!.det_province!),
                        Text(postalDetail!.det_gps!),
                        Text(postalDetail!.det_postcode!),
                        Text(postalDetail!.distance!),
                        QrImageView(
                          data: '1234567890',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
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
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final imagePath =
                                  await File('${directory.path}/image.png')
                                      .create();

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
                      ])))
                  : SizedBox()
            ],
          );
        }),
      ),
    );
  }
}
