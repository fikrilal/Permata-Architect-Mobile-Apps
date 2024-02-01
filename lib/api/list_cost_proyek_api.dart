import 'dart:convert';

import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';
import 'package:http/http.dart' as http;

import '../repository/api/api_config.dart';

class GetListCostProyekService {

  Future<List<ListCostProyek>> listproyekCost() async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/pengeluaran_proyek');
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
