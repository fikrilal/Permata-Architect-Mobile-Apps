class AbsensiModel {
  int? idPekerja;
  String? namaPekerja;
  String? role;
  int? idProyek;
  List<Absensis>? absensis;

  AbsensiModel(
      {this.idPekerja,
      this.namaPekerja,
      this.role,
      this.idProyek,
      this.absensis});

  AbsensiModel.fromJson(Map<String, dynamic> json) {
    idPekerja = json['id_pekerja'];
    namaPekerja = json['nama_pekerja'];
    role = json['role'];
    idProyek = json['id_proyek'];
    absensis =
        List<Absensis>.from(json['absensis'].map((x) => Absensis.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pekerja': idPekerja,
      'nama_pekerja': namaPekerja,
      'role': role,
      'id_proyek': idProyek,
      'absensis': absensis
    };
  }
}

class Absensis {
  String? statusAbsensi;
  String? tanggal;

  Absensis({this.statusAbsensi, this.tanggal});

  Absensis.fromJson(Map<String, dynamic> json) {
    statusAbsensi = json['status_absensi'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    return {'status_absensi': statusAbsensi, 'tanggal': tanggal};
  }
}
