import 'dart:convert';

import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:TennixWorldXI/models/MyModels/team_model.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/contest_list_model.dart';

class TeamController extends GetxController {
  var match_id;
  var team1Name, team2Name;
  var team1Flag, team2Flag;
  var team1ShortName, team2ShortName;
  List<bool> select = [];
  List<PlayerModel> wicketKiperList = [];
  List<PlayerModel> batterList = [];
  List<PlayerModel> allRounderList = [];
  List<PlayerModel> bowlerList = [];
  List<PlayerModel> allPlayersData = [];
  List<PlayerModel> selectedPlayers = [];
  int captainID = 0;
  int voiceCaptain = 0;
  List<bool> isCaptainSelect = [];
  List<bool> isVoiceCaptainSelect = [];
  List<String> teamPlayerIds = [];
  List<PlayerModel> select_wicketKiperList = [];
  List<PlayerModel> select_batterList = [];
  List<PlayerModel> select_allRounderList = [];
  List<PlayerModel> select_bowlerList = [];
  List<PlayerModel> teamASelecttedPlayer = [];
  List<PlayerModel> teamBSelecttedPlayer = [];
  List<bool> selectteamForContest = [];
  var opacityVal = [];
  int? contest_id;
  int? team_id;
  int? group_val;
  List<int> radioBtnVal = [];
  List<ContestListModel> contestListModel = [];
  var team_credits = 0.0;
//////User teams variables
  List<TeamModel> userTeams = [];

  getPlayersData() async {
    clearAllListData();
    var response = await Dio().get('https://dream11.tennisworldxi.com/api/players/$match_id');
    List data = response.data['data']['result']['allplayers'];
    var teamNames = response.data['data']['result']['match'];
    for (int i = 0; i < data.length; i++) {
      select.add(false);
      opacityVal.add(1.0);
      isCaptainSelect.add(false);
      isVoiceCaptainSelect.add(false);
      allPlayersData.add(PlayerModel(
        match_id: data[i]['match_id'],
        player_credit: data[i]['credit_point'],
        player_id: data[i]['player_id'],
        player_name: data[i]['player_name'],
        player_pic: data[i]['player_image'],
        player_role: data[i]['player_role'] == '8'
            ? 'wk'
            : data[i]['player_role'] == '2'
                ? 'bowl'
                : data[i]['player_role'] == '4' || data[i]['player_role'] == '5' || data[i]['player_role'] == '6'
                    ? 'bat'
                    : 'all',
        player_team_name: data[i]['player_team_name'] == '1' ? teamNames['team_1_title'] : teamNames['team_2_title'],
      ));
    }

    for (int i = 0; i < allPlayersData.length; i++) {
      if (allPlayersData[i].player_role == 'wk') {
        wicketKiperList.add(allPlayersData[i]);
      } else if (allPlayersData[i].player_role == 'bat') {
        batterList.add(allPlayersData[i]);
      } else if (allPlayersData[i].player_role == 'bowl') {
        bowlerList.add(allPlayersData[i]);
      } else {
        allRounderList.add(allPlayersData[i]);
      }
    }
    update();
  }

  clearAllListData() {
    allPlayersData.clear();
    select.clear();
    team_credits = 0.0;
    teamPlayerIds.clear();
    wicketKiperList.clear();
    allRounderList.clear();
    batterList.clear();
    bowlerList.clear();
    selectedPlayers.clear();
    isCaptainSelect.clear();
    isVoiceCaptainSelect.clear();
    select_allRounderList.clear();
    select_wicketKiperList.clear();
    select_batterList.clear();
    select_bowlerList.clear();
    teamASelecttedPlayer.clear();
    teamBSelecttedPlayer.clear();
    opacityVal.clear();
  }

  int getSelectedPlayerCount() {
    if (selectedPlayers.length < 11) {
      return selectedPlayers.length;
    } else {
      return 11;
    }
  }

  bool checkTeamValidation() {
    if (wicketKiperList.length < 1 || batterList.length < 3 || allRounderList.length < 1 || bowlerList.length < 3) {
      return false;
    } else {
      return true;
    }
  }

