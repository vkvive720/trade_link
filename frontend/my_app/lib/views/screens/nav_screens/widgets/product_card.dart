import 'package:flutter/material.dart';
import 'package:my_app/models/product_model.dart';
import '../product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail screen on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0), // Reduced margin
        decoration: BoxDecoration(
          color: const Color(0xFFFAF5F8), // Soft pink background
          borderRadius: BorderRadius.circular(12), // Slightly smaller radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // -- Single Image Display --
            AspectRatio(
              aspectRatio: 1, // Square image
              child: Image.network(
                product.images.isNotEmpty ? product.images.first : '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 40);
                },
              ),
            ),
            const SizedBox(height: 4),
            // -- Product Name --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 14, // Smaller font size
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            // -- Price & Discount Row --
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '2,999', // Hardcoded old price
                  style: const TextStyle(
                    fontSize: 12, // Reduced font size
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '₹${product.productPrice}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '73% off', // Hardcoded discount label
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
