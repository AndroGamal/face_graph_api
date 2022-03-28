import 'dart:convert';
import 'package:face_graph_api/Toaston.dart';
import 'package:face_graph_api/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  late SharedPreferences _prefs;
  late String id, name, access_token, app_id, app_secret;
  List<dynamic> posts = [];
  late Uri url;
  late var code, json;
  late MyHomePageState myHomePageState;
  User(String access_token, app_id, app_secret, MyHomePageState n) {
    this.access_token = access_token;
    this.app_id = app_id;
    this.app_secret = app_secret;
    _get_user();
    myHomePageState = n;
  }
  void _get_user() async {
    _prefs = await SharedPreferences.getInstance();
    if ((_prefs.getString("access_token") ?? "") == "") {
      url = Uri.parse(
          "https://graph.facebook.com/v13.0/oauth/access_token?grant_type=fb_exchange_token&client_id=$app_id&client_secret=$app_secret&fb_exchange_token=$access_token");
      code = await http.get(url);
      json = jsonDecode(code.body);
      access_token = json["access_token"];
      _prefs.setString("access_token", access_token);
      _prefs.commit();
    } else {
      access_token = _prefs.getString("access_token") ?? access_token;
    }
    url = Uri.parse(
        "https://graph.facebook.com/v13.0/me?access_token=$access_token");
    code = await http.get(url);
    json = jsonDecode(code.body);
    id = json["id"];
    name = json["name"];
    url = Uri.parse(
        "https://graph.facebook.com/$id/posts/?access_token=$access_token");
    code = await http.get(url);
    json = jsonDecode(code.body);
    myHomePageState.setState(() {
      posts = json["data"];
    });
  }

  void delete(int index) async {
    var post_id = posts[index]["id"];
    url = Uri.parse(
        "https://graph.facebook.com/$post_id?access_token=$access_token");
    code = await http.delete(url);
    json = jsonDecode(code.body);
    if (json["error"] == null) {
      myHomePageState.setState(() {
        posts.removeAt(index);
      });
      Toastan.show_unusual("delete Done", myHomePageState.context, true);
    } else {
      Toastan.show_unusual("delete Faild", myHomePageState.context, false);
    }
  }

  void set_post(String message) async {
    if (message.length > 0) {
      url = Uri.parse(
          "https://graph.facebook.com/$id/feed?message=$message&fields=created_time,from,id,message&access_token=$access_token");
      code = await http.post(url);
      json = jsonDecode(code.body);
      if (json["error"] == null) {
        myHomePageState.setState(() {
          posts.add(json);
        });
        Toastan.show_unusual("Post Done", myHomePageState.context, true);
      } else {
        Toastan.show_unusual("Post Faild", myHomePageState.context, false);
      }
    }
  }
}
