import 'package:flutter/material.dart';
import 'package:my_app/views/details/views/inner_category_screen.dart';
import 'package:my_app/views/screens/nav_screens/widgets/reusable_text_widet.dart';

import '../../../../controllers/category_controler.dart';
import '../../../../models/category_model.dart';


class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryItemWidget> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableTextWidet(title: "Categories", subtitle: "View all"),

        FutureBuilder<List<Category>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No Categories"));
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true, // Takes only the space it needs.
                physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling.
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 9 / 11,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerCategoryScreen(category:category)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
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
                              category.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
