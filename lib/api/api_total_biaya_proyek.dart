import 'dart:convert';

import 'package:permata_architect_mobile_apps/models/proyek_model/total_biaya_proyek.dart';
import 'package:http/http.dart' as http;

import '../models/auth_model/user_model.dart';
import '../repository/api/api_config.dart';

class TotalBiayaProyekService {
  Future<TotalBiayaProyek> getTotalProyek({String? idProyek}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/get_biaya');
    var body = jsonEncode({'id_proyek': idProyek});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    var infoData = jsonDecode(response.body)['meta'];
    UserInfo message = UserInfo.fromJson(infoData);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      TotalBiayaProyek biayaProyek = TotalBiayaProyek.fromJson(data);
      return biayaProyek;
    } else {
      throw Exception(message.message);
    }
  }
}
