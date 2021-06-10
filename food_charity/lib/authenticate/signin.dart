import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Form(
      key: _formkey,
      child: Scaffold(
        body: SingleChildScrollView(
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
                child: fields(
                  isText: true,
                  hint: 'First Name',
                  validation: 'Field is empty!!',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                child: fields(
                  hint: 'Last Name',
                  isText: true,
                  validation: 'Field is empty!!',
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                  child: fields(
                    hint: 'Email',
                    isText: true,
                    validation: 'Please provide email!',
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 20),
                child: TextFormField(
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
                          borderSide: BorderSide(color: Colors.transparent)),
                      errorStyle: TextStyle(color: Colors.amberAccent),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.amberAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.amberAccent, width: 2)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: fields(
                    hint: 'Contact',
                    validation: 'Must be of 10 digits',
                    isText: false,
                  )),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  _formkey.currentState!.validate();
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
}

class fields extends StatelessWidget {
  bool isText;
  String hint;
  String validation;
  fields({required this.isText, required this.hint, required this.validation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isText ? TextInputType.emailAddress : TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (val) => isText
          ? (val!.isEmpty ? validation : null)
          : (val!.length != 10 ? validation : null),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent)),
          errorStyle: TextStyle(color: Colors.amberAccent),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.amberAccent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.amberAccent, width: 2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint),
    );
  }
}
