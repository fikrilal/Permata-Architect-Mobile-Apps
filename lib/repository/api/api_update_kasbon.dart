import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiUpdateKasbon {
  static Future<Map<String, dynamic>> updateKasbons({
    required String idPekerja,
    required String idProyek,
    required String jumlahKasbon,
  }) async {

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/update_kasbons'),
        body: {
          'id_pekerja': idPekerja,
          'id_proyek': idProyek,
          'jumlah_kasbon': jumlahKasbon,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return {'success': true, 'data': data['data'], 'message': data['message']};
      } else {
        return {'success': false, 'message': 'Failed to update Kasbon'};
      }
    } catch (error) {
      return {'success': false, 'message': 'Error: $error'};
    }
  }
}
