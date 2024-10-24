import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_da_velha/controllers/game_controller.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  BoardPageState createState() => BoardPageState();
}

class BoardPageState extends State<BoardPage> {
  final TextEditingController questionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = GameController();
  int randomNumber1 = Random().nextInt(10);
  int randomNumber2 = Random().nextInt(10);
  int randomIndex = Random().nextInt(2);
  List operations = ["*", "+", "-"];

  @override
  void initState() {
    _controller.isSinglePlayer = false;
    super.initState();
  }

  int? userResponse() {
    if (operations[randomIndex] == "*") {
      return randomNumber1 * randomNumber2;
    }
    if (operations[randomIndex] == "+") {
      return randomNumber1 + randomNumber2;
    }
    if (operations[randomIndex] == "-") {
      return randomNumber1 - randomNumber2;
    }
  }

  _onMarkTile(index) {
    if (!_controller.tiles[index].enable) return;

    setState(() {
      _controller.markBoardTileByIndex(index);
    });

    _checkWinner();
  }

  _checkWinner() async {
    var winner = await _controller.checkWinner();
    print("ta emtramd");
    print(winner);

    if (winner == WinnerType.none) {
      if (!_controller.hasMoves) {
        _showTiedDialog();
      } else if (_controller.isSinglePlayer! &&
          _controller.currentPlayer == PlayerType.player2) {
        final index = _controller.automaticMove();
        _onMarkTile(index);
      }
    } else {
      String symbol = winner == WinnerType.player1 ? "Player 1" : "Plater";
      _showWinnerDialog(symbol);
    }
  }

  _showQuestionDialog(index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        print("${randomNumber1} ${randomNumber2} ${operations[randomIndex]}");
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
              "${randomNumber1} ${operations[randomIndex]} ${randomNumber2}"),
          actions: [
            Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextFormField(
                      controller: questionController,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Digite um valor";
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Insira sua resposta"),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int? valor = userResponse();
                          double valorResponse =
                              int.parse(questionController.text).toDouble();

                          if (valor == valorResponse) {
                            _onMarkTile(index);
                          }

                          setState(() {
                            randomNumber1 = Random().nextInt(10);
                            randomNumber2 = Random().nextInt(10);
                            randomIndex = Random().nextInt(2);
                          });
                          Navigator.pop(context);
                          questionController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFf1731c),
                          foregroundColor: Colors.white),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("Enviar"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            child: Column(
              children: [
                Text("${symbol} venceu!"),
                                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: () {
                    _controller.reset();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf1731c),
                      foregroundColor: Colors.white),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Voltar para menu"),
                  ),
                ),
                                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: () {
                    _controller.reset();
                    Navigator.pushReplacementNamed(context, "/menu");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf1731c),
                      foregroundColor: Colors.white),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Resetar"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
       return Dialog(
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            child: Column(
              children: [
                Text("Empate"),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    _controller.reset();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf1731c),
                      foregroundColor: Colors.white),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Voltar para menu"),
                  ),
                ),
                                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, "/menu");
                    _controller.reset();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf1731c),
                      foregroundColor: Colors.white),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("Resetar"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF595959),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/menu");
                },
                icon: Icon(Icons.arrow_back))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showQuestionDialog(index);
                        },
                        child: Container(
                          color: _controller.tiles[index].color,
                          child: Center(
                            child: Text(
                              _controller.tiles[index].symbol,
                              style: const TextStyle(
                                  fontSize: 72, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _controller.reset();
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf1731c),
                    foregroundColor: Colors.white),
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Resetar"),
                ),
              ),
            ),
          ],
        ));
  }
}
