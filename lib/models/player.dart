

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Player {
  int id;
  String name;
  int points;

  Player({required this.id, required this.name, required this.points});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      points: json['points']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'points': points,
    };
  }

  Future<void> savePlayerList(List<Player> players) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> jsonStringList = players.map((player) => jsonEncode(player.toJson())).toList();
  await prefs.setStringList('players', jsonStringList);
  }

    

}