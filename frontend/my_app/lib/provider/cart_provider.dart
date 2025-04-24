import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_model.dart';

// Define a StateNotifierProvider to expose an instance of CartNotifier.
// Notice we now use Map<String, Cart> since productID is a string.
final cartProvider =
StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> images,
    required String vendorID,
    required int productQuantity,
    required int quantity,
    required String productID, // Now a string.
    required String description,
    required String fullName,
  }) {
    if (state.containsKey(productID)) {
      // If the product is already in the cart, update its quantity.
      final existingCart = state[productID]!;
      state = {
        ...state,
        productID: Cart(
          productName: existingCart.productName,
          productPrice: existingCart.productPrice,
          category: existingCart.category,
          images: existingCart.images,
          vendorID: existingCart.vendorID,
          productQuantity: existingCart.productQuantity,
          quantity: existingCart.quantity + quantity,
          productID: existingCart.productID,
          description: existingCart.description,
          fullName: existingCart.fullName,
        )
      };
    } else {
      // If the product is not in the cart, add it as a new entry.
      state = {
        ...state,
        productID: Cart(
          productName: productName,
          productPrice: productPrice,
          category: category,
          images: images,
          vendorID: vendorID,
          productQuantity: productQuantity,
          quantity: quantity,
          productID: productID,
          description: description,
          fullName: fullName,
        )
      };
    }
  }

  // Increment the quantity of a product in the cart.
  void incrementCartItem(String productID) {
    if (state.containsKey(productID)) {
      final currentCart = state[productID]!;
      state = {
        ...state,
        productID: Cart(
          productName: currentCart.productName,
          productPrice: currentCart.productPrice,
          category: currentCart.category,
          images: currentCart.images,
          vendorID: currentCart.vendorID,
          productQuantity: currentCart.productQuantity,
          quantity: currentCart.quantity + 1,
          productID: currentCart.productID,
          description: currentCart.description,
          fullName: currentCart.fullName,
        )
      };
    }
  }

  // Decrement the quantity of a product in the cart.
  void decrementCartItem(String productID) {
    if (state.containsKey(productID)) {
      final currentCart = state[productID]!;
      int updatedQuantity =
      currentCart.quantity > 0 ? currentCart.quantity - 1 : 0;
      state = {
        ...state,
        productID: Cart(
          productName: currentCart.productName,
          productPrice: currentCart.productPrice,
          category: currentCart.category,
          images: currentCart.images,
          vendorID: currentCart.vendorID,
          productQuantity: currentCart.productQuantity,
          quantity: updatedQuantity,
          productID: currentCart.productID,
          description: currentCart.description,
          fullName: currentCart.fullName,
        )
      };
    }
  }

  // Remove an item from the cart.
  void removeCartItem(String productID) {
    final newState = Map<String, Cart>.from(state);
    newState.remove(productID);
    state = newState;
  }

  // Calculate the total amount of items in the cart.
  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((_, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}
