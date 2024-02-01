import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:permata_architect_mobile_apps/models/proyek_model/list_progress_model.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_config.dart';

class GetListProgressService {
  Future<List<ListProgress>> listprogressAll() async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/get_progress');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data List Progress : $data");
      List<ListProgress> listProgress =
          (data as List).map((item) => ListProgress.fromJson(item)).toList();
      return listProgress;
    } else {
      throw Exception('Gagal Load Data');
    }
  }

  Future<List<ListProgress>> listprogressById({String? idProyek}) async {
    Uri url =
        Uri.parse('${ApiConfig.baseUrl}/get_progress?id_proyek=$idProyek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data List Progress byId : $data");
      List<ListProgress> listProgress =
          (data as List).map((item) => ListProgress.fromJson(item)).toList();
      return listProgress;
    } else {
      throw Exception('Gagal Load Data');
    }
  }
}
