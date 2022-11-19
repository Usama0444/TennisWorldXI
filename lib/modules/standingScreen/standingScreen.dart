import 'package:TennixWorldXI/models/matches_short_info.dart';
import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/drawer/drawer.dart';
import 'package:TennixWorldXI/modules/home/homeScreen.dart';
import 'package:TennixWorldXI/modules/result/standingResult.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'package:TennixWorldXI/validator/validator.dart';

import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';

class StandingScree extends StatefulWidget {
  final void Function()? menuCallBack;

  const StandingScree({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _StandingScreeState createState() => _StandingScreeState();
}

class _StandingScreeState extends State<StandingScree> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyF = new GlobalKey<RefreshIndicatorState>();

  List<MatchShortInfo> _upComingMatches = <MatchShortInfo>[];
  List<MatchShortInfo> _liveMatches = <MatchShortInfo>[];
  List<MatchShortInfo> _completedMatches = <MatchShortInfo>[];
  bool isDataFetched = false;
  late TabController _tabController;
  bool isCallingApi = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _getMatchesList();
    _tabController.addListener(() {
      if (!isDataFetched && !isCallingApi) {
        _getMatchesList();
      }
    });
    updateData();
  }

  updateData() async {
    userData = (await MySharedPreferences().getUserData());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              drawer: AppDrawer(
                mySettingClick: () {},
                referralClick: () {},
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                title: Text(
                  'Standings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    // Tab(
                    //   icon: Text(
                    //     "Upcoming",
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    Tab(
                      icon: Text(
                        "Live",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Completed",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    // isDataFetched
                    //     ? Fixtures(upComingMatches: _upComingMatches,)
                    //     : Center(child: CircularProgressIndicator()),
                    isDataFetched
                        ? Live(
                            liverMatches: _liveMatches,
                          )
                        : Center(child: CircularProgressIndicator()),
                    isDataFetched
                        ? Results(
                            completedMatches: _completedMatches,
                          )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UserData? userData;

  Widget drawerButton() {
    return InkWell(
      // onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 14,
            child: AvatarImage(
              imageUrl: AppConstant.appIcon,
              isCircle: true,
              radius: 28,
              sizeValue: 28,
              isAssets: false,
            ),
          ),
          Icon(Icons.sort, color: AllCoustomTheme.getReBlackAndWhiteThemeColors())
        ],
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Standings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AllCoustomTheme.getThemeData().backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }

  Future<void> _getMatchesList() async {
    isCallingApi = true;
    API_STRUCTURE apiObject = API_STRUCTURE(
      context: context,
      apiName: ApiConstant.standingMatches,
      apiRequestMethod: API_REQUEST_METHOD.GET,
      isWantSuccessMessage: false,
    );
    Map<dynamic, dynamic> apiResponse = await apiObject.requestAPI(isShowLoading: false);
    if (apiResponse.containsKey(API_RESPONSE.SUCCESS)) {
      Map<String, dynamic> _result = apiResponse[API_RESPONSE.SUCCESS]['data']['result'];
      for (var data in _result['upcomingMatches']) {
        _upComingMatches.add(MatchShortInfo(
          country1ShortName: '',
          country2ShortName: '',
          id: data['id'],
          title: data['title'],
          country1Name: data['team_1_title'],
          country2Name: data['team_2_title'],
          time: data['match_date_time'],
          country1Flag: 'assets/19.png',
          country2Flag: 'assets/25.png',
        ));
      }
      for (var data in _result['liveMatches']) {
        _liveMatches.add(MatchShortInfo(
          id: data['id'],
          title: data['title'],
          country1Name: data['team_1_title'],
          country2Name: data['team_2_title'],
          time: 'Live',
          country1Flag: 'assets/19.png',
          country2Flag: 'assets/25.png',
          country1ShortName: '',
          country2ShortName: '',
        ));
      }
      for (var data in _result['completedMatches']) {
        _completedMatches.add(MatchShortInfo(
          country1ShortName: '',
          country2ShortName: '',
          id: data['id'],
          title: data['title'],
          country1Name: data['team_1_title'],
          country2Name: data['team_2_title'],
          time: 'Completed',
          country1Flag: 'assets/19.png',
          country2Flag: 'assets/25.png',
        ));
      }
      isDataFetched = true;
      setState(() {});
    }
    isCallingApi = false;
  }
}

class Fixtures extends StatefulWidget {
  List<MatchShortInfo> upComingMatches;
  Fixtures({required this.upComingMatches});
  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 4),
      physics: BouncingScrollPhysics(),
      itemCount: widget.upComingMatches.length,
      itemBuilder: (context, index) {
        MatchShortInfo _matchInfo = widget.upComingMatches[index];
        return MatchesList(
          title: _matchInfo.title,
          country1Name: _matchInfo.country1Name,
          country2Name: _matchInfo.country2Name,
          country1Flag: _matchInfo.country1Flag,
          country2Flag: _matchInfo.country2Flag,
          price: _matchInfo.price,
          time: _matchInfo.time,
        );
      },
    );
  }
}

class Live extends StatefulWidget {
  List<MatchShortInfo> liverMatches;
  Live({required this.liverMatches});
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getTextThemeColors(),
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/cup.png',
            width: 50,
            height: 50,
          ),
        ),
        Text(
          "You haven't joined any contests that are Live\nJoin contests for any of the upcoming matches",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1.3,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            physics: BouncingScrollPhysics(),
            itemCount: widget.liverMatches.length,
            itemBuilder: (context, index) {
              MatchShortInfo _matchInfo = widget.liverMatches[index];
              return MatchesList(
                title: _matchInfo.title,
                country1Name: _matchInfo.country1Name,
                country2Name: _matchInfo.country2Name,
                country1Flag: _matchInfo.country1Flag,
                country2Flag: _matchInfo.country2Flag,
                price: _matchInfo.price,
                time: _matchInfo.time,
              );
            },
          ),
        )
      ],
    );
  }
}

