import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jogo_da_velha/controllers/game_controller.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF595959),
        title: const Text(
          "Menu",
          style: TextStyle(
            fontFamily: 'AnonymousPro',
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(68.0),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset("./assets/Logo.png"),
            ),
          ),
          
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/multiplayer");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf1731c),
                foregroundColor: Colors.white),
            child: Container(
              width: 200,
              height: 50,
              alignment: Alignment.center,
              child: const Text("Iniciar Jogo (Player vs Player)"),
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf1731c),
                foregroundColor: Colors.white),
            child: Container(
              width: 200,
              height: 50,
              alignment: Alignment.center,
              child: const Text("Iniciar Jogo (Player vs CPU)"),
            ),
          ),
                    const SizedBox(height: 30,),
      
           ElevatedButton(
            onPressed: () {
              exit(0);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf1731c),
                foregroundColor: Colors.white),
            child: Container(
              width: 200,
              height: 50,
              alignment: Alignment.center,
              child: const Text("Sair"),
            ),
          ),
        ],
      ),
    );
  }
}
