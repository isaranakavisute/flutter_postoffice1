import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:printing/printing.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.amber, title: Text("")),
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      height: size.height * 0.05,
                      child: Container(
                          //decoration: BoxDecoration(border: Border.all()),
                          child: Image.asset('assets/images/thp_logo.png')),
                    ),
                    SizedBox(
                      width: size.width * 0.25,
                      height: size.height * 0.05,
                      child: Container(
                          //decoration: BoxDecoration(border: Border.all()),
                          child: Image.asset('assets/images/thp_address.png')),
                    ),
                  ],
                ),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text("Free Text สำหรับลูกค้าใส่รายละเอียด"),
                ),
                /*
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("Free Text สำหรับลูกค้าใส่รายละเอียด"),
            ),
            */
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
                          top: 25.0, bottom: 8.0, left: 8.0, right: 8.0),
                      child: SizedBox(
                        width: size.width * 0.25,
                        height: size.height * 0.05,
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
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
                          top: 25.0, bottom: 8.0, left: 8.0, right: 8.0),
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
              //SizedBox(height: 0.050),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 0.050),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Colors.white, fontSize: 15)),
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
                                          color: Colors.black, fontSize: 17)),
                                ),
                              ),
                            ),
                          ),
                        ]),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child: /*Text('EBKLS',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10)
                                  ),
                                  */
                                        Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('EBKLS',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10)),
                                    Text('12345678XJ-1/51',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10)),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          /*
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17)),
                        ),
                      ),
                    ),
                  ),
                  */
                        ]),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Colors.black, fontSize: 15)),
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
                                          color: Colors.black, fontSize: 17)),
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
          )
        ],
      )),
    ));
  }
}
