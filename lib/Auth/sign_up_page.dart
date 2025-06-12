import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:villa_vie/Auth/sign_in_page.dart';
import 'package:villa_vie/Pages/splash_screen.dart';
import '../SharedPreference/pref_helper.dart';
import '../Utils/Config.dart';
import 'OTP_verification_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  bool showPassword = false;
  bool confirmShowPassword = false;
  OutlineInputBorder commonBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10),
  );
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
    borderRadius: BorderRadius.circular(10),
  );
  String? id;

  Color rgba(int r, int g, int b, double o) => Color.fromRGBO(r, g, b, o);

  Future<bool> register(
      String name,
      String lastName,
      String email,
      String password,
      String loginType,
      String assignedShip,
      String countryCode,
      String phoneNumber,
      ) async
  {
    Map<String,String> formData = {
      "first_name" : name,
      "last_name" : lastName,
      "email" : email,
      "login_type" : loginType,
      "password" : password,
      "assigned_ship" : assignedShip,
      "phone_number" : phoneNumber,
      "country_code" : countryCode
    };
    final response = await http.post(
        Uri.parse("$baseUrl/register",),
        body: formData,
    );

    Map<String,dynamic> responseBody = jsonDecode(response.body);

    if(response.statusCode == 200)
    {
      setState(() {
        id = responseBody['id'];
      });
      return true;
    }
    else
    {
      showSnackBar(response.reasonPhrase.toString());
      showSnackBar(response.body);
      print("***********************************************************************************************");
      print("********************* ${response.statusCode} ${response.reasonPhrase} ******************");
      print("********************* ${response.body} ******************");
      print("***********************************************************************************************");
      return false;
    }
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

  String? emailValidation(val) {
    if (val == null || val.isEmpty) {
      return "Email required!";
    } else if (!val.contains(".") || !val.contains("@")) {
      return "Invalid email!";
    }
    return null;
  }

  String? passValidation(val) {
    if (val == null || val.isEmpty) {
      return "password required!";
    }
    else if(val.toString().length < 6)
    {
      return "Weak password!";
    }
    return null;
  }
  
  String? confirmPassValidation(val) {
    if (val == null || val.isEmpty) {
      return "password required!";
    }
    else if(confirmPasswordController.text != passwordController.text)
    {
      return "Password do not match!";
    }
    return null;
  }

  String? nameValidation(val) {

    RegExp regex = RegExp(r'^[0-9]+$');
    if (val == null || val.isEmpty) {
      return "required!";
    }
    else if(val.toString().contains(regex))
    {
      return "Invalid name!";
    }
    return null;
  }

  String? lastNameValidation(val) {

    RegExp regex = RegExp(r'^[0-9]+$');
    if (val == null || val.isEmpty) {
      return "required!";
    }
    else if(val.toString().contains(regex))
    {
      return "Invalid lastName!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.05,
              vertical: MediaQuery.sizeOf(context).height * 0.09,
            ),
            child: Column(
              children: [
                logo(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                headerText("Let's Get Started"),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                signInForm(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                orDivider(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                textButton(
                    icon: Image.asset("assets/event_pictures/google.png",scale: 4,),
                    buttonLabel: "Sign In with Google",
                    backgroundColor: Colors.white,
                    textColor: Colors.black
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                textButton(
                    icon: Icon(Icons.apple),
                    buttonLabel: "Sign In with Apple ID",
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
                otherOption(
                    "Already have any account",
                    "SIGN IN HERE",
                    function: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_)=> SignInPage()
                      )
                      );
                    },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputBox(
      {
        String? labelText,
        FormFieldValidator<String>? validatorFunction,
        required  TextEditingController controller,
        Widget? suffixIcon,
        required bool showPassword,
        required TextInputType inputType
      }) {
    return TextFormField(
      controller: controller,
      validator: validatorFunction,
      obscureText: !showPassword,
      keyboardType: inputType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: commonBorder,
        focusedBorder: commonBorder,
        suffixIcon: suffixIcon ?? SizedBox(),
        enabledBorder: commonBorder,
        errorBorder: errorBorder,
        label: Text(labelText??"", style: TextStyle(color: rgba(151, 151, 151, 1))),
      ),
    );
  }

  Widget otherOption(String firstText,String secondOption,{required void Function() function})
  {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
              firstText,
              style: GoogleFonts.figtree(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.sizeOf(context).height * 0.02
                ),
              )
          ),
          InkWell(
            onTap: function,
            child: Text(
                secondOption,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                      fontWeight: FontWeight.bold,
                      color: rgba(0, 145, 128, 1),
                      decoration: TextDecoration.underline,
                      decorationColor: rgba(0, 145, 128, 1)
                  ),
                )
            ),
          )

        ],
      ),
    );
  }

  Widget forgotPassword()
  {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: (){

          },
          style: ButtonStyle(
            padding:  WidgetStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: rgba(139, 156, 127, 1),
              )
          )
      ),
    );
  }

  Widget orDivider()
  {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: rgba(151, 151, 151, 1),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: TextStyle(
              color: rgba(151, 151, 151, 1),
            ),
          ),
        )
      ],
    );
  }

  Widget signInForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: inputBox(
                    labelText: "Name",
                    controller: nameController,
                    validatorFunction: nameValidation,
                    showPassword: true,
                    inputType: TextInputType.text,),
                ),
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.04,),
                Flexible(flex: 1,child: inputBox(labelText: "Last Name",controller: lastNameController,validatorFunction: lastNameValidation,showPassword: true,
                    inputType: TextInputType.text),)
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          inputBox(
              labelText: "Phone Number",
              controller: phoneNumberController,
              suffixIcon: Icon(Icons.phone,color: Colors.white,),
              showPassword: true,
              inputType: TextInputType.phone
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          inputBox(
              labelText: "Email",
              controller: emailController ,
              validatorFunction: emailValidation,
              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.mail,color: Colors.white,),),
              showPassword: true,
              inputType: TextInputType.emailAddress
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          inputBox(
            labelText: "Password",
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                showPassword = !showPassword;
              });
            },
                icon: showPassword ?
                Icon(CupertinoIcons.eye_fill,color: Colors.white,) :
                Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,)
            ),
              validatorFunction: passValidation,
              controller: passwordController,
              showPassword: showPassword,
              inputType: TextInputType.visiblePassword
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          inputBox(
            labelText: "Confirm Password",
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                confirmShowPassword = !confirmShowPassword;
              });
            },
                icon: confirmShowPassword ?
                Icon(CupertinoIcons.eye_fill,color: Colors.white,) :
                Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,)
            ),
              validatorFunction: confirmPassValidation,
              controller: confirmPasswordController,
              showPassword: confirmShowPassword,
              inputType: TextInputType.visiblePassword
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          textButton(
            buttonLabel: "Sign Up",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            function: () async{
              if (formKey.currentState!.validate()) {
                String name = nameController.text.trim();
                String lastName = lastNameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text;
                String phoneNumber = phoneNumberController.text;

                bool isRegistered = await register(name, lastName, email, password,"OTP", "", "+91", phoneNumber);
                if(isRegistered)
                {
                  showSnackBar("Registered Successfully!");
                  PrefHelper.saveUserData(name, lastName, email, password, true,"OTP","","+91",phoneNumber,id?? "");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationPage(),
                    ),
                  );
                }
              }
            },
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
                    fontSize: MediaQuery.sizeOf(context).height * 0.021,
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

  Widget headerText(String text) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: MediaQuery.sizeOf(context).height * 0.028,
              fontWeight: FontWeight.w600 ,
              color: Colors.white,
            ),
          )
      ),
    );
  }

  Widget logo() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.07,
      alignment: Alignment.center,
      child: Image.asset("assets/event_pictures/logo.png"),
    );
  }
}
