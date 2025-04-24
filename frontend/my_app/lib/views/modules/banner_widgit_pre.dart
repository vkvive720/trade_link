import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 150, // Adjust banner height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          // Make sure 'searchBanner.jpeg' exists in assets
          image: AssetImage('assets/icons/searchBanner.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
