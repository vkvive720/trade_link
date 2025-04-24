import 'package:flutter/material.dart';
import 'package:my_app/views/screens/nav_screens/widgets/product_card.dart';
import '../../../../controllers/procuct controller.dart';
import '../../../../models/product_model.dart';
import '../../../../models/category_model.dart'; // Ensure Category is imported

class PopularProductsWidget extends StatefulWidget {
  final Category category;

  const PopularProductsWidget({ required this.category});

  @override
  State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends State<PopularProductsWidget> {
  late Future<List<Product>> futurePopularProducts;

  @override
  void initState() {
    super.initState();
    futurePopularProducts = ProductController().loadProductByCategory(
     widget.category.name,
    );
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
              crossAxisCount: 2,         // Two items per row
              crossAxisSpacing: 8,       // Horizontal spacing
              mainAxisSpacing: 8,        // Vertical spacing
              childAspectRatio: 0.75,    // Controls the height/width ratio of each cell
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