  createTeam() async {
    teamPlayerIds.clear();
    for (var player in wicketKiperList) {
      teamPlayerIds.add(player.player_id.toString());
    }
    for (var player in allRounderList) {
      teamPlayerIds.add(player.player_id.toString());
    }
    for (var player in batterList) {
      teamPlayerIds.add(player.player_id.toString());
    }
    for (var player in bowlerList) {
      teamPlayerIds.add(player.player_id.toString());
    }
    update();
    try {
      var formData = {
        'team1': 1,
        'team2': 2,
        'captainId': captainID,
        'allRounder': allRounderList.length,
        'batsman': batterList.length,
        'bowler': bowlerList.length,
        'wKeeper': wicketKiperList.length,
        'teamPlayers': teamPlayerIds,
        'vicecaptainId': voiceCaptain,
        'matchId': match_id,
      };
      print(json.encode(teamPlayerIds));
      var response = await Dio().post(
        'https://dream11.tennisworldxi.com/api/team/user-create-team',
        queryParameters: formData,
      );
      if (response.statusCode == 200) {
        CustomToast.showToast(message: 'Team Added');
      } else {
        CustomToast.showToast(message: 'Something went wrong');
      }
    } catch (e) {
      print(e);
      CustomToast.showToast(message: 'Something went wrong');
    }
  }

  arrangementOfSelectedPlayers() async {
    select_allRounderList.clear();
    select_wicketKiperList.clear();
    select_batterList.clear();
    select_bowlerList.clear();
    teamASelecttedPlayer.clear();
    teamBSelecttedPlayer.clear();
    team_credits = 0.0;
    for (int i = 0; i < selectedPlayers.length; i++) {
      if (selectedPlayers[i].player_role == 'wk') {
        select_wicketKiperList.add(selectedPlayers[i]);
      } else if (selectedPlayers[i].player_role == 'bat') {
        select_batterList.add(selectedPlayers[i]);
      } else if (selectedPlayers[i].player_role == 'bowl') {
        select_bowlerList.add(selectedPlayers[i]);
      } else {
        select_allRounderList.add(selectedPlayers[i]);
      }
      if (selectedPlayers[i].player_team_name == team1Name) {
        teamASelecttedPlayer.add(selectedPlayers[i]);
      } else if (selectedPlayers[i].player_team_name == team2Name) {
        teamBSelecttedPlayer.add(selectedPlayers[i]);
      }
      team_credits += selectedPlayers[i].player_credit;
      update();
    }
    print('team Credit : $team_credits');
    update();
  }

  ///User teams Methods

  getAllUserTeams() async {
    try {
      userTeams.clear();
      radioBtnVal.clear();
      selectteamForContest.clear();
      var resp = await Dio().get('https://dream11.tennisworldxi.com/api/team/user-team/$match_id');
      var data = resp.data['data']['result']['userTeams'];
      var captainName = resp.data['data']['result']['captainName'];
      var cap_pic = resp.data['data']['result']['captainImage'];
      var vice_captainName = resp.data['data']['result']['vice_captainName'];
      var vice_cap_pic = resp.data['data']['result']['vice_captainImage'];
      for (int i = 0; i < data.length; i++) {
        userTeams.add(TeamModel(
          match_id: match_id,
          bowlers: data[i]['bowler'],
          team_id: data[i]['id'],
          team_no: data[i]['team_no'],
          wkeeper: data[i]['w_keeper'],
          batters: data[i]['batsman'],
          allRounders: data[i]['all_rounder'],
          vice_captain_pic: vice_cap_pic[i],
          captain_name: captainName[i],
          captain_pic: cap_pic[i],
          vice_captain_name: vice_captainName[i],
        ));
        radioBtnVal.add(i);
      }
      update();
    } catch (e) {
      print('Something went wrong in team $e');
      CustomToast.showToast(message: 'Something went wrong!');
    }
  }

  //User Join Contest
  joinUserContest() async {
    try {
      var formData = {
        'match_id': match_id,
        'contest_id': contest_id,
        'team_id': team_id,
      };

      var response = await Dio().post('https://dream11.tennisworldxi.com/api/contest/userjoin-contest', queryParameters: formData);
      if (response.statusCode == 200) {
        CustomToast.showToast(message: response.data['data']);
      }
    } catch (e) {
      print(e.toString());
      CustomToast.showToast(message: 'something went wrong');
    }
  }

  getDataJoinContest() async {
    try {
      print('get data');
      var formData = {
        'match_id': 14,
        'contest_id': 1,
      };
      var response = await Dio().post('https://dream11.tennisworldxi.com/api/contest/leaderboard', queryParameters: formData);
      for (var data in response.data['contest']) {
        contestListModel.add(ContestListModel(
          id: data['id'] ?? 0,
          title: data['title'] ?? '',
          prizePool: data['winning_prize'].toString(),
          entryFee: data['entrance_amount'].toString(),
          noOfWinner: data['no_of_winners'].toString(),
          totalSpot: data['team_length'].toString(),
          currentSpot: '2',
        ));
      }
      update();

      if (response.statusCode == 200) {
        CustomToast.showToast(message: 'Fetch Contest');
      } else {
        CustomToast.showToast(message: 'Not Fetch Contest');
      }
    } catch (e) {}
  }
}
