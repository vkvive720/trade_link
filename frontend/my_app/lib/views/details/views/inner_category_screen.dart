import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controllers/subcategory_controller.dart';
import 'package:my_app/views/details/views/widgets/inner_banner_widget.dart';
import 'package:my_app/views/details/views/widgets/inner_header_widget.dart';

import '../../../models/category_model.dart';
import '../../../models/subcategories_model.dart';
import '../../screens/nav_screens/widgets/popular_category_by_category_name.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    _subCategories =
        _subcategoryController.getSubcategoryByName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
          child: InnerHeaderWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (){},
                child: InnerBannerWidget(banner: widget.category.banner)),
            Text("Shop By Sub Categories",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 16)),

            FutureBuilder<List<Subcategory>>(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No Subcategories"));
                } else {
                  final subcategories = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 9 / 11,
                    ),
                    itemCount: subcategories.length,
                    itemBuilder: (context, index) {
                      final subcategory = subcategories[index];
                      return InkWell(
                        onTap: () {
                          // Update this navigation if you want to navigate to a subcategory details screen.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InnerCategoryScreen(
                                      category: widget.category)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  subcategory.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(child: Icon(Icons.error));
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                child: Text(
                                  subcategory.subcategoryName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
            PopularProductsWidget(category: widget.category)
          ],
        ),
      ),
    );
  }
}
