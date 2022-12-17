import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
  var match_id = 14;
  List<PlayerModel> allPlayersData = [];
  getTeamData() async {
    allPlayersData.clear();
    print('data getting');
    var response = await Dio().get('https://dream11.tennisworldxi.com/api/players/$match_id');
    List data = response.data['data']['result']['allplayers'];
    var teamNames = response.data['data']['result']['match'];
    for (int i = 0; i < data.length; i++) {
      allPlayersData.add(PlayerModel(
        match_id: data[i]['match_id'],
        player_credit: data[i]['credit_point'],
        player_id: data[i]['player_id'],
        player_name: data[i]['player_name'],
        player_pic: data[i]['player_image'],
        player_role: data[i]['player_role'],
        player_team_name: data[i]['player_team_name'] == '1' ? teamNames['team_1_title'] : teamNames['team_2_title'],
      ));
    }
    update();
    // print(allPlayersData.length);
    // print('players Name');
    // for (int i = 0; i < allPlayersData.length; i++) {
    //   print(allPlayersData[i].player_name);
    // }
  }
}
