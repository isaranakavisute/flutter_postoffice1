
import 'package:flutter/material.dart';
import 'package:postoffice_queuesystem/secondpage.dart';


class Takepicture extends StatefulWidget {
  const Takepicture({super.key});

  @override
  State<Takepicture> createState() => _Takepicture();
}

class _Takepicture extends State<Takepicture> {

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
              child: Center(
                child:
                GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.6,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.grey),
                  child: Center(
                      child: Text(
                        'ภาพจาก Webcam',
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
             )
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('กรุณาแสดง QR Code ที่กล้อง Webcam',style: TextStyle(fontSize: 10,color: Colors.green))
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),



            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Secondpage()));
                },
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.25,
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                  child: Center(
                      child: Text(
                        'ย้อนกลับ',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            */


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Secondpage()));
                    },
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.25,
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.blue),
                      child: Center(
                          child: Text(
                            'ย้อนกลับ',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
            //mage.asset('assets/images/footer.png'),
            //Text('กรุณาเตร๊ยมบัตรประชาชนแสดงต่อเจ้าหน้าที่ในการฝากส่งสิ่งของ'),
          ],
        ),
      ),
      */

      
    );
  }
}

