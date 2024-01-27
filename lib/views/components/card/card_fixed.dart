import 'package:flutter/material.dart';

import '../text/description.dart';
import '../text/header.dart';

class FixedCard extends StatelessWidget {
  final String description;
  final String amount;

  FixedCard({required this.description, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextDescriptionSmall("Total Pemasukan"),
          SizedBox(height: 16),
          TextPoint("Rp 15.000.000"),
        ],
      ),
    );
  }
}
