import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiTambahPemasukan {
  Future<void> addPemasukan({
    required int jumlahPemasukan,
    required String keterangan,
    required String sumberDana,
    required int id,
    required int id_proyek,
    required File image,
  }) async {
    try {
      final Uri url = Uri.parse('${ApiConfig.baseUrl}/add_pemasukan');

      var request = http.MultipartRequest('POST', url)
        ..fields['jumlah_pemasukan'] = jumlahPemasukan.toString()
        ..fields['keterangan'] = keterangan
        ..fields['sumber_dana'] = sumberDana
        ..fields['id'] = id.toString()
        ..fields['id_proyek'] = id_proyek.toString()
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception("Server Error: ${response.statusCode} - $responseBody");
      }

      var data = jsonDecode(responseBody);
      print("Response: $data");

    } catch (error) {
      print("Error: $error");
      throw Exception("Network Error: $error"); // Melempar Exception dengan pesan error.
    }
  }
}

