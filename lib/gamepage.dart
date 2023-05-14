
import 'package:flutter/material.dart';

class gamePage extends StatefulWidget {
  const gamePage({Key? key}) : super(key: key);

  @override
  State<gamePage> createState() => _gamePageState();
}

class _gamePageState extends State<gamePage> {
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];
  bool ohTurn = true; // O is firstPlayer
  int ohScore = 0;
  int exScore = 0;
  int filledBox = 0;
  // void tapped(int index){
  //   displayExOh[index] = 'o';
  // }
  void tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBox+=1;
      } else if (!ohTurn && displayExOh[index] == ''){
        displayExOh[index] = 'X';
        filledBox+=1;
      }
      ohTurn = !ohTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    // checks 1 row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      showWinDialog(displayExOh[0]);
    }
    // checks 2 row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      showWinDialog(displayExOh[3]);
    }
    // checks 3 row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      showWinDialog(displayExOh[6]);
    }
    // checks 1 coloumn
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      showWinDialog(displayExOh[0]);
    }
    // checks 2 coloumn
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      showWinDialog(displayExOh[1]);
    }
    // checks 3 coloumn
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      showWinDialog(displayExOh[2]);
    }
    // checks diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      showWinDialog(displayExOh[6]);
    }
    // checks diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      showWinDialog(displayExOh[0]);
    }
    else if(filledBox == 9){
      showDrawDialog();
    }
  }

  void showWinDialog(String winner){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Winner is ' + winner),
            actions: [
              TextButton(
                child:Text('PLAY agian'),
                onPressed: (){
                  clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
    );
    if (winner == 'O'){
      ohScore=ohScore+1;
    }
    else if(winner == 'X'){
      exScore=exScore+1;
    }
  }
  void clear(){
    setState(() {
      for(int i=0;i<9;i++){
        displayExOh[i] = '';
      }
      filledBox=0;
    });
  }
  void showDrawDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Draw'),
          actions: [
            TextButton(
              child:Text('PLAY agian'),
              onPressed: (){
                clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player O',style: TextStyle(fontSize: 20),),
                        Text(ohScore.toString(),style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X',style: TextStyle(fontSize: 20),),
                        Text(exScore.toString(),style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Tic-Tac-Toe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
