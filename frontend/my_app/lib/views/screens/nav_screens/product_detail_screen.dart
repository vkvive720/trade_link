import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/provider/cart_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Read the cart provider's notifier.
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Product Image --
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.product.images.isNotEmpty
                    ? widget.product.images.first
                    : '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50);
                },
              ),
            ),
            const SizedBox(height: 16),
            // -- Product Name --
            Text(
              widget.product.productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // -- Product Price --
            Text(
              '₹${widget.product.productPrice}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // -- Full Description --
            Text(
              widget.product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // Additional product details can be added here.
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Convert the product id to String.
                  cartNotifier.addProductToCart(
                    productName: widget.product.productName,
                    productPrice: widget.product.productPrice,
                    category: widget.product.category,
                    images: widget.product.images,
                    vendorID: widget.product.vendorId,
                    productQuantity: widget.product.quantity,
                    quantity: 1,
                    productID: widget.product.id.toString(), // Convert id to String
                    description: widget.product.description,
                    fullName: widget.product.fullName,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to Cart')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cartNotifier.addProductToCart(
                    productName: widget.product.productName,
                    productPrice: widget.product.productPrice,
                    category: widget.product.category,
                    images: widget.product.images,
                    vendorID: widget.product.vendorId,
                    productQuantity: widget.product.quantity,
                    quantity: 1,
                    productID: widget.product.id.toString(), // Convert id to String
                    description: widget.product.description,
                    fullName: widget.product.fullName,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to Checkout')),
                  );
                  // TODO: Navigate to the checkout screen.
                },
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
