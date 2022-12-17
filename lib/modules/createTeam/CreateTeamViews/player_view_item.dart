import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/constants.dart';
import '../../../constant/themes.dart';

class PlayerViewItem extends StatefulWidget {
  var img, name, teamName, role, credit;
  PlayerViewItem({
    Key? key,
    required this.credit,
    required this.img,
    required this.name,
    required this.role,
    required this.teamName,
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
          child: InkWell(
            onTap: () {
              print('preing');
              teamContoller.getTeamData();
            },
            borderRadius: new BorderRadius.circular(0.0),
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
                                'https://dream11.tennisworldxi.com/storage/app/${widget.img}',
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
                                  '${widget.name}',
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
                                  '${widget.teamName} - ${widget.role}',
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
                          '${widget.credit}',
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
                      Container(
                        padding: EdgeInsets.only(right: 8),
                        child: Center(
                          child: Container(
                            width: 40,
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
