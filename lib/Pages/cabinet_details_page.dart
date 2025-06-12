import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:villa_vie/Utils/Config.dart';
import 'package:villa_vie/Pages/image_slider_dialog.dart';

class CabinetDetailsPage extends StatefulWidget
{
  const CabinetDetailsPage({super.key});
  @override
  State<StatefulWidget> createState()
  {
    return CabinetDetailsPageBody();
  }
}

class CabinetDetailsPageBody extends State<CabinetDetailsPage> {
  List<String> eventPictures = [];
  bool imageLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async
  {
    final response = await http.get(Uri.parse("$baseUrl/getImages"));

    if(response.statusCode == 200)
    {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        imageLoaded = true;
        eventPictures = List<String>.from(data);
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Pictures",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
      ),

      body: imageLoaded ? body() : loading(),
    );
  }

  Widget loading()
  {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.green,

      ),
    );
  }

  Widget body()
  {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.separated(
            itemBuilder: (BuildContext context,int index)
            {
              return GestureDetector(
                onTap:(){
                  showDialog(
                      context: context,
                      builder: (_)=> Dialog(
                          backgroundColor: Colors.black,
                          insetPadding: EdgeInsets.zero,
                          child: ImageSliderDialog(imagePaths: eventPictures, initialIndex: index)
                      )
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/event_pictures/${eventPictures[index]}",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context,int index)
            {
              return SizedBox(height: 10,);
            },
            itemCount: eventPictures.length
        ),
      ),
    );
  }
}