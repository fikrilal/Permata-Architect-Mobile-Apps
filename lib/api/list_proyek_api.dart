import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';

class GetListProyekService {
  String baseUrl = 'http://192.168.0.105:8000/api';

  Future<List<ListProyek>> listproyek() async {
    Uri url = Uri.parse('$baseUrl/proyek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data List Proyek : ${data}");
      List<ListProyek> listcost = (data['data'] as List)
          .map((item) => ListProyek.fromJson(item))
          .toList();
      return listcost;
    } else {
      throw Exception('Gagal Load Data');
    }
  }
}
