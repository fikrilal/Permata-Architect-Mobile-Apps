class TotalBiayaProyek {
  String? totalPemasukan;
  String? totalPengeluaran;
  String? totalKasbons;

  TotalBiayaProyek.fromJson(Map<String, dynamic> json) {
    totalPemasukan = json['total_pemasukan'].toString();
    totalPengeluaran = json['total_pengeluaran'].toString();
    totalKasbons = json['total_kasbon'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'total_pemasukan': totalPemasukan,
      'total_pengeluaran': totalPengeluaran,
      'total_kasbon': totalKasbons
    };
  }
}
