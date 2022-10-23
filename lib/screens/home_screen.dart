import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;

  List<String> xOrO = ['', '', '', '', '', '', '', '', ''];

  int filedBox = 0;

  int playerX = 0;
  int playerO = 0;

  bool gameHasResult = false;

  String resultTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('TicTacToe'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              clearGame();
              setState(() {
                playerO = 0;
                playerX = 0;
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          getScorBoard(),
          SizedBox(
            height: 4,
          ),
          getResultButton(),
          SizedBox(
            height: 8,
          ),
          getgridView(),
          getTurn(),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            resultTitle = '';
            clearGame();
          });
        },
        child: Text(
          resultTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getTurn() {
    return SafeArea(
      child: Text(
        isTurnO ? 'Turn O' : 'Turn X',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getgridView() {
    return Expanded(
      child: GridView.builder(
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            onTap: () {
              if (!gameHasResult) {
                onClick(index);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  xOrO[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: xOrO[index] == 'X' ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onClick(int index) {
    setState(() {
      if (xOrO[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrO[index] = 'O';
        filedBox++;
      } else {
        xOrO[index] = 'X';
        filedBox++;
      }
      isTurnO = !isTurnO;

      checkWinner();
    });
  }

  void checkWinner() {
    ////Line
    if (xOrO[0] == xOrO[1] && xOrO[0] == xOrO[2] && xOrO[0] != '') {
      print('winner is ' + xOrO[0]);
      setResult(xOrO[0], 'Winner is ' + xOrO[0]);
      return;
    }
    if (xOrO[3] == xOrO[4] && xOrO[3] == xOrO[5] && xOrO[3] != '') {
      print('winner is ' + xOrO[3]);
      setResult(xOrO[3], 'Winner is ' + xOrO[3]);
      return;
    }
    if (xOrO[6] == xOrO[7] && xOrO[6] == xOrO[8] && xOrO[6] != '') {
      print('winner is ' + xOrO[6]);
      setResult(xOrO[6], 'Winner is ' + xOrO[6]);
      return;
    }
    /////Column
    if (xOrO[0] == xOrO[3] && xOrO[0] == xOrO[6] && xOrO[0] != '') {
      print('winner is ' + xOrO[0]);
      setResult(xOrO[0], 'Winner is ' + xOrO[0]);
      return;
    }
    if (xOrO[1] == xOrO[4] && xOrO[1] == xOrO[7] && xOrO[1] != '') {
      print('winner is ' + xOrO[1]);
      setResult(xOrO[1], 'Winner is ' + xOrO[1]);
      return;
    }
    if (xOrO[2] == xOrO[5] && xOrO[2] == xOrO[8] && xOrO[2] != '') {
      print('winner is ' + xOrO[2]);
      setResult(xOrO[2], 'Winner is ' + xOrO[2]);
      return;
    }
    //  X
    if (xOrO[0] == xOrO[4] && xOrO[0] == xOrO[8] && xOrO[0] != '') {
      print('winner is ' + xOrO[0]);
      setResult(xOrO[0], 'Winner is ' + xOrO[0]);
      return;
    }
    if (xOrO[2] == xOrO[4] && xOrO[2] == xOrO[6] && xOrO[2] != '') {
      print('winner is ' + xOrO[2]);
      setResult(xOrO[2], 'Winner is ' + xOrO[2]);
      return;
    }
    if (filedBox == 9) {
      print('game is equal');
      setResult('', 'Drow');
      return;
    }
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrO.length; i++) {
        xOrO[i] = '';
      }
      filedBox = 0;
    });
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      if (winner == 'O') {
        playerO++;
      }
      if (winner == 'X') {
        playerX++;
      }
      if (winner == '') {
        playerO++;
        playerX++;
      }
      resultTitle = title + ' - play again!';
    });
  }

  Widget getScorBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'player O',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$playerO',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'player X',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$playerX',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
