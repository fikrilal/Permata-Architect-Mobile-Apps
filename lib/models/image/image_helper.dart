import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageHelper {
  Future<File?> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan saat memilih gambar: $e");
      return null;
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      var uri = Uri.parse('https://api.imgbb.com/1/upload');
      var request = http.MultipartRequest('POST', uri)
        ..fields['key'] = '134113064fd64005338a64d3d654c6f9'
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Upload berhasil: $responseString');
      } else {
        print('Upload gagal');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengunggah gambar: $e');
    }
  }
}
