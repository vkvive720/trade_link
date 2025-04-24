import 'package:flutter/material.dart';

class InnerBannerWidget extends StatefulWidget {
  final String banner;


  const InnerBannerWidget({super.key, required this.banner});

  @override
  State<InnerBannerWidget> createState() => _InnerBannerWidgetState();
}

class _InnerBannerWidgetState extends State<InnerBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Add padding around the banner
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Add border radius
        child: Image.network(
          widget.banner,
          width: MediaQuery.of(context).size.width,
          height: 170,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