class Results extends StatefulWidget {
  List<MatchShortInfo> completedMatches;
  Results({required this.completedMatches});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            physics: BouncingScrollPhysics(),
            itemCount: widget.completedMatches.length,
            itemBuilder: (context, index) {
              MatchShortInfo _matchInfo = widget.completedMatches[index];
              return MatchesList(
                title: _matchInfo.title,
                country1Name: _matchInfo.country1Name,
                country2Name: _matchInfo.country2Name,
                country1Flag: _matchInfo.country1Flag,
                country2Flag: _matchInfo.country2Flag,
                price: _matchInfo.price,
                time: _matchInfo.time,
              );
            },
          ),
        )
      ],
    );
  }
}

class MatchesList extends StatefulWidget {
  final String? title;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchesList({
    Key? key,
    this.title,
    this.country1Name,
    this.country2Name,
    this.time,
    this.price,
    this.country1Flag,
    this.country2Flag,
  }) : super(key: key);

  @override
  _MatchesListState createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => StandingResult(
        //       country1Flag: widget.country1Flag,
        //       country2Flag: widget.country2Flag,
        //       country1Name: widget.country1Name,
        //       country2Name: widget.country2Name,
        //       price: widget.price,
        //       time: widget.time,
        //       titel: widget.titel,
        //     ),
        //   ),
        // );
      },
      onLongPress: () {
        // showModalBottomSheet<void>(
        //   context: context,
        //   builder: (
        //     BuildContext context,
        //   ) =>
        //       UnderGroundDrawer(
        //     country1Flag: widget.country1Flag,
        //     country2Flag: widget.country2Flag,
        //     country1Name: widget.country1Name,
        //     country2Name: widget.country2Name,
        //     price: widget.price,
        //     time: widget.time,
        //     titel: widget.titel,
        //   ),
        // );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Image.asset(
                        AppConstant.lineups,
                        height: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.notification_add_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.country1Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        widget.country2Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country1Flag!),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.time!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country2Flag!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllCoustomTheme.isLight ? HexColor("#f5f5f5") : Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        child: Text(
                          "Mega",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: AppConstant.SIZE_TITLE12,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.price!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE12,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      AppConstant.tv,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
