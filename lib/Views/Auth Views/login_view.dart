import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/Views/Auth%20Views/forgot_password.dart';
import 'package:my_first_app/Views/Auth%20Views/register_view.dart';
import 'package:my_first_app/logic/api_data/api_data_cubit.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';

import '../Nav Bar/navigation_bar.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.pink,
                            backgroundImage: NetworkImage(
                                'https://png.pngtree.com/png-clipart/20220508/original/pngtree-movie-time-film-cinema-vintage-poster-png-image_7659206.png')),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Sign in to your account",
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
                          height: 10,
                        ),
                        TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 47, 45, 45),
                              hintText: "Password",
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocConsumer<SignInCubit, SignInState>(
                          listener: (context, state) {
                            if (state is SignInFailState) {
                              // TODO: implement snacbar
                            } else if (state is SignInPassState) {
                              print("Heeeeeee");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyNavigationBar()));
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              width: 400,
                              height: 60,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide()))),
                                onPressed: () {
                                  final cubit =
                                      BlocProvider.of<SignInCubit>(context);
                                  cubit.signInUser(emailController.text,
                                      passwordController.text);
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterView()));
                          },
                          child: const Text(
                            "New User? Create Account.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
