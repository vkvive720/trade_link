import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Top bar background color
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search anything',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  prefixIcon: Image.asset(
                    'assets/icons/search.png', // Make sure this exists
                    color: Colors.white,        // Optional tint
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),

          // Camera Icon
          IconButton(
            icon: Image.asset(
              'assets/icons/camera.png',
              width: 24,
              color: Colors.white, // Optional tint
            ),
            onPressed: () {
              // Handle camera icon tap
            },
          ),

          // Cart Icon with a badge
          Stack(
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/icons/cart.png',
                  width: 24,
                  color: Colors.white, // Optional tint
                ),
                onPressed: () {
                  // Handle cart tap
                },
              ),
              // Badge (e.g., "20" items)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: const Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
