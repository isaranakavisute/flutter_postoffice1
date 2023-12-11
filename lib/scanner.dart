import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postoffice_queuesystem/printpage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:postoffice_queuesystem/secondpage.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:postoffice_queuesystem/printpage.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Stack(
        //Scaffold(
        //SingleChildScrollView(
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
          Column(
            children: <Widget>[
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
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    /*
                    Center(
                        child: WebviewScaffold(
                      url: "",
                      appBar: new AppBar(
                        title: new Text(''),
                      ),
                      withZoom: true,
                      withLocalStorage: true,
                    )),
                    */
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    /*
                    Center(
                        child: WebviewScaffold(
                         url: "",
                         appBar: new AppBar(
                          title: new Text(''),
                         ),
                        withZoom: true,
                        withLocalStorage: true,
                    )
                    ),
                    */
                  ],
                ),
              ),
              /*
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              ),
              */
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('กรุณาแสดง QR Code ที่กล้อง Webcam',
                        style: TextStyle(fontSize: 10, color: Colors.green))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Secondpage()));
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.25,
                        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.blue),
                        child: Center(
                            child: Text(
                          'ย้อนกลับ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  /*
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * 0.20,
                    height: size.height * 0.20,
                    child: Image.asset('assets/images/thp_address.png'),
                  ),
                ),
                */
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    //controller.flipCamera();
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      if (/*await canLaunch(scanData.code!)*/ true) {
        //Open Print Page
        //await launch(scanData.code!);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Printpage(id: scanData.code!)));

        /*
        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailNewsPage(
                                            id: news[0].id!,
                                          )));
        */

        /*
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
        */

        //controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}
