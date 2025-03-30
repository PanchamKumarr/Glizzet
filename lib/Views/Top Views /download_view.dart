import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_first_app/Views/my_cell.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              color: Theme.of(context).dividerColor,
            );
          },
          itemCount: 20),
    );
  }
}
