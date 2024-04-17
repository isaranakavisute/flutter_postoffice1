package com.example.postoffice_queuesystem

//import com.example.postoffice_queuesystem.FlutterUsbPrinterPlugin
/*FlutterPlugin, MethodCallHandler, ActivityAware,*/

//import io.flutter.embedding.android.FlutterActivity

//import androidx.annotation.NonNull

//import com.example.postoffice_queuesystem.adapter.USBPrinterAdapter

//import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Environment.DIRECTORY_DOWNLOADS
import android.system.Os
import android.system.Os.getenv
import android.util.Base64
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import com.epson.epos2.Epos2CallbackCode
import com.epson.epos2.Epos2Exception
import com.epson.epos2.printer.Printer
import com.epson.epos2.printer.PrinterStatusInfo
import com.epson.eposprint.Print
import com.example.postoffice_queuesystem.adapter.USBPrinterAdapter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import net.posprinter.POSConnect
import net.posprinter.POSConst
import net.posprinter.POSPrinter
import net.posprinter.TSCConst
import net.posprinter.TSCConst.BMP_MODE_OVERWRITE
import net.posprinter.TSCPrinter
import kotlin.random.Random
import com.epson.epos2.printer.ReceiveListener
import kotlinx.coroutines.awaitAll


class MainActivity: FlutterActivity(), View.OnClickListener , ReceiveListener



{
    private var adapter: USBPrinterAdapter? = null
    private lateinit var context: Context

