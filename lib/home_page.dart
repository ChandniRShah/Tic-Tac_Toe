import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterapp/custom_dailog.dart';
import 'package:flutterapp/game_button.dart';

  class HomePage extends StatefulWidget{
    @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List<GameButton> buttonsList;
var player1;
var player2;
var activePlayer;

@override 
  void initState() {
    // TODO: implement initState
    super.initState(); 
    buttonsList = doInit();

  }
  
 List<GameButton> doInit(){

   player1 = new List();
   player2 = new List();
   activePlayer = 1;

   var gameButtons = <GameButton>[

     new GameButton(id:1),
     new GameButton(id:2),
     new GameButton(id:3),
     new GameButton(id:4),
     new GameButton(id:5),
     new GameButton(id:6),
     new GameButton(id:7),
     new GameButton(id:8),
     new GameButton(id:9),
   ];
   return gameButtons;

 }
  
  
void playGame(GameButton gb){
  setState(() {
      if(activePlayer == 1){
        gb.text="S";
        gb.bg= Colors.lightBlue[300];
        activePlayer = 2;
        player1.add(gb.id);
      }else{
        gb.text="C";
        gb.bg= Colors.lime;
        activePlayer = 1;
        player2.add(gb.id);
      }

      gb.enabled = false; 
      int winner = checkWinner();
      if(winner == -1){
        if(buttonsList.every((p)=>p.text !="")){
            showDialog(
              context: context,
              builder: (_)=> new CustomDialog("Game Tied", 
              "Press the Reset button to play again", resetGame));
        }else{
          activePlayer == 2?autoPlay():null;
        }
      }
    });

}

void autoPlay(){
  var emptyCells = new List();
  var list = new List.generate(9, (i)=>i+1);
  for (var cellID in list) {
    if(!(player1.contains(cellID) || player2.contains(cellID))){
      emptyCells.add(cellID);
    }
  }

  var r = new Random(); 
  var randIndex = r.nextInt(emptyCells.length-1);
  var CellID= emptyCells[randIndex];
  int i = buttonsList.indexWhere((p)=> p.id == CellID);  
  playGame(buttonsList[i]);
}

   int checkWinner(){
   var winner= -1;

   // row 1
   if(player1.contains(1) && player1.contains(2) && player1.contains(3) ){
     winner= 1;  
   }
      if(player2.contains(1) && player2.contains(2) && player2.contains(3) ){
     winner= 2;  
   }

   //row 2
      if(player1.contains(4) && player1.contains(5) && player1.contains(6) ){
     winner= 1;  
   }

      if(player2.contains(4) && player2.contains(5) && player2.contains(6) ){
     winner= 2;  
   }

   //row 3
    if(player1.contains(7) && player1.contains(8) && player1.contains(9) ){
     winner= 1;  
   }

    if(player2.contains(7) && player2.contains(8) && player2.contains(9) ){
     winner= 2;   
   }


     // col 1
   if(player1.contains(1) && player1.contains(4) && player1.contains(7) ){
     winner= 1;  
   }
      if(player2.contains(1) && player2.contains(4) && player2.contains(7) ){
     winner= 2;  
   }

   //col 2
      if(player1.contains(2) && player1.contains(5) && player1.contains(8) ){
     winner= 1;  
   }

      if(player2.contains(2) && player2.contains(5) && player2.contains(8) ){
     winner= 2;  
   }

   //col 3
    if(player1.contains(3) && player1.contains(6) && player1.contains(9) ){
     winner= 1;  
   }

    if(player2.contains(3) && player2.contains(6) && player2.contains(9) ){
     winner= 2;   
   }

      //diag 1
      if(player1.contains(1) && player1.contains(5) && player1.contains(9) ){
     winner= 1;  
   }

      if(player2.contains(1) && player2.contains(5) && player2.contains(9) ){
     winner= 2;  
   }

   //diag 2
    if(player1.contains(3) && player1.contains(5) && player1.contains(7) ){
     winner= 1;  
   }

    if(player2.contains(3) && player2.contains(6) && player2.contains(7) ){
     winner= 2;   
   }

   if(winner != -1){
     if(winner == 1){ 
        showDialog(
          context: context, 
          builder: (_)=> new CustomDialog("Congratulations:Player 1",
          "Reset the game to start playing again",resetGame));

     }else{
showDialog(
          context: context, 
          builder: (_)=> new CustomDialog("Congratulations:Player 2",
          "Reset the game to start playing again",resetGame));

     }
   }

   return winner;
}

void resetGame(){
  if(Navigator.canPop(context)) Navigator.pop(context);
  setState((){
    buttonsList = doInit();
  });
}
 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Tic Tac Toe (Sayali & Chandni)"),
      ),
    body: new Column  (
      mainAxisAlignment: MainAxisAlignment.start ,
      crossAxisAlignment: CrossAxisAlignment.stretch ,
      children: <Widget>[

        new Expanded(
          child: new GridView.builder(
          padding: const EdgeInsets.all(10.0),
           gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 3,
           childAspectRatio: 1.0,
           crossAxisSpacing: 9.0,
           mainAxisSpacing:  9.0,

           ),
          itemCount: buttonsList.length,
          itemBuilder: (context,i)=>new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new RaisedButton(
              padding:  const EdgeInsets.all(5.0),
              onPressed: buttonsList[i].enabled?()=>playGame(buttonsList[i]):null,
              child: new Text(buttonsList[i].text, style:  new TextStyle(color: Colors.white, fontSize: 30.0), 
              ),
              color: buttonsList[i].bg,
              disabledColor: buttonsList[i].bg,

            ),
          ),
      ),
        ),

         new RaisedButton(
           child: new Text("RESET",  style: new TextStyle(color: Colors.white, fontSize: 30.0 ),
           ),
          color: Colors.lightBlue[300],
          padding: const EdgeInsets.all(20.0),
          onPressed: resetGame,

         )

      ],
        
         
    ),);
  }
}