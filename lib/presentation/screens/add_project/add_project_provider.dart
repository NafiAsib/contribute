import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contribute/core/utils/notifier_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddProjectProvider extends ChangeNotifier {
  NotifierState _notifierState = NotifierState.initial;
  NotifierState get notifierState => _notifierState;

  String? repo;
  bool? beginner;
  bool? intermediate;
  bool? expert;

  Future<void> add() async {
    _setState(NotifierState.loading);
    String? maintainer;
    String? maintainerImage;
    String? description;
    String? svnUrl;
    String? name;
    int? noOfStars;
    int? noOfForks;
    int? noOfIssues;
    List<dynamic>? topics;
    var url = Uri.parse('https://api.github.com/repos/$repo');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      maintainer = jsonResponse['owner']['login'];
      maintainerImage = jsonResponse['owner']['avatar_url'];
      description = jsonResponse['description'];
      svnUrl = jsonResponse['svn_url'];
      noOfStars = jsonResponse['stargazers_count'];
      noOfForks = jsonResponse['forks_count'];
      noOfIssues = jsonResponse['open_issues'];
      topics = jsonResponse['topics'];
      name = jsonResponse['name'];
      debugPrint(maintainer.toString() +
          maintainerImage.toString() +
          description.toString() +
          svnUrl.toString() +
          noOfStars.toString() +
          noOfForks.toString() +
          noOfIssues.toString());
      topics?.forEach((element) => debugPrint(element));
    } else {
      _setState(NotifierState.error);
      debugPrint('Request failed with status: ${response.statusCode}.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');
    debugPrint('going to return');
    return projects
        .add({
          "seeker": user?.uid,
          "maintainer": maintainer,
          "maintainerImage": maintainerImage,
          "description": description,
          "svnUrl": svnUrl,
          "noOfStars": noOfStars,
          "noOfForks": noOfForks,
          "noOfIssues": noOfIssues,
          "topics": topics,
          "beginner": beginner,
          "intermediate": intermediate,
          "expert": expert,
          "name": name,
        })
        .then((value) => _setState(NotifierState.loaded))
        .catchError((error) => debugPrint("Failed to add project: $error"));
  }

  void _setState(NotifierState notifierState) {
    _notifierState = notifierState;
    notifyListeners();
  }

  void setInitial() {
    _setState(NotifierState.initial);
    debugPrint(_notifierState.toString());
    // print(_notifierState);
  }
}
