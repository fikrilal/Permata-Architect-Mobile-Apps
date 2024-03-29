import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';

import '../repository/api/api_config.dart';

class GetListProyekService {

  Future<List<ListProyek>> listproyek() async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/proyek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data List Proyek : ${data}");
      List<ListProyek> listcost =
          (data as List).map((item) => ListProyek.fromJson(item)).toList();
      return listcost;
    } else {
      throw Exception('Gagal Load Data');
    }
  }

  Future<List<ListProyek>> carilistproyek({String? query}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/proyek?q=$query');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data List Proyek : $data");
      List<ListProyek> listcost =
          (data as List).map((item) => ListProyek.fromJson(item)).toList();
      return listcost;
    } else {
      throw Exception('Gagal Load Data');
    }
  }
}
