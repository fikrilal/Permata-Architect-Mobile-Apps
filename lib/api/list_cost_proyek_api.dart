import 'dart:convert';

import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';
import 'package:http/http.dart' as http;

class GetListCostProyekService {
  String baseUrl = 'http://192.168.0.105:8000/api';

  Future<List<ListCostProyek>> listproyekCost() async {
    Uri url = Uri.parse('$baseUrl/pengeluaran_proyek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      List<ListCostProyek> listcost =
          (data as List).map((item) => ListCostProyek.fromJson(item)).toList();
      return listcost;
    } else {
      throw Exception('Gagal Load Data');
    }
  }
}
