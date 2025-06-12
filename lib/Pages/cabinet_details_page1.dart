import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'cabinet_details_page.dart';
import 'image_slider_dialog.dart';

class CabinetDetailsPage1 extends StatefulWidget
{
  const CabinetDetailsPage1({super.key});

  @override
  State<CabinetDetailsPage1> createState() => _CabinetDetailsPage1State();
}

class _CabinetDetailsPage1State extends State<CabinetDetailsPage1>
{
  List<String> images = [
    "p15.jpg",
    "p16.jpg",
    "p15.jpg",
    "p16.jpg",
    "p15.jpg",
    "p16.jpg",
    "p15.jpg",
    "p16.jpg",
    "p15.jpg",
    "p16.jpg",
    "p15.jpg",
    "p16.jpg",
  ];
  String baseUrl = "assets/event_pictures/";
  int currentIndex = 0;
  List<String> gridImages = ["p18.jpg", "p17.jpg", "p18.jpg"];
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> dateBoxes = [
    {
      "date": DateTime.now(),
      "startingTime": TimeOfDay(hour: 10, minute: 0),
      "endingTime": TimeOfDay(hour: 12, minute: 30),
      "noOfPeople": 90,
      "price": 91.0,
    },
    {
      "date": DateTime.now(),
      "startingTime": TimeOfDay(hour: 10, minute: 0),
      "endingTime": TimeOfDay(hour: 12, minute: 30),
      "noOfPeople": 90,
      "price": 91.0,
    },
    {
      "date": DateTime.now(),
      "startingTime": TimeOfDay(hour: 10, minute: 0),
      "endingTime": TimeOfDay(hour: 12, minute: 30),
      "noOfPeople": 90,
      "price": 91.0,
    },
  ];
  Map<String, IconData> stringToIcon = {
    "Wifi": CupertinoIcons.wifi,
    "Changing Room": Icons.meeting_room_rounded,
    "Children Play Area": Icons.child_friendly,
    "Large LED": CupertinoIcons.tv_fill,
  };
  List<String> amenities = [
    "Wifi",
    "Changing Room",
    "Children Play Area",
    "Large LED",
  ];

  String actualTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'pm' : 'am';
    final formattedHour =
        hour == 0
            ? 12
            : hour > 12
            ? hour - 12
            : hour;

    return "$formattedHour:$minute$period";
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double width = MediaQuery.of(context).size.width;
      double page = _scrollController.offset / width;

