import 'dart:convert';
import 'dart:io';

import '../models/auth_model/user_model.dart';
import '../repository/api/api_config.dart';
import 'package:http/http.dart' as http;

class ApiAddProgress {
  static Future<UserInfo> addprogress(
      {String? name,
      String? detailLokasi,
      String? progress,
      String? keteranganProgress,
      String? idProyek,
      File? image}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/add_progress');

    var request = http.MultipartRequest('POST', url)
      ..fields['name'] = name.toString()
      ..fields['detail_lokasi'] = detailLokasi.toString()
      ..fields['progress'] = progress.toString()
      ..fields['keterangan_progress'] = keteranganProgress.toString()
      ..fields['id_proyek'] = idProyek.toString()
      ..files.add(await http.MultipartFile.fromPath('image', image!.path));

    var response = await request.send();
    var infoData = await response.stream.bytesToString();
    if (response.statusCode != 200) {
      print("Server Error: ${response.statusCode} - $infoData");
    }
    var data = jsonDecode(infoData)['meta'];

    UserInfo message = UserInfo.fromJson(data);
    print("Response: $data");

    if (response.statusCode == 200) {
      return UserInfo(
          code: message.code, message: message.message, status: message.status);
    } else {
      throw Exception(message.message);
    }
  }
}
