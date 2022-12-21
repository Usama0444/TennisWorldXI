import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/constants.dart';
import '../../../constant/themes.dart';

class PlayerViewItem extends StatefulWidget {
  PlayerModel player;
  int playerIndex;
  PlayerViewItem({
    Key? key,
    required this.player,
    required this.playerIndex,
  }) : super(key: key);
  @override
  _PlayerViewItemState createState() => _PlayerViewItemState();
}

class _PlayerViewItemState extends State<PlayerViewItem> {
  var teamContoller = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0,
      child: Container(
        height: 60,
        color: AllCoustomTheme.getThemeData().backgroundColor,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Container(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                            child: Image.network(
                              'https://dream11.tennisworldxi.com/storage/app/${widget.player.player_pic}',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '${widget.player.player_name}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                  fontSize: AppConstant.SIZE_TITLE12,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                '${widget.player.player_team_name} - ${widget.player.player_role}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: AppConstant.SIZE_TITLE10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Center(
                          // child: Text(
                          //   '${widget.credit}',
                          //   style: TextStyle(
                          //     fontFamily: 'Poppins',
                          //     color: AllCoustomTheme.getTextThemeColors(),
                          //     fontSize: AppConstant.SIZE_TITLE12,
                          //   ),
                          // ),
                          ),
                    ),
                    Container(
                      width: 40,
                      child: Text(
                        '${widget.player.player_credit}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontSize: AppConstant.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      width: 0.4,
                      child: Container(
                        color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                      ),
                    ),
                    GetBuilder<TeamController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.select[widget.playerIndex]) {
                            controller.select[widget.playerIndex] = false;
                            for (int i = 0; i < controller.selectedPlayers.length; i++) {
                              if (controller.selectedPlayers[i] == widget.player) {
                                controller.selectedPlayers.removeAt(i);
                                break;
                              }
                            }
                            controller.update();
                          } else {
                            int minWk = 1, maxWk = 1;
                            int minBt = 1, maxBt = 5;
                            int minAl = 1, maxAl = 3;
                            int minBo = 1, maxBo = 5;

                            if (controller.selectedPlayers.length < 11) {
                              if (widget.player.player_role == 'wk') {
                                for (var v in controller.selectedPlayers) {
                                  if (v.player_role == 'wk') {
                                    minWk++;
                                  }
                                }
                                if (maxWk >= minWk) {
                                  controller.select[widget.playerIndex] = true;
                                  controller.selectedPlayers.add(widget.player);
                                }
                              } else if (widget.player.player_role == 'bat') {
                                for (var v in controller.selectedPlayers) {
                                  if (v.player_role == 'bat') {
                                    minBt++;
                                  }
                                }
                                if (maxBt >= minBt) {
                                  controller.select[widget.playerIndex] = true;
                                  controller.selectedPlayers.add(widget.player);
                                }
                              } else if (widget.player.player_role == 'all') {
                                for (var v in controller.selectedPlayers) {
                                  if (v.player_role == 'all') {
                                    minAl++;
                                  }
                                }
                                if (maxAl >= minAl) {
                                  controller.select[widget.playerIndex] = true;
                                  controller.selectedPlayers.add(widget.player);
                                }
                              } else {
                                for (var v in controller.selectedPlayers) {
                                  if (v.player_role == 'bowl') {
                                    minBo++;
                                  }
                                }
                                if (maxBo >= minBo) {
                                  controller.select[widget.playerIndex] = true;
                                  controller.selectedPlayers.add(widget.player);
                                }
                              }
                            }
                          }
                          controller.update();
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Center(
                            child: Container(
                              width: 40,
                              child: Icon(
                                !controller.select[widget.playerIndex] ? Icons.add : Icons.close,
                                color: !controller.select[widget.playerIndex] ? Theme.of(context).primaryColor : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
