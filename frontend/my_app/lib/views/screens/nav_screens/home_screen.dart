import 'package:flutter/material.dart';
import 'package:my_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:my_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:my_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:my_app/views/screens/nav_screens/widgets/popular_projects.dart';
import 'package:my_app/views/screens/nav_screens/widgets/reusable_text_widet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column takes only needed space
          children: const [
            HeaderWidget(),
            // Remove any extra spacing widget between header and banner if present.
            BannerWidget(),
            CategoryItemWidget(),
            ReusableTextWidet(title: "Populat Products", subtitle: "view all"),
            PopularProductsWidget(),
          ],
        ),
      ),
    );
  }
}
