import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:permata_architect_mobile_apps/models/proyek_model/absensi_model.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_config.dart';

import '../models/auth_model/user_model.dart';

class GetAbsensiService {
  Future<List<AbsensiModel>> getabsensi({String? idProyek}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/get_absensi?id_proyek=$idProyek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print("Data Absensis Proyek : ${data}");
      List<AbsensiModel> absensis =
          (data as List).map((item) => AbsensiModel.fromJson(item)).toList();
      return absensis;
    } else {
      throw Exception('Gagal Load Data');
    }
  }

  Future<UserInfo> addAbsensi(
      {String? idProyek, String? idPekerja, String? statusAbsensi}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/add_absensi');
    var body = jsonEncode({
      'id_proyek': idProyek,
      'id_pekerja': idPekerja,
      'status_absensi': statusAbsensi
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    var infoData = jsonDecode(response.body)['meta'];
    UserInfo message = UserInfo.fromJson(infoData);

    if (response.statusCode == 200) {
      return UserInfo(
          code: message.code, message: message.message, status: message.status);
    } else {
      throw Exception(message.message);
    }
  }
}
