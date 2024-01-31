import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiTambahPengeluaran {
  Future<void> addPengeluaran({
    required String judulPengeluaran,
    required String keterangan,
    required String sumberDana,
    required int id,
    required int idProyek,
    required String satuan,
    required int quantity,
    required int hargaSatuan,
    required String vendor,
    required File image,
  }) async {
    try {
      final Uri url = Uri.parse('${ApiConfig.baseUrl}/add_pengeluaran');

      var request = http.MultipartRequest('POST', url)
        ..fields['judul_pengeluaran'] = judulPengeluaran
        ..fields['keterangan'] = keterangan
        ..fields['sumber_dana'] = sumberDana
        ..fields['id'] = id.toString()
        ..fields['id_proyek'] = idProyek.toString()
        ..fields['satuan'] = satuan
        ..fields['quantity'] = quantity.toString()
        ..fields['harga_satuan'] = hargaSatuan.toString()
        ..fields['vendor'] = vendor
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
      throw Exception("Network Error: $error");
    }
  }
}

