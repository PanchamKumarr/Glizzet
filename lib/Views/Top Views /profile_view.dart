import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_app/data/Models/user.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final CurrentUser currentUser = GetIt.instance.get<CurrentUser>();

  @override
  Widget build(BuildContext context) {
    final url = currentUser.downloadURL;
    print(currentUser);
    print(url);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Glizzet',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Text(
              currentUser.username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              // 'https://www.xtrafondos.com/wallpapers/vertical/kobe-bryant-fanart-5665.jpg'),
              backgroundColor: Colors.black,
              radius: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Name",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 25,
              ),
            ),
            Text(
              currentUser.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Email Address",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 22,
              ),
            ),
            Text(
              currentUser.email,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Mobile Number",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 23,
              ),
            ),
            Text(
              currentUser.mobile,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