      int calculatedIndex = page.round();
      if (calculatedIndex != currentIndex) {
        setState(() {
          currentIndex = calculatedIndex;
        });
      }
    });
  }

  Color rgba(int r, int g, int b, double o) => Color.fromRGBO(r, g, b, o);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            imageWithDotIndicator(images),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            mainScreen(),
          ],
        ),
      ),
    );
  }

  Widget mainScreen()
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          textBox(
            "Stargaze",
            "Emotional Intelligence 4.0 will teach you how to harness the power of your brain, reprogram it, and start thinking creatively, analytically, positively, or critically, among other things.",
            TimeOfDay(hour: 9, minute: 0),
            TimeOfDay(hour: 23, minute: 0),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Divider(),
          textBox1(
            "What you will do",
            "Emotional Intelligence 4.0 will teach you how to harness the power of your brain, reprogram it, and start thinking creatively, analytically, positively, or critically, among other things.",
          ),
          displayImagesGrid(context,gridImages),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          textButton("Show all photos", Colors.white, Colors.black),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          headerText("Seating  and Amenities."),
          displayAmenities(amenities),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          titleBox("Choose from available dates"),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          generateAvailableDateBoxes(dateBoxes),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Divider(),
          listTileTextBox(
            "Cancellation Policy",
            "Emotional Intelligence 4.0 will teach you how to harness the power of your brain, reprogram",
          ),
          listTileTextBox(
            "Request Requirements",
            "Emotional Intelligence 4.0 will teach you how to harness the power of your brain, reprogram",
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          headerText("Where is the location?"),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          locationDisplay("3rd floor near front deck opposite the stairs."),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          textButton("Proceed Booking", Colors.black, Colors.white),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }

  Widget locationDisplay(String location)
  {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              location,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 30),
          Image.asset("assets/event_pictures/ship.png"),
        ],
      ),
    );
  }

  Widget listTileTextBox(String title, String subtitle)
  {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: rgba(51, 51, 51, 1)),
      ),
      trailing: Icon(CupertinoIcons.arrow_right),
    );
  }

  Widget displayAmenities(List<String> amenities)
  {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            amenities[index],
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            stringToIcon[amenities[index]],
            color: Colors.teal,
            size: 26,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox();
      },
      itemCount: amenities.length,
    );
  }

  Widget titleBox(String mainTitle)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mainTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              enableDrag: true,
              builder: (BuildContext context) {
                return bottomSheet();
              },
            );
          },
          child: Text(
            "See All",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet()
  {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ///Top tab-bar
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.145,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CupertinoIcons.xmark),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Select Dates",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.sizeOf(context).height * 0.025,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    capsuleTextBox("Dates"),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                    capsuleTextBox("1 Guest"),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                    capsuleTextBox("Private Group"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),

          ///Listing data
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Expanded(child: generateBottomSheetAvailableDateBox(dateBoxes)
            ),
          )
        ],
      ),
    );
  }

  Widget generateBottomSheetAvailableDateBox(List<Map<String, dynamic>> bottomSheetAvailableDateBoxes,)
  {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> item = bottomSheetAvailableDateBoxes[index];
        return bottomSheetAvailableDateBox(
          item["date"],
          item["startingTime"],
          item["endingTime"],
          item["noOfPeople"],
          item["price"],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: MediaQuery.sizeOf(context).height * 0.02);
      },
      itemCount: bottomSheetAvailableDateBoxes.length,
    );
  }

  Widget bottomSheetAvailableDateBox(DateTime date, TimeOfDay startingTime, TimeOfDay endingTime, int noOfPeople, double price,)
  {
    return Column(
      children: [
        headerText(date.toString().substring(0, 10)),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.28,
          width: MediaQuery.sizeOf(context).width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.03,
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Text(
                "${actualTime(startingTime).substring(0, 5)}-${actualTime(endingTime).substring(0, 5)}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Text(
                "For $noOfPeople people",
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).height * 0.02,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              headerText("From $price/Group"),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              textButton("Choose", Colors.black, Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  Widget capsuleTextBox(String content)
  {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.05,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.01,
        horizontal: MediaQuery.sizeOf(context).height * 0.025,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(
          MediaQuery.sizeOf(context).height * 0.1,
        ),
      ),
      child: Text(content, style: TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget generateAvailableDateBoxes(List<Map<String, dynamic>> availableDateBoxes,)
  {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.32,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> availableDateBoxItem = availableDateBoxes[index];
          return availableDateBox(
            availableDateBoxItem["date"],
            availableDateBoxItem["startingTime"],
            availableDateBoxItem["endingTime"],
            availableDateBoxItem["noOfPeople"],
            availableDateBoxItem["price"],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10);
        },
        itemCount: availableDateBoxes.length,
      ),
    );
  }

  Widget availableDateBox(DateTime date, TimeOfDay startingTime, TimeOfDay endingTime, int noOfPeople, double price,)
  {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.32,
      width: MediaQuery.sizeOf(context).width * 0.6,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(date.toString().substring(0, 10)),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          Text(
            "${actualTime(startingTime).substring(0, 5)}-${actualTime(endingTime).substring(0, 5)}",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          Text(
            "For $noOfPeople people",
            style: TextStyle(
              fontSize: MediaQuery.sizeOf(context).height * 0.02,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          headerText("From $price/Group"),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          textButton("Choose", Colors.black, Colors.white),
        ],
      ),
    );
  }

  Widget textButton(String buttonLabel, Color backgroundColor, Color textColor,)
  {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CabinetDetailsPage();
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.07,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
          color: backgroundColor,
        ),
        child: Text(
          buttonLabel,
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).height * 0.021,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget headerText(String text)
  {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height * 0.025,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget displayImagesGrid(BuildContext context, List<String> gridImages)
  {
    int len = gridImages.length;
    double mediaHeight = MediaQuery.of(context).size.height;

    if (len == 0) {
      return Container(
        height: mediaHeight * 0.35,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          "No photos yet!",
          style: TextStyle(
              fontSize: mediaHeight * 0.03, fontWeight: FontWeight.bold),
        ),
      );
    }

    BorderRadius adjustBorder(int index) {
      if (len == 1)
      {
        return BorderRadius.zero;
      }
      else if (len % 2 == 1)
      {
        if (index == 0)
        {
          return BorderRadius.only(bottomLeft: Radius.circular(12));
        }
        else if (index == len - 1)
        {
          return BorderRadius.only(bottomRight: Radius.circular(12));
        }
      }
      if (len == 2)
      {
        if (index == 0)
        {
          return BorderRadius.only(bottomLeft: Radius.circular(12));
        }
        else if (index == 1)
        {
          return BorderRadius.only(bottomRight: Radius.circular(12));
        }
      }
      else if (index == (len / 2))
      {
        return BorderRadius.only(bottomLeft: Radius.circular(12));
      }
      else if (index == len - 1)
      {
        return BorderRadius.only(bottomRight: Radius.circular(12));
      }
      return BorderRadius.zero;
    }

    return SizedBox(
      height: mediaHeight * 0.30,
      child: MasonryGridView.count(
        crossAxisCount: len == 2 ? 2 : (len / 2).ceil(),
        mainAxisSpacing: mediaHeight * 0.02,
        padding: EdgeInsets.zero,
        crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.05,
        itemCount: gridImages.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  backgroundColor: Colors.black12,
                  insetPadding: EdgeInsets.zero,
                  child: ImageSliderDialog(
                    imagePaths: gridImages,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: index == 0
                  ? len % 2 == 0
                  ? (mediaHeight * 0.3) / 2.15
                  : mediaHeight * 0.3
                  : (mediaHeight * 0.3) / 2.15,
              child: ClipRRect(
                borderRadius: adjustBorder(index),
                child: Image.asset(
                  "assets/event_pictures/${gridImages[index]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget generateImages(List<String> images)
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.separated(
        physics: PageScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return image(images[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox();
        },
        itemCount: images.length,
      ),
    );
  }

  Widget imageWithDotIndicator(List<String> images)
  {
    return Stack(
      children: [generateImages(images), dotIndicator(images.length)],
    );
  }

  Widget dotIndicator(int noOfImages)
  {
    return Align(
      heightFactor: MediaQuery.of(context).size.height * 0.055,
      alignment: Alignment.bottomCenter,
      child: DotsIndicator(
        dotsCount: noOfImages,
        position: currentIndex,
        decorator: const DotsDecorator(
          color: Colors.white,
          size: Size(6.0, 6.0),
          activeSize: Size(6.0, 6.0),
          spacing: EdgeInsets.only(left: 2),
          activeColor: Color.fromRGBO(0, 188, 166, 1),
        ),
      ),
    );
  }

  Widget image(String imageUrl)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: Image.asset("$baseUrl$imageUrl", fit: BoxFit.cover),
      ),
    );
  }

  Widget textBox1(String? mainText, String? subText)
  {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            subText ?? "",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget textBox(String? mainText, String? subText, TimeOfDay startingTime, TimeOfDay endingTime,)
  {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 5),
          Text(
            subText ?? "",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          // SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Best Timing for viewing:" ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "poppins",
                  fontSize: 15,
                ),
              ),
              Text(
                "${actualTime(startingTime)}-${actualTime(endingTime)}" ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "poppins",
                  color: rgba(0, 145, 128, 1),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}