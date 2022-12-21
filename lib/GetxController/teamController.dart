import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
  var match_id;
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
  var teamPlayerIds = [];
  getTeamData() async {
    clearAllListData();
    var response = await Dio().get('https://dream11.tennisworldxi.com/api/players/$match_id');
    List data = response.data['data']['result']['allplayers'];
    var teamNames = response.data['data']['result']['match'];
    for (int i = 0; i < data.length; i++) {
      select.add(false);
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
    teamPlayerIds.clear();
    wicketKiperList.clear();
    allRounderList.clear();
    batterList.clear();
    bowlerList.clear();
    selectedPlayers.clear();
    isCaptainSelect.clear();
    isVoiceCaptainSelect.clear();
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
    print('create');
    for (var player in wicketKiperList) {
      teamPlayerIds.add(player.player_id);
    }
    for (var player in allRounderList) {
      teamPlayerIds.add(player.player_id);
    }
    for (var player in batterList) {
      teamPlayerIds.add(player.player_id);
    }
    for (var player in bowlerList) {
      teamPlayerIds.add(player.player_id);
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
      CustomToast.showToast(message: 'Something went wrong');
    }
  }
}
