import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryListingScreen extends StatefulWidget
{
  const CategoryListingScreen({super.key});

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Golf Simulator", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color.fromRGBO(6, 40, 70, 0.85),
        shadowColor: Colors.white,
      ),

      backgroundColor: Color.fromRGBO(6, 40, 70, 0.85),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Perfect your swing or enjoy a round of virtual golf.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                golfBox(
                  imageUrl: "assets/event_pictures/p7.jpg",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
                golfBox(
                  imageUrl: "assets/event_pictures/p10.jpg",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
                golfBox(
                  imageUrl: "assets/event_pictures/p8.png",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
                golfBox(
                  imageUrl: "assets/event_pictures/p9.jpg",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
                golfBox(
                  imageUrl: "assets/event_pictures/p12.jpg",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
                golfBox(
                  imageUrl: "assets/event_pictures/p11.jpg",
                  mainText: "Stroke Play",
                  subText: "Emotional Intelligence 4.0 will teach how to harness the power of your ...",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),

    );
  }


  Widget golfBox({required String imageUrl, String? mainText, String? subText})
  {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(72, 77, 117, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(8),
      height: 100,
      child: Row(
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subText ?? "",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

}
