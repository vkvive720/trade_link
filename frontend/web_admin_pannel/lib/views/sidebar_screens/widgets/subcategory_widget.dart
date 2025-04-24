import 'package:flutter/material.dart';
import 'package:web_admin_pannel/controller/category_controller.dart';
import 'package:web_admin_pannel/controller/subCategory_controller.dart';
import 'package:web_admin_pannel/models/subCategoru_models.dart';
import '../../../models/category_screen.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = SubCategoryController().loadSubcategories()  ;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subcategory>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Subategories"));
        } else {
          final categories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true, // Takes only the space it needs.
            physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling.
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 16 / 9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Expanded widget allows the image to fill available space
                    Expanded(
                      child: Image.network(
                        category.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.error));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        category.categoryName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
