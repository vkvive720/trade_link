import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextWidet extends StatelessWidget {
  final String title;
  final String subtitle;

  const ReusableTextWidet({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: GoogleFonts.quicksand(
            fontSize: 18,fontWeight: FontWeight.bold,
          ),),
          Text(subtitle,style: GoogleFonts.quicksand(
            fontSize: 16,fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),)
        ],
      ),
    );
  }
}
