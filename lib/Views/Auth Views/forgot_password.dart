import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
          'Forgot Password',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 75, left: 15, right: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Reset your password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 47, 45, 45),
                            hintText: "Email Address",
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 400,
                        height: 60,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide()))),
                          onPressed: () {},
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
