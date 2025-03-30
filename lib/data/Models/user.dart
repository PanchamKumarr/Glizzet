import 'package:my_first_app/data/Models/tmdb_models.dart';

class CurrentUser {
  String uid = "";
  String username = "";
  String name = "";
  String mobile = "";
  String email = "";
  String downloadURL = "";
  List<Results> watchList = [];

  void update(String uid, String username, String name, String mobile,
      String email, String downloadURL, List<Results> watchList) {
    this.uid = uid;
    this.username = username;
    this.name = name;
    this.mobile = mobile;
    this.email = email;
    this.downloadURL = downloadURL;
    this.watchList = watchList;
  }
}
