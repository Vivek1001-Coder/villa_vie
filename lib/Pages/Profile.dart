import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:villa_vie/SharedPreference/pref_helper.dart';
import 'package:villa_vie/Pages/splash_screen.dart';
import 'package:villa_vie/Auth/sign_up_page.dart';
import 'package:http/http.dart' as http;
import 'package:villa_vie/Utils/Config.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map<String,dynamic> userData = {};

  Future<void> getUserData()async
  {
    Map<String,dynamic> user = await PrefHelper.readUserData();
    setState(() {
      userData = user;
    });
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String text)
  {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Container(
          alignment: Alignment.center,
          height: 40,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
          ),
        ),
      ),
    );
  }

  void logout()
  {
    setState(() {
      userData.clear();
      showSnackBar("Logging out");
      PrefHelper.clearAll();
      navigationHelper(SignUpPage());
    });
  }

  Future<void> deleteAccount() async
  {
    final response = await http.get(
      Uri.parse("$baseUrl/logout"),
    );
    if(response.statusCode == 200)
    {
      PrefHelper.clearAll();
      showSnackBar("Account Deleted!");
      navigationHelper(SignUpPage());
    }
    else
    {
      showSnackBar("There was some problem!");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        title: appBarTitle("${userData['name']} ${userData['lastName']}"),
        centerTitle: true,
      ),

      backgroundColor:  Colors.transparent,
      body: userData.isEmpty ? loading() : BgImage(child: body()),
    );
  }

  Widget loading()
  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget body()
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textBox("ID :", userData['id']?? "",Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Name :", userData['name'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Last Name :", userData['lastName'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Email :", userData['email'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Country Code :", userData['countryCode'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Phone Number :", userData['phoneNumber'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textBox("Assigned Ship :", userData['assignedShip'],Colors.white),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          Expanded(child: Container()),
          textButton(
            buttonLabel: "Logout",
            backgroundColor: Colors.white38,
            textColor: Colors.white,
            function: ()
              {
                logout();
              }
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
          textButton(
            buttonLabel: "Delete Account",
            backgroundColor: Colors.white38,
            textColor: Colors.white,
            function: ()
              {
                deleteAccount();
              }
          ),
        ],
      ),
    );
  }

  Widget textButton({
    Widget? icon,
    String? buttonLabel,
    Color? backgroundColor,
    Color? textColor,
    void Function()? function
  }) {
    return InkWell(
      onTap: function,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.07,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon != null)
              icon,
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.01,),
            Text(
                buttonLabel ?? "",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.025,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarTitle(String name)
  {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: MediaQuery.sizeOf(context).width * 0.055,
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          )
        )
        ,Text(
          " $name!",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width * 0.055,
                color: Colors.teal,
              fontWeight: FontWeight.w500
            ),
          )
        )
      ],
    );
  }

  Widget textBox(String labelText,String data,Color textColor)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          labelText,
          style: TextStyle(
              fontSize: 20,
              color: Colors.greenAccent
          ),
        ),
        Expanded(
            child: Text(
              " $data",
              maxLines: 2,
              style: TextStyle(
                  inherit: true,
                  fontSize: 20,
                  color: textColor
              ),
            )
        )
      ],
    );
  }
}
