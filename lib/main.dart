import 'package:TennixWorldXI/TestClass.dart';
import 'package:TennixWorldXI/bloc/bottom_nav_bar_provider.dart';
import 'package:TennixWorldXI/bloc/phoneVerificationBloc.dart';
import 'package:TennixWorldXI/constant/firsttime.dart';
import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/routes.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/modules/CustomImagePicker/camera.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/player_record.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/score_view.dart';
import 'package:TennixWorldXI/modules/createTeam/CreateTeamViews/player_view_item.dart';
import 'package:TennixWorldXI/modules/home/tabScreen.dart';
import 'package:TennixWorldXI/modules/login/loginScreen.dart';
import 'package:TennixWorldXI/modules/login/otpValidationScreen.dart';
import 'package:TennixWorldXI/modules/pymentOptions/WinningScreenTabViews/Contest.dart';
import 'package:TennixWorldXI/modules/splash/SplashScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constant/constants.dart';
import 'modules/ScoreBoard/Player_all_record.dart';

int userId = 2;

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(new MyApp()),
  );
}

class MyApp extends StatefulWidget {
  static setCustomeTheme(BuildContext context, int index, {Color? color}) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setCustomeTheme(index, color: color!);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Utils.phoneVerificationBloc = PhoneVerificationBloc(PhoneVerificationBlocState.initial());
    Utils.phoneVerificationBloc!.onInisialList("91", "phoneNoData");
    FirstTime.getValues();
    super.initState();
  }

  void setCustomeTheme(int index, {Color? color}) {
    if (index == 6) {
      setState(() {
        AllCoustomTheme.isLight = true;
      });
    } else if (index == 7) {
      setState(() {
        AllCoustomTheme.isLight = false;
      });
    }
    setState(() {
      Utils.colorsIndex = index;
      Utils.primaryColorString = color != null ? color : Color(0xFF4FBE9F);
      Utils.secondaryColorString = Utils.primaryColorString;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: AllCoustomTheme.isLight ? Brightness.dark : Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNavProvider(),
        ),
      ],
      child: Container(
        color: Color(0xff081c3f),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.AppName,
          theme: AllCoustomTheme.getThemeData(),
          routes: routes,
          // home: ScoreView(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => new SplashScreen(),
    Routes.LOGIN: (BuildContext context) => new LoginScreen(),
    Routes.TAB: (BuildContext context) => new TabScreen(),
    Routes.OTP: (BuildContext context) => new OtpValidationScreen(),
    Routes.CameraPickerRoute: (BuildContext context) => new CustomImagePickerScreen(),
  };
}
