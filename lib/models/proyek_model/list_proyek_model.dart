class ListProyek {
  int? idProyek;
  String? lokasiProyek;
  String? keterangan;
  String? namaPemilik;
  String? status;
  String? nilaiProyek;

  ListProyek(
      {this.idProyek,
      this.lokasiProyek,
      this.namaPemilik,
      this.nilaiProyek,
      this.keterangan,
      this.status});

  ListProyek.fromJson(Map<String, dynamic> json) {
    idProyek = json['id_proyek'];
    lokasiProyek = json['lokasi_proyek'];
    keterangan = json['keterangan'];
    namaPemilik = json['nama_pemilik'];
    status = json['status'];
    nilaiProyek = json['nilai_proyek'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id_proyek": idProyek,
      "lokasi_proyek": lokasiProyek,
      "keterangan": keterangan,
      "nama_pemilik": namaPemilik,
      "status": status,
      "nilai_proyek": nilaiProyek
    };
  }
}
