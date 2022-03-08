// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, unnecessary_new, unused_element, unused_local_variable

import 'dart:ffi';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ui_authetification/MongoDbModel.dart';
import 'package:ui_authetification/config/palette.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:ui_authetification/dbHelper/mongodb.dart';

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
  String? valueChoose;
  List listItems = ['Formateur', 'Apprenant', 'Employeur'];
  var fnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addressController = new TextEditingController();
  bool _isObscure = true;

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
                                  fontStyle: FontStyle.italic,
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
        //buildTextField(Icons.mail_outline, "Email@Email.com", false, true),

        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle_outlined),
            labelText: "Email",
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1, width: 1),
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: _isObscure,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            labelText: "Password",
            filled: true,
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1, width: 1),
                borderRadius: BorderRadius.circular(30)),
          ),
        ),

        /* buildTextField(
            MaterialCommunityIcons.lock_outline, "**********", true, false),*/
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

// zone de texte of SIGNUP (user name, pwd and email)
  Container buildSignupSection() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle_outlined),
              labelText: "Full Name",
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1, width: 1),
                  borderRadius: BorderRadius.circular(30)),
            ),
            controller: fnameController,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: "Email",
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1, width: 1),
                  borderRadius: BorderRadius.circular(50)),
            ),
            controller: lnameController,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              labelText: "Password",
              filled: true,
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1, width: 1),
                  borderRadius: BorderRadius.circular(50)),
            ),
            controller: addressController,
          ),

          /*   ElevatedButton(
            child: Text(
              'Button',
              // style: TextStyle(fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(100),
              fixedSize: const Size(65, 65),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              _insertData(fnameController.text, lnameController.text,
                  addressController.text);
            },
          ),*/
          //child: Text("Insert Data")),

          // liste de choix(DropDown list )

          /*  DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Palette.textColor1, width: 1)),
              prefixIcon: Icon(
                Icons.person,
                color: Palette.textColor1,
              ),
            ),
            hint: Text(
              'Please choose account type',
              style: TextStyle(color: Palette.textColor1),
          ),
            items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
        ),*/

          /*  Container(
            decoration: BoxDecoration(
                border: Border.all(color: Palette.textColor1, width: 1),
                borderRadius: BorderRadius.circular(25)),
            child: DropdownButton(
              hint: Text(
                "Please choose your role :",
                style: TextStyle(
                  color: Palette.textColor1,
                ),
              ),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 30,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(color: Colors.black, fontSize: 15),
              value: valueChoose,
              onChanged: (newValue) {
                setState(
                  () {
                    valueChoose = newValue as String;
                  },
                );
              },
              items: listItems.map((valueItem) {
                return DropdownMenuItem(
                  // child: Text(valueItem),
                  value: valueItem,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.person_pin),
                        color: Palette.textColor1,
                        onPressed: () {},
                      ),
                      Text(valueItem),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),*/

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
                        color: Color.fromARGB(255, 4, 0, 243).withOpacity(.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                ]),

            //el doura elli feha l fléche elli m louta
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
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      },
                    )

                    /* Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      
                    ),*/
                    )
                : Center(),
          ),
        ));
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail,
      {TextEditingController? controller}) {
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
              borderSide: BorderSide(color: Color.fromARGB(255, 199, 167, 167)),
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

// Creating Function for button click to call insert data
  Future<Void?> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, adress: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Your registration has been successfully completed")));
    /*ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));*/
    _clearAll();
    return null;
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  /* void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetName() + "\n" + faker.address.streetAddress();
    });
  }*/
}
