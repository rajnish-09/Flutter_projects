import 'dart:convert';

import 'package:http/http.dart' as http;

class KhaltiServicePidx {
  final url = "http://192.168.18.7:3000/pay";
  Future<String> getPidxFromKhalti() async {
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String pidx = data['pidx'];
        return pidx;
      } else {
        return '';
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
