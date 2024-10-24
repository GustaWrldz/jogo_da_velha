import 'package:flutter/material.dart';
import 'package:jogo_da_velha/pages/board_page.dart';
import 'package:jogo_da_velha/pages/menu_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MenuPage(),
      routes: {
        "/menu": (context) => MenuPage(),
        "/singleplayer": (context) => Container(),
        "/multiplayer": (context) => BoardPage()
      },
    );
  }
}

