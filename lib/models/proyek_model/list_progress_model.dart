class ListProgress {
  int? id;
  String? name;
  String? detailLokasi;
  String? progress;
  String? tanggal;
  String? keteranganProgress;
  String? picUrl;
  int? idProyek;

  ListProgress(
      {this.id,
      this.name,
      this.detailLokasi,
      this.progress,
      this.tanggal,
      this.keteranganProgress,
      this.picUrl,
      this.idProyek});

  ListProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detailLokasi = json['detail_lokasi'];
    progress = json['progress'];
    tanggal = json['tanggal'];
    keteranganProgress = json['keterangan_progress'];
    picUrl = json['picUrl'];
    idProyek = json['id_proyek'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail_lokasi': detailLokasi,
      'progress': progress,
      'tanggal': tanggal,
      'keterangan_progress': keteranganProgress,
      'picUrl': picUrl,
      'id_proyek': idProyek
    };
  }
}
