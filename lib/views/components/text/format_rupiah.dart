import 'package:intl/intl.dart';

String formatRupiah(int nominal) {
  final NumberFormat formatRupiah = NumberFormat.currency(
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  return formatRupiah.format(nominal);
}
