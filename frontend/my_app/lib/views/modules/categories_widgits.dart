import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace these with your actual category data
    final categories = [
      {'icon': 'assets/icons/love.png', 'label': 'Fashion'},
      {'icon': 'assets/icons/mart.png', 'label': 'Electronics'},
      {'icon': 'assets/icons/home.png', 'label': 'Furniture'},
      {'icon': 'assets/icons/user.png', 'label': 'Food'},
      {'icon': 'assets/icons/cart.png', 'label': 'Sports'},
      // etc.
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          // "Categories" title + "View all" link
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Handle "View All"
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Horizontal list of categories
          SizedBox(
            height: 80, // Adjust category row height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Circular container with icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          categories[index]['icon']!,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Category label
                    Text(
                      categories[index]['label']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
