import 'package:flutter/material.dart';

import '../../../../controllers/banner_controller.dart';
import '../../../modules/banner_model.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7f7),
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(4)
      ),
      child:  FutureBuilder<List<BannerModel>>(
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
            return PageView.builder(
              // shrinkWrap: true, // Tells GridView to take only the space it needs
              // physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
              // padding: const EdgeInsets.all(8),

              itemCount: banners.length,
              itemBuilder: (context, index) {
                final banner = banners[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12
                      ),
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
