import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:postoffice_queuesystem/models/postalDetail.dart';
import 'dart:convert' as convert;
import 'package:postoffice_queuesystem/models/queue.dart';

class ServiceApi {
  const ServiceApi();

  static Future<Queue> getQueueNumber(
      {required String queuetype,
      required String postcode,
      required String macaddress}) async {
    final url = Uri.http('pus2.thailandpost.com', 'que/qprint');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'typ': queuetype,
          'postcode': postcode,
          'macaddress': macaddress,
        }));
    final data = convert.jsonDecode(response.body);
    return Queue.fromJson(data);
  }

  static Future<PostalDetail> getPostalDetailById(
      {required String qrcode_id}) async {
    final url = Uri.http('pus2.thailandpost.com', 'redbox/items/get');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ckPrlkBJSCl60YPX5lMsMquj2Xa9cwAdoEbof6xNfoXkRneA2GZlIwnvO36jXhVwd5XjEZIZdL2WC3aKmm3e6lDbWj1Vcx0ylCcNGdbOLL0E6rjexKOOGtlSjTTic6c8'
          //FhmmzLQ4Hi52UQhewBlfmLfyyAgS5abUb1VaRbMS10BbGYpQphA73mf1qz3WSiJ8Umbu189pa4ksyvRUCSnjxzst3JA7GPlDAnG7uFi057vllCk6Z6wRIB2UKC5yBpyb'
          //yHTSulIUHmFyTmLQ6ByCPzG3mzgdOMzFX7ncFSrF99U8baxvp32EnuC8obUdskyxAJTYa6TNXt7DBmluxP1d5U7ZT5BizuEXx6nFlyTV2yH0zXXtgB4WYo1TzJAktUiL'
          //cviCbtHThVuyTSoVJaJXDyBDE6qYUSpDuKHurAZIIEP8cIll3Zl0avJsWBoD7DW9PElALOmnr8YgYveFJw8jOiHlF75vxyl4ZZdt50j7kiUHxpCc0h5pMS9ecBsppV90'
        },
        body: jsonEncode({
          'tracking': [qrcode_id /*"EF194701965TH"*/]
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      final utf = utf8.decode(bytes);
      final data = convert.jsonDecode(utf);
      //final data = convert.jsonDecode(response.body);
      print(data);
      final val =
          PostalDetail.fromJson(data['data'][qrcode_id /*'EF194701965TH'*/]);
      //print(jsonDecode(val.toString()));
      print(val.fr_address);
      return val;
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
