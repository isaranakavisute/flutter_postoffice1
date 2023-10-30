import 'dart:convert';

import 'package:http/http.dart' as http;
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
}
