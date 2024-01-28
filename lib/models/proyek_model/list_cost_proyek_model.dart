class ListCostProyek {
  String? idProyek;
  String? lokasiProyek;
  String? keterangan;
  String? namaPemilik;
  String? totalPengeluaran;

  ListCostProyek(
      {this.idProyek,
      this.keterangan,
      this.lokasiProyek,
      this.namaPemilik,
      this.totalPengeluaran});

  ListCostProyek.fromJson(Map<String, dynamic> json) {
    idProyek = json['id_proyek'].toString();
    lokasiProyek = json['lokasi_proyek'];
    keterangan = json['keterangan'];
    namaPemilik = json['nama_pemilik'];
    totalPengeluaran = json['total_pengeluaran'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id_proyek": idProyek,
      "lokasi_proyek": lokasiProyek,
      "keterangan": keterangan,
      "nama_pemilik": namaPemilik,
      "total_pengeluaran": totalPengeluaran
    };
  }
}