    //private val ACTION_USB_PERMISSION = "com.emteria.usbpermissions.USB_PERMISSION";
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) 
    {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setMethodCallHandler {
          call, result ->
            if(call.method == "getRandomNumber") 
            {
              val rand = Random.nextInt(100)
              result.success(rand)
            }
            //getUSBDeviceList(result)
            else if (call.method == "getUSBDeviceList") 
            {
                //val rand = Random.nextInt(100)
                //result.success(rand)
                getUSBDeviceList(result)
            } 
            else if (call.method == "connect" )
            {
             val vendorId = call.argument<Int>("vendorId")
             val productId = call.argument<Int>("productId")
             connect(vendorId!!, productId!!, result)
            }
            else if (call.method == "write")
            {
             val data = call.argument<ByteArray>("data")
             write(data, result)
            }
            else if (call.method == "print_via_sdk1")
            {
                //val data = call.argument<ByteArray>("data")
                val data = call.argument<String>("data")
                //Base64.decode(data)
                //var data = call.argument<ByteArrayInputStream>("data");
                //val data = ByteArrayInputStream(argData as ByteArray)
                //data = data.readBytes()
                //print_via_sdk(data!!.toByteArray(), result)
                print_via_sdk1(Base64.decode(data, Base64.DEFAULT), result)
            }
            else if (call.method == "print_via_sdk2")
            {
                //val data = call.argument<ByteArray>("data")
                val data = call.argument<String>("data")
                //Base64.decode(data)
                //var data = call.argument<ByteArrayInputStream>("data");
                //val data = ByteArrayInputStream(argData as ByteArray)
                //data = data.readBytes()
                //print_via_sdk(data!!.toByteArray(), result)
                print_via_sdk2(Base64.decode(data, Base64.DEFAULT), result)
            }
            else if (call.method == "print_via_sdk3")
            {
                //val data = call.argument<ByteArray>("data")
                val data = call.argument<String>("data")
                //Base64.decode(data)
                //var data = call.argument<ByteArrayInputStream>("data");
                //val data = ByteArrayInputStream(argData as ByteArray)
                //data = data.readBytes()
                //print_via_sdk(data!!.toByteArray(), result)
                print_via_sdk3(Base64.decode(data, Base64.DEFAULT), result)
            }
            else 
            {
              result.notImplemented()
            }
        }
    }


    private fun getUSBDeviceList(result: Result) 
    {
        adapter = USBPrinterAdapter().getInstance()
        context = getApplicationContext()
        adapter!!.init(context)

        //TSCPrinter.
        //POSPrinter
        POSConnect.init(context);

        val usbDevices = adapter!!.getDeviceList()
        val list = ArrayList<HashMap<String, String?>>()
        for (usbDevice in usbDevices) {
          val deviceMap: HashMap<String, String?> = HashMap()
          deviceMap["deviceName"] = usbDevice.deviceName
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            deviceMap["manufacturer"] = usbDevice.manufacturerName
          }else{
            deviceMap["manufacturer"] = "unknown";
          }
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            deviceMap["productName"] = usbDevice.productName
          }else{
            deviceMap["productName"] = "unknown";
          }
          deviceMap["deviceId"] = Integer.toString(usbDevice.deviceId)
          deviceMap["vendorId"] = Integer.toString(usbDevice.vendorId)
          deviceMap["productId"] = Integer.toString(usbDevice.productId)
          list.add(deviceMap)
          print("usbDevice ${usbDevice}");
        }
        result.success(list)
    }


    private fun connect(vendorId: Int, productId: Int, result: Result) {
        if (!adapter!!.selectDevice(vendorId!!, productId!!)) {
          result.success(false)
        } else {
          result.success(true)
        }
      }

     private fun write(bytes: ByteArray?, result: Result) {
        bytes?.let { adapter!!.write(it) }
        result.success(true)
      }

     private fun print_via_sdk1(bytes: ByteArray?, result: Result) {
         context = getApplicationContext()
         var mPrinter: Printer? = null
         Toast.makeText(context, "start epson", Toast.LENGTH_SHORT).show()
         runOnUiThread {
             Thread {
//                  try {
//                      mPrinter = Printer(Printer.TM_T82,Printer.MODEL_THAI, context)
//                  }
//                  catch (e: Epos2Exception)
//                  {
//                      return@Thread
//                  }
                //  try
                //  {
                //      if (mPrinter != null)
                //       mPrinter!!.connect("USB:", Print.PARAM_DEFAULT)
                //      else
                //          return@Thread
                //  }
                //  catch (e: Epos2Exception)
                //  {
                //      return@Thread
                //  }
                //  val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
                //  val options = BitmapFactory.Options()
                //  options.inSampleSize = 2
                //  val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
                //  try {
                //      mPrinter!!.addImage(
                //          printBmp, 0, 0,
                //          printBmp.getWidth(),
                //          printBmp.getHeight(),
                //          Printer.COLOR_1,
                //          Printer.MODE_MONO,
                //          Printer.HALFTONE_DITHER,
                //          Printer.PARAM_DEFAULT.toDouble(),
                //          Printer.COMPRESS_AUTO
                //      );
                    
                //  }
                //  catch (e: Epos2Exception)
                //  {
                    
                //      return@Thread
                //  }
                //  try { mPrinter!!.addFeedLine(2) }  catch (e: Epos2Exception) { return@Thread }
                //  try { mPrinter!!.sendData(Printer.PARAM_DEFAULT) } catch (e: Epos2Exception) { return@Thread }
             }.start()

         }


         //return   

         


         //TSCPrinter.
         //POSPrinter
         POSConnect.init(context)
         val usb_pathname = POSConnect.getUsbDevices(context)
         val connect = POSConnect.createDevice(POSConnect.DEVICE_TYPE_USB)

         if (usb_pathname.count() == 0) {
             result.success(false)
             Toast.makeText(context, "Device is not connected", Toast.LENGTH_SHORT).show()
             return
         }



         connect.connect(usb_pathname[0]) { code, msg ->
             if (code == POSConnect.CONNECT_SUCCESS)
             {
                 //Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
                 //Log.i("tag", "device connect success")
                 //Toast.makeText(context, "Printer connected", Toast.LENGTH_SHORT).show()

                 //val printer = POSPrinter(connect)
                 //TSCPrinter(connect)


                //  POSPrinter(connect).printerStatus {
                //      val msg = when (it) {
                //          POSConst.STS_NORMAL -> "Printer status:Normal"
                //          POSConst.STS_COVEROPEN -> "Printer status:Cover Open"
                //          POSConst.STS_PAPEREMPTY -> "Printer status:Out of Paper"
                //          else -> "UNKNOWN"
                //      }
                //      Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
                //  }

                 //POSPrinter(connect).printString("test")
                 //POSPrinter(connect).initializePrinter().printString("test")

                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST1")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST2")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST3")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST4")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST5")


//                 TSCPrinter(connect).sizeMm(60.0, 30.0)
//                 .density(10)
//                 .reference(0, 0)
//                 .direction(TSCConst.DIRECTION_FORWARD)
//                 .cls()
//                 .text(10, 10, TSCConst.FNT_8_12, 2, 2, "123456")
//                 .print()

//                 POSPrinter(connect).printString("This is a test1")
//                     .feedLine()
//                     .printString("This is a test2")
//                     .feedLine()
//                     .printString("This is a test3")
//                     .feedLine()
//                     .printString("This is a test4")
//                     .feedLine()
//                     .printString("This is a test5")
//                     .feedLine()
//                     .feedLine()

                 //final directory = (await getApplicationDocumentsDirectory()).path;
                 //screenshotController.captureAndSave(directory, fileName: "qr.png");
                 //val path = Paths.get("").toAbsolutePath().toString()
                 //Paths.get("")
                 //var path = context.getApplicationInfo().dataDir
                 val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
                 //Toast.makeText(context, path, Toast.LENGTH_SHORT).show()
                 //Toast.makeText(context, path + "/qr.jpg", Toast.LENGTH_SHORT).show()
                 //val printBmp = BitmapFactory.decodeFile(path + "/qr.jpg")
                 val options = BitmapFactory.Options()
                 options.inSampleSize = 2
                 val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
                 //val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                 //val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.length)
//                 val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes!!.size)
//                if (printBmp != null)
//                    Toast.makeText(context, "Imaging done", Toast.LENGTH_SHORT).show()
//                else
//                    Toast.makeText(context, "Imaging failed", Toast.LENGTH_SHORT).show()

                 POSPrinter(connect).printBitmap(printBmp, POSConst.ALIGNMENT_CENTER, printBmp.width)
                     .feedLine()
                     .feedLine()

//                 TSCPrinter(connect).sizeMm(60.0, 30.0)
//                 .density(10)
//                 .reference(0, 0)
//                 .direction(TSCConst.DIRECTION_FORWARD)
//                 .cls()
//                 .text(10, 10, TSCConst.FNT_8_12, 2, 2, "123456")
//                 .print()

                 //TSCPrinter(connect).bitmap(0, 0, BMP_MODE_OVERWRITE, printBmp.width, printBmp)

//                 TSCPrinter(connect).sizeMm(60.0, 40.0)
//                     .gapMm(2.0, 0.0)
//                     .cls()
//                     .bitmap(0, 0, TSCConst.BMP_MODE_OVERWRITE, 400, printBmp)
//                     .print(1)


//                 val byteBuffer = ByteBuffer.allocate(printBmp.getByteCount())
//                 printBmp.copyPixelsToBuffer(byteBuffer)
//                 byteBuffer.rewind()

//                 var baos: ByteArrayOutputStream? = null
//                 baos = ByteArrayOutputStream()
//                 printBmp.compress(Bitmap.CompressFormat.JPEG, 100, baos)
//                 POSPrinter(connect).sendData(baos.toByteArray())


                //  val intent = Intent(Intent.ACTION_GET_CONTENT)
                //  intent.addCategory(Intent.CATEGORY_OPENABLE)
                //  intent.type = "image/*"
                //  val b = MediaStore.Images.Media.getBitmap(contentResolver,intent.data)
                //  printer.printBitmap(b, POSConst.ALIGNMENT_CENTER, 384)
                //      .feedLine()
                //      .cutHalfAndFeed(1)












//                 val str = "Test"
//                 val str_byte = str.toByteArray()
//                 TSCPrinter(connect).sendData(str_byte)
//                 Toast.makeText(context, "done", Toast.LENGTH_SHORT).show()

//                 printer.printerStatus {
//                     if (it == POSConst.STS_NORMAL)
//                     {
//                         Toast.makeText(context, "Printer status:OK", Toast.LENGTH_SHORT).show()
//                     }
//                     else
//                     {
//                         Toast.makeText(context, "Printer status:FAIL", Toast.LENGTH_SHORT).show()
//                     }
//                 }

//                 printer.printerStatus {
//                     val msg = when (it) {
//                         POSConst.STS_NORMAL -> "Printer status:Normal"
//                         POSConst.STS_COVEROPEN -> "Printer status:Cover Open"
//                         POSConst.STS_PAPEREMPTY -> "Printer status:Out of Paper"
//                         else -> "UNKNOWN"
//                     }
//                     Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
//                 }

//                 val str = "Test"
//                 val str_byte = str.toByteArray()
//                 connect.sendData(str_byte)
//                 Toast.makeText(context, "Connect Object prints", Toast.LENGTH_SHORT).show()
//                 printer.initializePrinter().printString("test")
//                 Toast.makeText(context, "Printer initialized", Toast.LENGTH_SHORT).show()
//                 val ret = printer.printString("test")
//                 Toast.makeText(context, "Printer printed", Toast.LENGTH_SHORT).show()
//                 //val str = "Test"
//                 //val str_byte = str.toByteArray()
//                 printer.sendData(str_byte)
//                 Toast.makeText(context, "Printer printed with byte", Toast.LENGTH_SHORT).show()

                   //connect.close()
             }
             else if (code == POSConnect.CONNECT_FAIL)
             {
                 Log.i("tag","device connect fail")
                 Toast.makeText(context, "Device is not connected", Toast.LENGTH_SHORT).show()
             }
         }


         result.success(true)
     }


    private fun print_via_sdk2(bytes: ByteArray?, result: Result) {
        context = getApplicationContext()
        var mPrinter: Printer? = null
        Toast.makeText(context, "start epson", Toast.LENGTH_SHORT).show()
        runOnUiThread {
            Thread {
//                  try {
//                      mPrinter = Printer(Printer.TM_T82,Printer.MODEL_THAI, context)
//                  }
//                  catch (e: Epos2Exception)
//                  {
//                      return@Thread
//                  }
                //  try
                //  {
                //      if (mPrinter != null)
                //       mPrinter!!.connect("USB:", Print.PARAM_DEFAULT)
                //      else
                //          return@Thread
                //  }
                //  catch (e: Epos2Exception)
                //  {
                //      return@Thread
                //  }
                //  val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
                //  val options = BitmapFactory.Options()
                //  options.inSampleSize = 2
                //  val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
                //  try {
                //      mPrinter!!.addImage(
                //          printBmp, 0, 0,
                //          printBmp.getWidth(),
                //          printBmp.getHeight(),
                //          Printer.COLOR_1,
                //          Printer.MODE_MONO,
                //          Printer.HALFTONE_DITHER,
                //          Printer.PARAM_DEFAULT.toDouble(),
                //          Printer.COMPRESS_AUTO
                //      );

                //  }
                //  catch (e: Epos2Exception)
                //  {

                //      return@Thread
                //  }
                //  try { mPrinter!!.addFeedLine(2) }  catch (e: Epos2Exception) { return@Thread }
                //  try { mPrinter!!.sendData(Printer.PARAM_DEFAULT) } catch (e: Epos2Exception) { return@Thread }
            }.start()

        }


        //return




        //TSCPrinter.
        //POSPrinter
        POSConnect.init(context)
        val usb_pathname = POSConnect.getUsbDevices(context)
        val connect = POSConnect.createDevice(POSConnect.DEVICE_TYPE_USB)

        if (usb_pathname.count() == 0) {
            result.success(false)
            Toast.makeText(context, "Device is not connected", Toast.LENGTH_SHORT).show()
            return
        }



        connect.connect(usb_pathname[0]) { code, msg ->
            if (code == POSConnect.CONNECT_SUCCESS)
            {
                //Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
                //Log.i("tag", "device connect success")
                //Toast.makeText(context, "Printer connected", Toast.LENGTH_SHORT).show()

                //val printer = POSPrinter(connect)
                //TSCPrinter(connect)


                //  POSPrinter(connect).printerStatus {
                //      val msg = when (it) {
                //          POSConst.STS_NORMAL -> "Printer status:Normal"
                //          POSConst.STS_COVEROPEN -> "Printer status:Cover Open"
                //          POSConst.STS_PAPEREMPTY -> "Printer status:Out of Paper"
                //          else -> "UNKNOWN"
                //      }
                //      Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
                //  }

                //POSPrinter(connect).printString("test")
                //POSPrinter(connect).initializePrinter().printString("test")

                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST1")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST2")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST3")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST4")
                //  TSCPrinter(connect).text(0,0, TSCConst.FNT_8_12,"THIS IS MY TEST5")


//                 TSCPrinter(connect).sizeMm(60.0, 30.0)
//                 .density(10)
//                 .reference(0, 0)
//                 .direction(TSCConst.DIRECTION_FORWARD)
//                 .cls()
//                 .text(10, 10, TSCConst.FNT_8_12, 2, 2, "123456")
//                 .print()

//                 POSPrinter(connect).printString("This is a test1")
//                     .feedLine()
//                     .printString("This is a test2")
//                     .feedLine()
//                     .printString("This is a test3")
//                     .feedLine()
//                     .printString("This is a test4")
//                     .feedLine()
//                     .printString("This is a test5")
//                     .feedLine()
//                     .feedLine()

                //final directory = (await getApplicationDocumentsDirectory()).path;
                //screenshotController.captureAndSave(directory, fileName: "qr.png");
                //val path = Paths.get("").toAbsolutePath().toString()
                //Paths.get("")
                //var path = context.getApplicationInfo().dataDir
                val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
                //Toast.makeText(context, path, Toast.LENGTH_SHORT).show()
                //Toast.makeText(context, path + "/qr.jpg", Toast.LENGTH_SHORT).show()
                //val printBmp = BitmapFactory.decodeFile(path + "/qr.jpg")
                val options = BitmapFactory.Options()
                options.inSampleSize = 2
                val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
                //val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                //val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.length)
//                 val printBmp = BitmapFactory.decodeByteArray(bytes, 0, bytes!!.size)
//                if (printBmp != null)
//                    Toast.makeText(context, "Imaging done", Toast.LENGTH_SHORT).show()
//                else
//                    Toast.makeText(context, "Imaging failed", Toast.LENGTH_SHORT).show()

//                 POSPrinter(connect).printBitmap(printBmp, POSConst.ALIGNMENT_CENTER, printBmp.width)
//                     .feedLine()
//                     .feedLine()

//                 TSCPrinter(connect).sizeMm(60.0, 30.0)
//                 .density(10)
//                 .reference(0, 0)
//                 .direction(TSCConst.DIRECTION_FORWARD)
//                 .cls()
//                 .text(10, 10, TSCConst.FNT_8_12, 2, 2, "123456")
//                 .print()

                //TSCPrinter(connect).bitmap(0, 0, BMP_MODE_OVERWRITE, printBmp.width, printBmp)

                TSCPrinter(connect).sizeMm(60.0, 40.0)
                    .gapMm(2.0, 0.0)
                    .cls()
                    .bitmap(0, 0, TSCConst.BMP_MODE_OVERWRITE, 400, printBmp)
                    .print(1)


//                 val byteBuffer = ByteBuffer.allocate(printBmp.getByteCount())
//                 printBmp.copyPixelsToBuffer(byteBuffer)
//                 byteBuffer.rewind()

//                 var baos: ByteArrayOutputStream? = null
//                 baos = ByteArrayOutputStream()
//                 printBmp.compress(Bitmap.CompressFormat.JPEG, 100, baos)
//                 POSPrinter(connect).sendData(baos.toByteArray())


                //  val intent = Intent(Intent.ACTION_GET_CONTENT)
                //  intent.addCategory(Intent.CATEGORY_OPENABLE)
                //  intent.type = "image/*"
                //  val b = MediaStore.Images.Media.getBitmap(contentResolver,intent.data)
                //  printer.printBitmap(b, POSConst.ALIGNMENT_CENTER, 384)
                //      .feedLine()
                //      .cutHalfAndFeed(1)












//                 val str = "Test"
//                 val str_byte = str.toByteArray()
//                 TSCPrinter(connect).sendData(str_byte)
//                 Toast.makeText(context, "done", Toast.LENGTH_SHORT).show()

//                 printer.printerStatus {
//                     if (it == POSConst.STS_NORMAL)
//                     {
//                         Toast.makeText(context, "Printer status:OK", Toast.LENGTH_SHORT).show()
//                     }
//                     else
//                     {
//                         Toast.makeText(context, "Printer status:FAIL", Toast.LENGTH_SHORT).show()
//                     }
//                 }

//                 printer.printerStatus {
//                     val msg = when (it) {
//                         POSConst.STS_NORMAL -> "Printer status:Normal"
//                         POSConst.STS_COVEROPEN -> "Printer status:Cover Open"
//                         POSConst.STS_PAPEREMPTY -> "Printer status:Out of Paper"
//                         else -> "UNKNOWN"
//                     }
//                     Toast.makeText(context, msg, Toast.LENGTH_SHORT).show()
//                 }

//                 val str = "Test"
//                 val str_byte = str.toByteArray()
//                 connect.sendData(str_byte)
//                 Toast.makeText(context, "Connect Object prints", Toast.LENGTH_SHORT).show()
//                 printer.initializePrinter().printString("test")
//                 Toast.makeText(context, "Printer initialized", Toast.LENGTH_SHORT).show()
//                 val ret = printer.printString("test")
//                 Toast.makeText(context, "Printer printed", Toast.LENGTH_SHORT).show()
//                 //val str = "Test"
//                 //val str_byte = str.toByteArray()
//                 printer.sendData(str_byte)
//                 Toast.makeText(context, "Printer printed with byte", Toast.LENGTH_SHORT).show()

                //connect.close()
            }
            else if (code == POSConnect.CONNECT_FAIL)
            {
                Log.i("tag","device connect fail")
                Toast.makeText(context, "Device is not connected", Toast.LENGTH_SHORT).show()
            }
        }


        result.success(true)
    }

    private fun print_via_sdk3(bytes: ByteArray?, result: Result) 
    {//Runtime.getRuntime().exec("")
      //val envVar : String? = System.getenv("persist.sys.oplus.otg_support")
        // val envVar : String? = Os.getenv("persist.sys.oplus.otg_support")
      //Os.setenv("persist.sys.oplus.otg_support", "1", true)

        //val variable = "whatever..."
        //val envVar : String? = getenv("persist.sys.oplus.otg_support").toString()



      context = getApplicationContext()
      Toast.makeText(context,envVar, Toast.LENGTH_SHORT).show()

      return

      val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
      val options = BitmapFactory.Options()
      options.inSampleSize = 2
      val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
      var mPrinter: Printer? = null
        var isConnected = 0
      Toast.makeText(context, "start epson1", Toast.LENGTH_SHORT).show()
      if (mPrinter != null)
       Toast.makeText(context, "start off: non-null printer object", Toast.LENGTH_SHORT).show()
      else
      Toast.makeText(context, "start off: null object", Toast.LENGTH_SHORT).show()
      mPrinter = Printer(Printer.TM_T82,Printer.MODEL_SOUTHASIA, context)
      if (mPrinter != null)
      {
       mPrinter!!.setReceiveEventListener(this);
       Toast.makeText(context, "success: printer object", Toast.LENGTH_SHORT).show()
      }
      else
       Toast.makeText(context, "null: printer object", Toast.LENGTH_SHORT).show()
      mPrinter!!.addImage(
                       printBmp, 0, 0,
                       printBmp.getWidth(),
                       printBmp.getHeight(),
                       Printer.COLOR_1,
                       Printer.MODE_MONO,
                       Printer.HALFTONE_DITHER,
                       Printer.PARAM_DEFAULT.toDouble(),
                       Printer.COMPRESS_AUTO)
      Toast.makeText(context, "success: add image to printer", Toast.LENGTH_SHORT).show()
      //mPrinter.connect("USB:", Printer.PARAM_DEFAULT)
      //mPrinter.connect("USB:", 300000)
      synchronized(this)
        {
            mPrinter.connect("USB:", 300000)
        }
      //300000
      Toast.makeText(context, "success: connect printer", Toast.LENGTH_SHORT).show()
      // runOnUiThread {
      //  Thread {
           
      //      mPrinter.connect("USB:", Printer.PARAM_DEFAULT);
      //      Toast.makeText(context, "success: connect printer", Toast.LENGTH_SHORT).show()
      //  }.start()
      // }
//      mPrinter.connect("USB:", Printer.PARAM_DEFAULT);
//      Toast.makeText(context, "success: connect printer", Toast.LENGTH_SHORT).show()
      //mPrinter.sendData(Printer.PARAM_DEFAULT)
      //300000
      synchronized(this)
      {
       mPrinter.sendData(300000)
      }
      Toast.makeText(context, "success: connect send data to printer", Toast.LENGTH_SHORT)
//      runOnUiThread {
//            Thread {
//                mPrinter.sendData(Printer.PARAM_DEFAULT);
//                Toast.makeText(context, "success: connect send data to printer", Toast.LENGTH_SHORT).show()
//            }.start()
//        }
//      mPrinter.sendData(Printer.PARAM_DEFAULT);
      // mPrinter.disconnect()
      // Toast.makeText(context, "success: disconnect printer", Toast.LENGTH_SHORT).show()
      Toast.makeText(context, "done", Toast.LENGTH_SHORT).show()
      

                //   try
                //   {
                  
                //    mPrinter = Printer(Printer.TM_T82,Printer.MODEL_SOUTHASIA, context)
                //   }
                //   catch (e: Epos2Exception)
                //   {
                //       Toast.makeText(context, "error", Toast.LENGTH_SHORT).show()
                //   }
                //  if (mPrinter != null)
                //   mPrinter!!.setReceiveEventListener(this);
                //  else
                //      Toast.makeText(context, "null: printer object", Toast.LENGTH_SHORT).show()



      // runOnUiThread {
      //     Thread {

      //             var mPrinter: Printer? = null
      //             context = getApplicationContext()
      //             try
      //             {
      //              mPrinter = Printer(Printer.TM_T82,Printer.MODEL_THAI, context)
      //             }
      //             catch (e: Epos2Exception)
      //             {
      //                return@Thread
      //             }
      //            mPrinter.setReceiveEventListener(this);

              //  try
              //  {
              //      if (mPrinter != null)
              //       mPrinter!!.connect("USB:", Print.PARAM_DEFAULT)
              //      else
              //          return@Thread
              //  }
              //  catch (e: Epos2Exception)
              //  {
              //      return@Thread
              //  }
              //  val externalFilesDir = context.getExternalFilesDir(DIRECTORY_DOWNLOADS)
              //  val options = BitmapFactory.Options()
              //  options.inSampleSize = 2
              //  val printBmp = BitmapFactory.decodeFile(externalFilesDir!!.absolutePath + "/qr.jpg", options)
              //  try {
              //      mPrinter!!.addImage(
              //          printBmp, 0, 0,
              //          printBmp.getWidth(),
              //          printBmp.getHeight(),
              //          Printer.COLOR_1,
              //          Printer.MODE_MONO,
              //          Printer.HALFTONE_DITHER,
              //          Printer.PARAM_DEFAULT.toDouble(),
              //          Printer.COMPRESS_AUTO
              //      );

              //  }
              //  catch (e: Epos2Exception)
              //  {

              //      return@Thread
              //  }
              //  try { mPrinter!!.addFeedLine(2) }  catch (e: Epos2Exception) { return@Thread }
              //  try { mPrinter!!.sendData(Printer.PARAM_DEFAULT) } catch (e: Epos2Exception) { return@Thread }
      //     }.start()
      // }
      Toast.makeText(context, "end epson", Toast.LENGTH_SHORT).show()
      synchronized(this)
      {
       mPrinter.disconnect()
      }
      result.success(true)
  }

    override fun onPtrReceive(p0: Printer?, p1: Int, p2: PrinterStatusInfo?, p3: String?) {
      //  runOnUiThread{
      //      Thread {
      //          context = getApplicationContext()
      //          if (p1 == Epos2CallbackCode.CODE_SUCCESS)
      //              Toast.makeText(context, "printer object created", Toast.LENGTH_SHORT).show()
      //          else
      //              Toast.makeText(context, "callback called", Toast.LENGTH_SHORT).show()
      //      }.start()
      //  }
    }

    override fun onClick(p0: View?) {
        TODO("Not yet implemented")
    }


}
