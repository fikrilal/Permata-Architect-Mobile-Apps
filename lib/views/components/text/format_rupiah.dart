import 'package:intl/intl.dart';

String formatRupiah(int nominal) {
  final NumberFormat formatRupiah = NumberFormat.currency(
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  return formatRupiah.format(nominal);
}

String formatNominal(String nominal) {
  // Hapus karakter non-digit dari nominal
  String cleanedNominal = nominal.replaceAll(RegExp(r'[^0-9]'), '');

  // Parse nominal sebagai integer
  int nominalValue = int.tryParse(cleanedNominal) ?? 0;

  // Cek jika nominal di atas nol
  if (nominalValue > 0) {
    // Cek jika nominal di atas satu juta
    if (nominalValue >= 1000000) {
      // Ubah nominal menjadi format Juta
      double nominalInMillion = nominalValue / 1000000;

      // Format nominal dengan dua angka desimal
      String formattedNominal = nominalInMillion.toStringAsFixed(2);

      // Tambahkan " Jt" di belakang nominal
      return 'Rp. $formattedNominal Jt';
    } else {
      // Jika di bawah satu juta, kembalikan "Rp." dan nominal asli
      return ' $nominal';
    }
  } else {
    // Jika nominal nol, kembalikan "Rp. 0"
    return 'Rp. 0';
  }
}
