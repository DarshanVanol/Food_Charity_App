import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/authenticate/signin.dart';
import 'package:food_charity/loading.dart';
import 'package:food_charity/pages/choose.dart';
import 'package:food_charity/services/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String error = '';
  bool isLoading = false;
  bool showError = false;
  String email = '';
  String password = '';
  AuthService auth = AuthService();
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController controller = new TextEditingController();

  Widget showAlert() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.error_outline),
          SizedBox(
            width: 10,
          ),
          Text(
            error,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            width: 70,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  showError = false;
                });
              },
              icon: Icon(Icons.close))
        ],
      ),
      color: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading
          ? Loading()
          : Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    showError
                        ? showAlert()
                        : SizedBox(
                            height: 40,
                          ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'email must not be empty' : null,
                        controller: controller,
                        decoration: InputDecoration(
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
                            hintText: 'Username'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) => val!.length < 6
                            ? 'provide password of minimum 6 didgit'
                            : null,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: isVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          dynamic result = await auth.logIn(email, password);

                          if (result == null) {
                            setState(() {
                              isLoading = false;
                              error = 'Invalid Email or Password';
                              showError = true;
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
                        width: width * 0.25,
                        height: 35,
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
                            'Login',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Don\'t have account?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => SignIn()));
                      },
                      child: Container(
                        width: width * 0.35,
                        height: 28,
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
                            'Create Account',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.blueAccent,
    );
  }
}
