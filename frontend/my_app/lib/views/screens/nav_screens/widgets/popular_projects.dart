import 'package:flutter/material.dart';
import 'package:my_app/views/screens/nav_screens/widgets/product_card.dart';
import '../../../../controllers/procuct controller.dart'; // Check spelling/filename
import '../../../../models/product_model.dart';

class PopularProductsWidget extends StatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends State<PopularProductsWidget> {
  late Future<List<Product>> futurePopularProducts;

  @override
  void initState() {
    super.initState();
    futurePopularProducts = ProductController().loadPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futurePopularProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No popular products found."));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,         // Number of items in each row
              crossAxisSpacing: 8,       // Horizontal spacing between grid cells
              mainAxisSpacing: 8,        // Vertical spacing between grid cells
              childAspectRatio: 0.75,    // Adjust to control card height/width ratio
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        }
      },
    );
  }
}
