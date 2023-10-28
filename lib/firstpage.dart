
import 'package:flutter/material.dart';
import 'package:postoffice_queuesystem/secondpage.dart';


class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _Firstpage();
}

class _Firstpage extends State<Firstpage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //print(size)
      return Scaffold(
        backgroundColor: Colors.white,
        body:
               SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Secondpage()));
                        },
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
                  ],
                ),

            ),

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
                  //mage.asset('assets/images/footer.png'),
                  //Text('กรุณาเตร๊ยมบัตรประชาชนแสดงต่อเจ้าหน้าที่ในการฝากส่งสิ่งของ'),
                ],
              ),
            ),
      );
    }
  }

