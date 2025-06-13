import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:villa_vie/Pages/cabinet_details_page.dart';
import 'package:villa_vie/Auth/sign_up_page.dart';
import 'package:villa_vie/SharedPreference/pref_helper.dart';
import 'package:villa_vie/Pages/slot_page.dart';

import 'Profile.dart';
import 'cabinet_details_page1.dart';
import 'categories_page.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  HomePageBody createState() => HomePageBody();
}

class HomePageBody extends State<HomePage> {
  int currentIndex = 0;
  List<Map<String, dynamic>> list = [
    {
      "eventTitle": "Workout",
      "startingTime": TimeOfDay.now(),
      "endingTime": TimeOfDay.now(),
      "organizerName": "Villa Vie"
    },
    {
      "eventTitle": "Breakfast",
      "startingTime": TimeOfDay.now(),
      "endingTime": TimeOfDay.now(),
      "organizerName": "Villa Vie"
    },
    {
      "eventTitle": "Dance Party",
      "startingTime": TimeOfDay.now(),
      "endingTime": TimeOfDay.now(),
      "organizerName": "Villa Vie"
    },
  ];
  List<Map<String, dynamic>> destinationList = [
    {
      "imageUrl": "assets/event_pictures/p13.png",
      "segment": "segment1",
      "date1": DateTime.now(),
      "date2": DateTime.now(),
      "name": "Florida Palm Beach"
    },
    {
      "imageUrl": "assets/event_pictures/p14.png",
      "segment": "segment2",
      "date1": DateTime.now(),
      "date2": DateTime.now(),
      "name": "Alaska Lakes"
    },
  ];
  List<Widget> pages = [
    HomePage(),
    CabinetDetailsPage(),
    SlotPage(),
    CategoriesPage(),
    CabinetDetailsPage1()
  ];
  bool isSignedIn = false;
  bool isStatusCollected = false;

  Future<void> getSigningStatus() async
  {
    final bool status = await PrefHelper.getLoginStatus();
    setState(() {
      isSignedIn = status;
      isStatusCollected = true;
    });
  }

  Widget getHome()
  {
    if (isStatusCollected)
    {
      if(isSignedIn)
      {
        if (currentIndex == 0)
        {
          return SingleChildScrollView(
            child: Column(
              children: [
                //topBar
                topBar(),
                //map
                SizedBox(
                  height: 180,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Image.asset(
                    "assets/event_pictures/map.png", fit: BoxFit.cover,),
                ),
                //rest
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      titleBox("Next Destination"),
                      SizedBox(height: 15,),
                      generateDestinationDetails(destinationList),
                      SizedBox(height: 15,),
                      titleBox("Upcoming Events"),
                      SizedBox(height: 12,),
                      eventList(list),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        else
        {
          return pages[currentIndex];
        }
      }
      else
      {
        return SignUpPage();
      }
    }
    else
    {
      return Center(child: CircularProgressIndicator(),);
    }
  }

  void navigationHelper(Widget w)
  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => w
        )
    );
  }

  @override
  void initState() {
    getSigningStatus();
    super.initState();
  }

  String actualTime(TimeOfDay time)
  {
    if(time.period == DayPeriod.am)
    {
      return "${time.toString().substring(10,15)} AM";
    }
    int hour = int.parse(time.toString().substring(10,12));

    if(hour == 12)
    {
      return "12:30 PM";
    }
    return "${hour - 12}:30 PM";
  }

  Color rgba(int r,int g,int b,double o)
  {
    return Color.fromRGBO(r, g, b, o);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        backgroundColor: Color.fromRGBO(6, 40, 70, 0.85),

        body: getHome(),

        bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar()
  {
    return isSignedIn ? Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 90,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.tealAccent,
            iconSize: 20,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            backgroundColor: Color.fromRGBO(1, 40, 75, 1),
            onTap: (val){
              setState(() {
                currentIndex = val;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore_outlined),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_available_sharp),
                label: "Event",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Community",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2_fill),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: "More",
              ),
            ],
          ),
        ),
      ),
    ) : Container(height: 0,);
  }

  Widget topBar()
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      alignment: FractionalOffset.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){
              navigationHelper(ProfilePage());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.044,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/event_pictures/pfp.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/event_pictures/logo.png",
            height: 30,
          ),
          Icon(CupertinoIcons.bell,color: Colors.white,)
        ],
      ),
    );
  }

  Widget generateDestinationDetails(List<Map<String,dynamic>> destinations)
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(

        shrinkWrap: true,
        separatorBuilder: (BuildContext context,int index)
        {
          return SizedBox(width: 10,);
        },
        scrollDirection: Axis.horizontal,
        // controller: PageController(viewportFraction: 320 / MediaQuery.of(context).size.width),
        itemCount: 2,
        itemBuilder: (context, index)
        {
        Map<String,dynamic> destination = destinations[index];
        return page(
            destination["imageUrl"],
            destination["segment"],
            destination["name"],
            destination["date1"],
            destination["date2"]
        );
      },
    ),
    );
  }

  Widget eventList(List<Map<String,dynamic>> eventList)
  {
    return ListView.separated(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int index)
        {
          Map<String,dynamic> map = eventList[index];
          return eventBox(map["eventTitle"],map["startingTime"],map["endingTime"],map["organizerName"]);
        },
        separatorBuilder: (BuildContext context,int index)
        {
          return SizedBox(height: 10,);
        },
        itemCount: eventList.length,
    );
  }

  Widget eventBox(String eventTitle,TimeOfDay statingTime,TimeOfDay endingTime,String organizersName)
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        color: rgba(253, 235, 230, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            eventTitle,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.040,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            "${actualTime(statingTime)} - ${actualTime(endingTime)}",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.038,
              color: rgba(130, 130, 130, 1),
            ),
          ),
          Text(
            organizersName,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.039,
              color: rgba(130, 130, 130, 1)
            ),
          ),
        ],
      ),
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
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400
          ),
        ),
        Text(
          "See All",
          style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  Widget page(String imageUrl,String segment,String name,DateTime date1,DateTime date2)
  {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(72,77,117,1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  segment,
                  style: TextStyle(
                      color: Color.fromRGBO(211, 165, 107, 1),
                      fontSize: 12
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  date1.toString().substring(0,10),
                  style: TextStyle(
                      color: Color.fromRGBO(0, 246, 218, 1),
                      fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  maxLines: 1,

                ),
                Text(
                  date2.toString().substring(0,16),
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}