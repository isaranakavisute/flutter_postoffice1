import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:postoffice_queuesystem/models/queue.dart';

class ServiceApi {
  const ServiceApi();

  static Future<Queue> getQueueNumber(
      {required String queuetype,
      required String postcode,
      required String macaddress}) async {
    //final url = Uri.http('pus2.thailandpost.com', 'que/qprint');
    final url = Uri.http('localhost:8080', 'mock');
    //http://localhost:8080/mock
    final response = await http.post(url, body: {
      'typ': queuetype,
      'postcode': postcode,
      'macaddress': macaddress,
    });
    print(response.body);
    final data = convert.jsonDecode(response.body);
    //final data = response.body;
    print(data);
    return Queue.fromJson(data);
  }
}
