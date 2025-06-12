import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:villa_vie/Utils/Config.dart';
import '../Pages/home_page.dart';
import '../SharedPreference/pref_helper.dart';
import 'package:http/http.dart' as http;

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  Map<String,dynamic> prefs = {};
  bool isLoading = true;
  int remainingTime = 31;
  Timer? timer;
  Color resendColor = CupertinoColors.systemGrey;
  bool isOtpSent = false;

  void startTimer()
  {
    timer = Timer.periodic(Duration(seconds: 1), (time){
      if(remainingTime == 0)
      {
        setState(() {
          resendColor = Color.fromRGBO(0, 145, 128, 1);
          remainingTime = -1;
        });
        time.cancel();
      }
      else
      {
        setState(() {
          remainingTime--;
        });
      }
    });
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
  
  Future<bool> verifyOtp() async
  {
    Map<String,String> body = {
      "type" : "email",
      "email": prefs["email"],
      "otp": controller.text
    };

    final response = await http.post(
      Uri.parse("$baseUrl/verify-otp"),
      body: body
    );

    Map<String,dynamic> responseBody = jsonDecode(response.body);

    if(response.statusCode == 200)
    {
      PrefHelper.setToken(responseBody['apitoken']);
      return true;
    }
    else
    {
      showSnackBar(response.body);
      return false;
    }
  }
  
  Future<void> resendOtp() async
  {
    Map<String,String> body = {
      "email" : prefs["email"],
      "type" : "email"
    };

    final response = await http.post(
      Uri.parse("$baseUrl/resend-otp"),
      body: body
    );

    if(response.statusCode == 200)
    {
      setState(() {
        remainingTime = 31;
      });
      resendColor = CupertinoColors.systemGrey;
      startTimer();
      showSnackBar("OTP Sent Again!");
    }
    else
    {
      showSnackBar("Something Went Wrong! Try Again.");
    }
  }

  Future<void> getPrefs() async
  {
    try {
      final loadedPrefs = await PrefHelper.readUserData();
      setState(() {
        prefs = loadedPrefs;
        isLoading = false;
        print("**********************************************************");
        print("Prefs Loaded!");
        print("**********************************************************");
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        print("**********************************************************");
        print("Problem in Loading prefs!");
        print("**********************************************************");
      });
    }
  }

  // Future<void> sendOtp() async
  // {
  //   Map<String,String> body = {
  //     "type" : "email",
  //     "email" : prefs["email"],
  //     "user_id": prefs["id"],
  //     "phone": prefs["phoneNumber"],
  //     "country_code": prefs["countryCode"],
  //     // "country_identifier":"India (IN) [+91]"
  //   };
  //
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/send-otp"),
  //     body: body
  //   );
  //
  //   if(response.statusCode == 200)
  //   {
  //     setState(() {
  //       isOtpSent = true;
  //     });
  //   }
  //   else
  //   {
  //     showSnackBar("Something Went Wrong!");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getPrefs();
    startTimer();
  }

  OutlineInputBorder commonBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal),
    borderRadius: BorderRadius.circular(10),
  );

  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
    borderRadius: BorderRadius.circular(10),
  );

  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10),
  );

  Color rgba(int r, int g, int b, double o) => Color.fromRGBO(r, g, b, o);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 40, 70, 0.85),
      body: body()
    );
  }

  Widget loading()
  {
    return Center(child: CircularProgressIndicator(),);
  }

  Widget body()
  {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: MediaQuery.sizeOf(context).width,
              alignment: Alignment.center,
              child: Image.asset("assets/event_pictures/photo.png"),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            headerText("Verification"),
            textWithClickable(
              "Enter the code sent to",
              prefs["email"]?? "example@email.com",
              rgba(0, 145, 128, 1),
                  (){},
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            signInForm(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            textWithClickable(
                "Don't receive an SMS?",
                " Resend SMS ${remainingTime >= 0? "in $remainingTime" : ""}",
                resendColor,
                remainingTime >= 0 ? (){} : resendOtp()
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            textButton(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                buttonLabel: "Continue",
                function: () async {
                  if(formKey.currentState!.validate() && await verifyOtp())
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
                  }
                }
            ),
            // Text(actualOtp.toString(),style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }

  Widget signInForm()
  {
    return Form(
      key: formKey,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: PinCodeTextField(
          onChanged: (val) async{
            if(val.length == 6 && !val.contains(".") && await verifyOtp())
              {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
              }
          },
          obscureText: true,
          obscuringCharacter: "*",
          textStyle: TextStyle(
            color: Colors.white
          ),
          validator: (val){
            if(val!.length < 6)
            {
              return "Enter entire Otp!";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: controller,
          animationType: AnimationType.slide,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 1,
            fieldWidth: MediaQuery.sizeOf(context).width * 0.13,
            activeColor: Colors.white,
            inactiveColor: Colors.teal,
            selectedColor: Colors.teal,
            selectedBorderWidth: 1,
            activeBorderWidth: 1,
            inactiveBorderWidth: 1
          ),
          appContext: context,
          length: 6,
        ),
      )
    );
  }

  Widget textWithClickable(String text, String clickableText,Color textColor,Object function)
  {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: MediaQuery.sizeOf(context).height * 0.016,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.005,),
        Text(
          clickableText,
          maxLines: 2,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: MediaQuery.sizeOf(context).height * 0.016,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget textButton({
    Widget? icon,
    String? buttonLabel,
    Color? backgroundColor,
    Color? textColor,
    void Function()? function,
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
            if (icon != null) icon,
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
            Text(
              buttonLabel ?? "",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).height * 0.021,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
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
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: MediaQuery.sizeOf(context).height * 0.03,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}