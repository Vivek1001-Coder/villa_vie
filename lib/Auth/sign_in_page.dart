import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:villa_vie/Auth/sign_up_page.dart';
import 'package:villa_vie/Pages/splash_screen.dart';
import '../Pages/home_page.dart';
import '../SharedPreference/pref_helper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  Map<String,dynamic> userData = {};

  OutlineInputBorder commonBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10),
  );

  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
    borderRadius: BorderRadius.circular(10),
  );

  Future<void> getUserData() async
  {
    Map<String,dynamic> user = await PrefHelper.readUserData();
    setState(() {
       userData = user;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Color rgba(int r, int g, int b, double o) => Color.fromRGBO(r, g, b, o);

  String? emailValidation(val)
  {
    if(val == null || val.isEmpty)
    {
      return "Email required!";
    }
    else if (!val.contains(".") || !val.contains("@"))
    {
      return "Invalid email!";
    }
    return null;
  }

  String? passValidation(val) {
    if (val == null || val.isEmpty) {
      return "Password required!";
    } else if (val.toString().length < 6) {
      return "Weak password!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: BgImage(
        child: SingleChildScrollView(
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
                icon: Image.asset("assets/event_pictures/google.png", scale: 4),
                buttonLabel: "Sign In with Google",
                backgroundColor: Colors.white,
                textColor: Colors.black,
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
                "Don't have any account",
                "SIGN UP HERE",
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget inputBox({
    String? labelText,
    FormFieldValidator<String>? validatorFunction,
    required TextEditingController controller,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      validator: validatorFunction,
      obscureText: !showPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: commonBorder,
        focusedBorder: commonBorder,
        suffixIcon: suffixIcon ?? SizedBox(),
        enabledBorder: commonBorder,
        errorBorder: errorBorder,
        label: Text(
          labelText ?? "",
          style: TextStyle(color: rgba(151, 151, 151, 1)),
        ),
      ),
    );
  }

  Widget otherOption(
    String firstText,
    String secondOption, {
    required void Function() function,
  }) {
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
                fontSize: MediaQuery.sizeOf(context).height * 0.02,
              ),
            ),
          ),
          InkWell(
            onTap: function ?? () {},
            child: Text(
              secondOption,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).height * 0.02,
                  fontWeight: FontWeight.bold,
                  color: rgba(0, 145, 128, 1),
                  decoration: TextDecoration.underline,
                  decorationColor: rgba(0, 145, 128, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: rgba(139, 156, 127, 1)),
        ),
      ),
    );
  }

  Widget orDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: rgba(151, 151, 151, 1)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("OR", style: TextStyle(color: rgba(151, 151, 151, 1))),
        ),
      ],
    );
  }

  Widget signInForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          inputBox(
            labelText: "Email",
            controller: emailController,
            validatorFunction: emailValidation,
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          inputBox(
            labelText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon:
                  showPassword
                      ? Icon(CupertinoIcons.eye_fill, color: Colors.white)
                      : Icon(
                        CupertinoIcons.eye_slash_fill,
                        color: Colors.white,
                      ),
            ),
            validatorFunction: (value) {
              return passValidation(value);
            },
            controller: passwordController,
          ),
          forgotPassword(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          textButton(
            buttonLabel: "Sign In",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            function: () {
              if (formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
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

  Widget headerText(String text) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: MediaQuery.sizeOf(context).height * 0.028,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
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