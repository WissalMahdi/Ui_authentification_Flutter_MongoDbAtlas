// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ui_authetification/config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRememberMe = false;
  //final bool _isExpanded = false;
  String? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.png"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  color: Color.fromARGB(255, 88, 114, 170).withOpacity(.85),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "WELCOME__",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                children: [
                              TextSpan(
                                  text: isSignupScreen ? "__User," : "_Back,",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )),
                            ])),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          isSignupScreen
                              ? "Signup To Continue"
                              : "Signin To Continue",
                          style: TextStyle(
                            letterSpacing: 5,
                            color: Colors.white,
                          ),
                        )
                      ]),
                ),
              )),
          //Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),

          //Main container for box login and signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInCubic,
              height: isSignupScreen ? 450 : 250,
              padding: EdgeInsets.all(20),
              //width: _isExpanded ? -40 : 315,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 6, 40, 230),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 10, 14, 223),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add a submit buttom
          buildBottomHalfContainer(false)
        ],
      ),
    );
  }

// EL Box mta3 signIn (Login)
  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(children: [
        buildTextField(Icons.mail_outline, "Email@Email.com", false, true),
        buildTextField(
            MaterialCommunityIcons.lock_outline, "**********", true, false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isRememberMe,
                  activeColor: Palette.textColor2,
                  onChanged: (value) {
                    setState(() {
                      isRememberMe = !isRememberMe;
                    });
                  },
                ),
                Text(
                  "Remember me",
                  style: TextStyle(fontSize: 12, color: Palette.textColor1),
                )
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 12, color: Palette.textColor1),
                ))
          ],
        )
      ]),
    );
  }

// zone de texte of user name pwd and email
  Container buildSignupSection() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(children: [
          buildTextField(MaterialCommunityIcons.account_outline, "User Name",
              false, false),
          buildTextField(
              MaterialCommunityIcons.email_outline, "Email", false, true),
          buildTextField(
              MaterialCommunityIcons.lock_outline, "Password", true, false),

          // liste de choix(DropDown list )
          DropdownButtonFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                        color: Color.fromARGB(181, 66, 66, 75), width: 1))),
            hint: _dropDownValue == null
                ? Text('You are a :')
                : Text(
                    _dropDownValue!,
                    style: TextStyle(color: Color.fromARGB(255, 16, 20, 22)),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.black),
            items: ['Formateur', 'Apprenant', 'Employeur'].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _dropDownValue = val as String;
                },
              );
            },
          ),

          // Male and Female Buttons
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Palette.textColor2
                                : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Colors.transparent
                                    : Palette.textColor1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Colors.transparent
                                : Palette.textColor2,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Palette.textColor1
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Text by pressing 'Submit' you agree to our
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      text: "term & conditions",
                      style: TextStyle(color: Color.fromARGB(255, 28, 8, 207)),
                    )
                  ]),
            ),
          )
        ]));
  }

// lfazet mta3 l'annimation wel circle elli m louta elli fiha l fléche
  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInCubic,
        top: isSignupScreen ? 600 : 433,
        right: 0,
        left: 0,
        child: Center(
          child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                ]),

            //el boutton mta3 l fléche elli m louta
            child: !showShadow
                ? Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 164, 203, 231),
                              Color.fromARGB(255, 37, 104, 185)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                : Center(),
          ),
        ));
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35.0))),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
      ),
    );
  }
}
