import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/Views/Nav%20Bar/navigation_bar.dart';
import 'package:my_first_app/logic/api_data/api_data_cubit.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';
import 'package:path/path.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseFirestore firebaseFirestore =
      GetIt.instance.get<FirebaseFirestore>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  // Future uploadFile() async {
  //   if (_photo == null) return;
  //   final fileName = basename(_photo!.path);
  //   final destination = 'files/$fileName';

  //   try {
  //     final ref = firebase_storage.FirebaseStorage.instance
  //         .ref(destination)
  //         .child('file/');
  //     await ref.putFile(_photo!);
  //   } catch (e) {
  //     print('error occured');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: _photo != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        _photo!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                            ),
                            // const SizedBox(
                            //   width: 50,
                            // ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Create your new account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: nameController,
                            keyboardType: TextInputType.name,
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
                              hintText: "Full Name",
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
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
                              hintText: "Mobile Number",
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: usernameController,
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
                              hintText: "Username",
                            )),
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
                        BlocConsumer<CreateAccountCubit, CreateAccountState>(
                          listener: (context, state) {
                            if (state is AccountCreatedState) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyNavigationBar()));
                            } else if (state is AccountCreationError) {
                              // ToDO: Add snacbar
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
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String password =
                                      passwordController.text.trim();
                                  String username =
                                      usernameController.text.trim();
                                  String mobile = mobileController.text.trim();
                                  String tm = verify(name, email, password,
                                      username, mobile, context);
                                  if (tm == "1") {
                                    emailController.clear();
                                    return;
                                  }
                                  if (tm == "2") {
                                    mobileController.clear();
                                    return;
                                  }
                                  if (tm == "3") {
                                    passwordController.clear();
                                    return;
                                  }

                                  final cubit =
                                      BlocProvider.of<CreateAccountCubit>(
                                          context);
                                  cubit.createAccount(username, name, mobile,
                                      email, password, _photo);
                                },
                                child: const Text(
                                  "Sign Up",
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
                        const Text(
                          "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Already have an account? Sign In.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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

  String verify(String name, String email, String password, String username,
      String mobile, BuildContext context) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      if (mobile.length == 10) {
        if (RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password)) {
          return "0";
        } else {
          alert(context, "Please enter a strong password", "Password");
          return "3";
        }
      } else {
        alert(context, "Please enter a valid mobile number", "Mobile Number");
        return "2";
      }
    } else {
      alert(context, "Please enter a valid Email", "Email");
      return "1";
    }
  }

  void alert(BuildContext context, String m, String t) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(t),
            content: Text(m),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"))
            ],
          ),
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        print('sdsa');
                        imgFromGallery();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
