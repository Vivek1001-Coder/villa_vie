import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  static const String baseUrl = "assets/event_pictures/";
  List<Map<String, String>> originalCategories = [
    {"text": "Dinning", "imageUrl": "${baseUrl}c1.jpg"},
    {"text": "Business Center", "imageUrl": "${baseUrl}business.jpg"},
    {"text": "Library", "imageUrl": "${baseUrl}library.jpg"},
    {"text": "Common Areas", "imageUrl": "${baseUrl}common.jpg"},
    {"text": "Fitness Center", "imageUrl": "${baseUrl}fitness.jpg"},
    {"text": "Hospital", "imageUrl": "${baseUrl}c1.jpg"},
    {"text": "Spa", "imageUrl": "${baseUrl}spa.jpg"},
    {"text": "Golf Simulator", "imageUrl": "${baseUrl}golf.jpg"},
    {"text": "Pool", "imageUrl": "${baseUrl}pool.jpg"},
    {"text": "Bars & Cafes", "imageUrl": "${baseUrl}bars.jpg"},
    {"text": "Observation Deck", "imageUrl": "${baseUrl}observation.jpg"},
    {"text": "Laundry", "imageUrl": "${baseUrl}laundry.jpg"},
    {"text": "Storage", "imageUrl": "${baseUrl}storage.jpg"},
    {"text": "Pickle Ball Court", "imageUrl": "${baseUrl}pickle ball.jpg"},
  ];
  late List<Map<String, String>> categories;

  @override
  void initState() {
    super.initState();
    categories = List<Map<String, String>>.from(originalCategories);
  }

  void sortCategoriesAZ() {
    setState(() {
      categories.sort((a, b) => a['text']!.compareTo(b['text']!));
    });
  }

  void resetToOriginalOrder() {
    setState(() {
      categories = List<Map<String, String>>.from(originalCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 4.0, color: Colors.black),
            ),
            tabs: [
              Tab(
                child: Text(
                  "Categories",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ),
              ),
              Tab(
                child: Text(
                    "Bookings",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    )
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            categoriesTab(),
            Scaffold()
          ],
        ),
      ),
    );
  }

  Widget categoriesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.04,
          vertical: MediaQuery.sizeOf(context).width * 0.03,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
            sortingLine(resetToOriginalOrder, sortCategoriesAZ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            generateCategories(categories),
          ],
        ),
      ),
    );
  }

  Widget generateCategories(List<Map<String, dynamic>> categories) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      itemCount: categories.length,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.04,
      mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.01,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> categoryItem = categories[index];
        return category(
          text: categoryItem["text"],
          imageUrl: categoryItem["imageUrl"],
        );
      },
    );
  }

  Widget category({required String text, required String imageUrl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.figtree(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget clickableText(void Function() function) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          Icon(Icons.read_more, color: Colors.teal),
          Text("Reorder", style: TextStyle(color: Colors.teal)),
        ],
      ),
    );
  }

  Widget sortingLine(void Function() function1, void Function() function2) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [clickableText(function1), clickableText1(function2)],
      ),
    );
  }

  Widget clickableText1(void Function() function) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          Icon(Icons.sort, color: Colors.teal),
          Text("Sort by:", style: TextStyle(color: Colors.teal)),
          Text("A to Z"),
        ],
      ),
    );
  }
}

class Category
{
  String? imageUrl;
  String? title;

  Category(this.imageUrl,this.title);

  Category.fromJson(Map<String,dynamic> json)
  {
    imageUrl = json["imageUrl"];
    title = json["title"];
  }

  static Map<String,dynamic> toJson(Category value)
  {
    return {
      "imageUrl" : value.imageUrl,
      "title" : value.title
    };
  }
}