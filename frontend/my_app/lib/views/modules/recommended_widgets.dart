import 'package:flutter/material.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace these paths with your actual recommended items/images
    final recommended = [
      'assets/icons/illustration.png',
      'assets/images/banner3.jpg',
      // Add more if needed
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // "Recommended for you" title
          Row(
            children: const [
              Text(
                'Recommended for you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
          const SizedBox(height: 8),

          // Horizontal list of recommended items
          SizedBox(
            height: 100, // Adjust item height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommended.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    recommended[index],
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
