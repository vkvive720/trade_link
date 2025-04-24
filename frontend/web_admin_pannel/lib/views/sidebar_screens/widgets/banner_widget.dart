import 'package:flutter/material.dart';
import 'package:web_admin_pannel/controller/banner_controller.dart';
import '../../../models/bannel.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Banners"));
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true, // Tells GridView to take only the space it needs
            physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // Adjust the number of columns as needed
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 16 / 9, // Adjust aspect ratio to suit your images
            ),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  banner.image,
                  fit: BoxFit.cover, // Makes sure the image fills the container
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
