import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../data/Models/tmdb_models.dart';
import 'Top Views /title_preview.dart';

class MyCell extends StatelessWidget {
  MyCell(this.item, {super.key}) {
    String tit = item.originalTitle ?? item.title ?? "";
    if (tit.length > 22) {
      String tm = "";
      for (int i = 0; i < 19; i++) {
        tm += tit[i];
      }
      tm += '...';
      tit = tm;
    }
    title = tit;
    posterPath = item.posterPath ?? "";
  }

  final Results item;
  late final String title;
  late final String posterPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TitlePreview(item),
            ));
      },
      child: Row(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              // child: Text("cds"),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/$posterPath',
                  fit: BoxFit.fill,
                  height: 140,
                  width: 102,
                ),
              )),
          const SizedBox(
            width: 7,
          ),
          Text(
            title,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
