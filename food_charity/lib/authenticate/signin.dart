import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_charity/loading.dart';
import 'package:food_charity/pages/choose.dart';
import 'package:food_charity/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  AuthService _auth = AuthService();
  String first = '';
  String last = '';
  String phone = '';
  String email = '';
  String password = '';
  String error = 'Something went Wrong!';
  bool isVisible = false;
  bool isError = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Form(
      key: _formkey,
      child: Scaffold(
        body: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CloseButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    isError
                        ? showAlert()
                        : SizedBox(
                            height: 30,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Hero(
                      transitionOnUserGestures: true,
                      tag: 'account',
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              first = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          validator: (val) => (val!.isEmpty
                              ? 'Please provide First Name!'
                              : null),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorStyle: TextStyle(color: Colors.amberAccent),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.amberAccent)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.amberAccent, width: 2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter First Name'),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              last = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          validator: (val) => (val!.isEmpty
                              ? 'Please provide Last Name!'
                              : null),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorStyle: TextStyle(color: Colors.amberAccent),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.amberAccent)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.amberAccent, width: 2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Last Name'),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (val) => (val!.isEmpty
                              ? 'Email Should not be empty!'
                              : null),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorStyle: TextStyle(color: Colors.amberAccent),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.amberAccent)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.amberAccent, width: 2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email'),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 35, 20),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) => val!.length < 6
                            ? 'provide password of minimum 6 didgit'
                            : null,
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: isVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            errorStyle: TextStyle(color: Colors.amberAccent),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.amberAccent, width: 2)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          validator: (val) => (val!.length != 10
                              ? 'Enter Valid Phone Number'
                              : null),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorStyle: TextStyle(color: Colors.amberAccent),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.amberAccent)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.amberAccent, width: 2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Phone'),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic result = await _auth.CreateNewUser(
                              email, password, first, last, phone);
                          if (result == null) {
                            setState(() {
                              isLoading = false;
                              isError = true;
                            });
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Choose()),
                                (route) => false);
                          }
                        }
                      },
                      child: Container(
                        width: width * 0.3,
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3, 3),
                                spreadRadius: 1,
                                blurRadius: 1),
                            BoxShadow(
                                color: Colors.white10,
                                offset: Offset(-3, -3),
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(width * 0.1),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        backgroundColor: Colors.blueAccent,
      ),
    ));
  }

  Widget showAlert() {
    return Container(
      height: 35,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.error_outline,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            error,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            width: 80,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isError = false;
              });
            },
            icon: Icon(
              Icons.close,
            ),
            iconSize: 20,
          )
        ],
      ),
      color: Colors.amber,
    );
  }
}
