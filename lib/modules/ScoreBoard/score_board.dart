import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constant/themes.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  //batters
  int batter1Run = 0;
  int batter2Run = 0;
  int batter1Ball = 0;
  int batter2Ball = 0;
  int batter1Fours = 0;
  int batter2Fours = 0;
  int batter1Six = 0;
  int batter2Six = 0;
  //bowler
  int over = 0;
  int bowlerBalls = 0;
  int bowlerRun = 0;
  int overM = 0;
  int bowlerWicket = 0;
  int bowlerNoBall = 0;
  //team
  int teamScore = 0;
  int teamLossWicket = 0;
  bool strikPlayer1 = true;
  bool strikPlayer2 = false;
  //extra
  int extraRuns = 0;
  //for undo purpose
  int undoBatter1Run = 0;
  int undoBatter2Run = 0;
  int undoBatter1Ball = 0;
  int undoBatter2Ball = 0;
  int undoBatter1Fours = 0;
  int undoBatter2Fours = 0;
  int undoBatter1Six = 0;
  int undoBatter2Six = 0;
  int undoOver = 0;
  int undoBowlerBalls = 0;
  int undoBowlerRun = 0;
  int undoOverM = 0;
  int undoBowlerWicket = 0;
  int undoBowlerNoBall = 0;
  int undoTeamScore = 0;
  int undoTeamLossWicket = 0;
  int undoExtraRuns = 0;
  bool undoStrickPlayer1 = false;
  bool undoStrickPlayer2 = false;
  //check user last state
  int lastState = 1; //1 for player1

  void pressNumberButtonByUser(int btnValue) {
    int n = btnValue;
    if (bowlerBalls < 6) {
      undoBowlerBalls = bowlerBalls;
      bowlerBalls++;
      undoOver = over;
    } else if (bowlerBalls == 6) {
      over++;
      undoBowlerBalls = bowlerBalls;
      bowlerBalls = 0;
    }
    if (strikPlayer1) {
      undoBatter1Ball = batter1Ball;
      undoBatter1Fours = batter1Fours;
      undoBatter1Run = batter1Run;
      undoBatter1Six = batter1Six;
      undoTeamLossWicket = teamLossWicket;
      undoTeamScore = teamScore;
      undoBowlerRun = bowlerRun;
      ////
      batter1Ball++;
      batter1Run += n;
      teamScore += n;
      bowlerRun += n;

      lastState = 1;

      strikPlayer2 = false;
      strikPlayer1 = true;
      if (n == 0) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = true;
        strikPlayer2 = false;
        if (bowlerBalls == 5 && bowlerRun == 0) {
          overM++;
        }
      } else if (n == 1) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 3) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 4) {
        batter1Fours++;
      } else if (n == 5) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 6) {
        batter1Six++;
      }
    } else {
      undoBatter2Ball = batter2Ball;
      undoBatter2Fours = batter2Fours;
      undoBatter2Run = batter2Run;
      undoBatter2Six = batter2Six;
      undoTeamLossWicket = teamLossWicket;
      undoTeamScore = teamScore;
      undoBowlerRun = bowlerRun;

      ///
      lastState = 2;

      batter2Ball++;
      batter2Run += n;
      teamScore += n;
      bowlerRun += n;

      if (n == 0) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = true;
        strikPlayer2 = false;
        if (bowlerBalls == 6 && bowlerBalls == 0) {
          overM++;
        }
      } else if (n == 1) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 3) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 4) {
        batter2Fours++;
      } else if (n == 5) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 6) {
        batter2Six++;
      }
    }

    setState(() {});
  }

  void pressNonNumberBtns(var val) {
    if (val == 'Wide') {
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;
      //
      extraRuns++;
      bowlerRun++;
      teamScore++;
    } else if (val == 'No Ball') {
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;
      undoBowlerNoBall = bowlerNoBall;

      ///
      extraRuns++;
      bowlerRun++;
      teamScore++;
      bowlerNoBall++;
    } else if (val == 'Bye') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;

      ///
      extraRuns++;
      bowlerRun++;
      teamScore++;
    } else if (val == 'Led Bye') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }

      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;

      ///
      extraRuns += 2;
      bowlerRun += 2;
      teamScore += 2;
    } else if (val == 'Wicket') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }
      undoBowlerWicket = bowlerWicket;
      undoTeamLossWicket = teamLossWicket;

      ///
      bowlerWicket++;
      teamLossWicket++;
    } else {
      if (lastState == 1) {
        batter1Ball = undoBatter1Ball;
        batter1Run = undoBatter1Run;
        batter1Fours = undoBatter1Fours;
        batter1Six = undoBatter1Six;
      } else {
        batter2Ball = undoBatter2Ball;
        batter2Run = undoBatter2Run;
        batter2Six = undoBatter2Six;
        batter2Fours = undoBatter2Fours;
      }
      //
      print('undo over $undoOver');
      teamScore = undoTeamScore;
      teamLossWicket = undoTeamLossWicket;
      bowlerNoBall = undoBowlerNoBall;
      bowlerBalls = undoBowlerBalls;
      bowlerRun = undoBowlerRun;
      extraRuns = undoExtraRuns;
      over = undoOver;
      bowlerWicket = undoBowlerWicket;
      strikPlayer1 = undoStrickPlayer1;
      strikPlayer2 = undoStrickPlayer2;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: AppBar().preferredSize.height,
                color: AllCoustomTheme.getThemeData().primaryColor,
                child: Row(
                  children: <Widget>[
                    Material(
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: AppBar().preferredSize.height,
                          height: AppBar().preferredSize.height,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'ScoreSheet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/13.png',
                                width: 50,
                                height: 30,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Pakistan',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '8/220',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/17.png',
                                width: 50,
                                height: 30,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'India',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$teamLossWicket/$teamScore',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 430,
                child: ListView(
                  children: [
                    Container(
                      color: Colors.grey[400],
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Colors.blue,
                                      width: 4,
                                    ),
                                  )),
                                  child: Center(
                                    child: Text(
                                      '2nd Inning',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  )),
                                  child: Center(
                                    child: Text(
                                      'Ball-by-Ball',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[400],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Batters'.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'R',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'B',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '4s',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '6s',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(right: 30),
                                  decoration: strikPlayer1
                                      ? BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                      : BoxDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'S Adam',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        strikPlayer1 ? Icon(Icons.subdirectory_arrow_right_outlined) : Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter1Run',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter1Ball',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter1Fours',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter1Six',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(right: 30),
                                  decoration: strikPlayer2
                                      ? BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                      : BoxDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Anil Gupta',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        strikPlayer2 ? Icon(Icons.subdirectory_arrow_right_outlined) : Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter2Run',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter2Ball',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter2Fours',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$batter2Six',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   width: 2,
                                    //   color: Colors.black.withOpacity(0.5),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Partnership'.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        // Icon(Icons.subdirectory_arrow_right_outlined),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${batter1Run + batter2Run}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${batter1Ball + batter2Ball}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${batter1Fours + batter2Fours}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${batter1Six + batter2Six}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[400],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Bowler'.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'O',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'R',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'M',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'W',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'N',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(right: 30, left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            'S Adam',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$over.$bowlerBalls',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$bowlerRun',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$overM',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$bowlerWicket',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '$bowlerNoBall',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[400],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Extra Runs'.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 55,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            '$extraRuns',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(0);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: ClipOval(
                                      child: Image.asset(
                                'assets/dot.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(1);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '1',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(2);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '2',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(3);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '3',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('undo');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.green, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(4);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '4',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(6);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '6',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNumberButtonByUser(5);
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '5+',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                'End\nOver'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 60,
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('Wide');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 36, 35, 35), width: 3),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 36, 35, 35),
                              ),
                              child: Center(
                                  child: Text(
                                'wide'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('No Ball');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 36, 35, 35), width: 3),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 36, 35, 35),
                              ),
                              child: Center(
                                  child: Text(
                                'No\nBall'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('Bye');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 36, 35, 35), width: 3),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 36, 35, 35),
                              ),
                              child: Center(
                                  child: Text(
                                'bye'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('Led Bye');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 36, 35, 35), width: 3),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 36, 35, 35),
                              ),
                              child: Center(
                                  child: Text(
                                'Led\nbye'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              pressNonNumberBtns('Wicket');
                            },
                            child: Container(
                              width: 60,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.red, width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                'Wicket'.toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
