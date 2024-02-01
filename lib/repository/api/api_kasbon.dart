import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiKasbon {

  static Future<List<KasbonData>> getKasbons(int? idProyek) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/get_kasbons?id_proyek=$idProyek'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> kasbonsData = jsonData['data'];
      return kasbonsData.map((data) => KasbonData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class KasbonData {
  final int idKasbon;
  final int idPekerja;
  final String jumlahKasbon;
  final int idProyek;
  final String namaPekerja;

  KasbonData({
    required this.idKasbon,
    required this.idPekerja,
    required this.jumlahKasbon,
    required this.idProyek,
    required this.namaPekerja,
  });

  factory KasbonData.fromJson(Map<String, dynamic> json) {
    return KasbonData(
      idKasbon: json['id_kasbon'],
      idPekerja: json['id_pekerja'],
      jumlahKasbon: json['jumlah_kasbon'],
      idProyek: json['id_proyek'],
      namaPekerja: json['pekerja']['nama_pekerja'],
    );
  }
}
