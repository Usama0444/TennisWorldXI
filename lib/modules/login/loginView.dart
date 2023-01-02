import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/validator/validator.dart';
import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';
import '../../utils/phone_number.dart';
import '../../utils/toast.dart';
import '../home/tabScreen.dart';
import 'continuebutton.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DateTime date = DateTime.now();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passwordController.dispose();
    phoneController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (!Validators().passwordValidator(value)) {
        return 'Password length should be greater than 6 chars.';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: AllCoustomTheme.getThemeData().backgroundColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 4, right: 16),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 5),
                        child: Center(
                          child: TextFormField(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                                setState(() {});
                              });
                            },
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              fillColor: Colors.black,
                              border: InputBorder.none,
                              prefixText: phoneFocusNode.hasFocus || phoneController.text.isNotEmpty ? "+91 " : '',
                              prefixStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: AppConstant.SIZE_TITLE16,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE16,
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number can not be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 5),
                        child: Center(
                          child: TextFormField(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                                setState(() {});
                              });
                            },
                            controller: passwordController,
                            autofocus: false,
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: _obscureConfirmText,
                            decoration: InputDecoration(
                              hintText: "Password",
                              fillColor: Colors.black,
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                dragStartBehavior: DragStartBehavior.down,
                                onTap: () {
                                  setState(() {
                                    _obscureConfirmText = !_obscureConfirmText;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Icon(
                                    _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                                    semanticLabel: _obscureConfirmText ? 'show password' : 'hide password',
                                  ),
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE16,
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            validator: _validatePassword,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   child: TextFormField(
                    //     controller: emailController,
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: AppConstant.SIZE_TITLE16,
                    //       color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                    //     ),
                    //     autofocus: false,
                    //     focusNode: emailFocusNode,
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration:  InputDecoration(
                    //         labelText: 'Email',
                    //         icon: Padding(
                    //           padding: const EdgeInsets.only(top: 16),
                    //           child: Icon(Icons.person),
                    //         )),
                    //     onEditingComplete: () {
                    //       FocusScope.of(context).requestFocus(passwordFocusNode);
                    //     },
                    //     validator: _validateEmail,
                    //     onSaved: (value) {
                    //       emailtxt = value!;
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //  Container(
                    //   child:  TextFormField(
                    //     controller: passwordController,
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: AppConstant.SIZE_TITLE16,
                    //       color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                    //     ),
                    //     autofocus: false,
                    //     focusNode: passwordFocusNode,
                    //     keyboardType: TextInputType.text,
                    //     obscureText: _obscureConfirmText,
                    //     decoration:  InputDecoration(
                    //       labelStyle: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: AppConstant.SIZE_TITLE16,
                    //       ),
                    //       labelText: 'Password',
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(top: 16),
                    //         child: Icon(Icons.lock),
                    //       ),
                    //       suffixIcon: GestureDetector(
                    //         dragStartBehavior: DragStartBehavior.down,
                    //         onTap: () {
                    //           setState(() {
                    //             _obscureConfirmText = !_obscureConfirmText;
                    //           });
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(top: 14),
                    //           child: Icon(
                    //             _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                    //             semanticLabel: _obscureConfirmText ? 'show password' : 'hide password',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     onEditingComplete: () {
                    //       FocusScope.of(context).requestFocus(FocusNode());
                    //       _submit();
                    //     },
                    //     validator: _validatePassword,
                    //     onSaved: (value) {
                    //       password = value!;
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
              child: ContinueButton(
                name: "Login",
                callBack: () {
                  _submit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      bool isValidNUmber = await isValidPhoneNumber(phoneNumber: phoneController.text);
      if (isValidNUmber) {
        _loginUser();
      } else {
        CustomToast.showToast(message: "Please enter a valid phone number");
      }
    }
  }

  Future<void> _loginUser() async {
    API_STRUCTURE apiObject = API_STRUCTURE(
        context: context,
        apiName: ApiConstant.loginUser,
        apiRequestMethod: API_REQUEST_METHOD.POST,
        isWantSuccessMessage: false,
        body: FormData.fromMap({
          "phone": phoneController.text.trim(),
          "password": passwordController.text.trim(),
        }));
    Map<dynamic, dynamic> apiResponse = await apiObject.requestAPI(isShowLoading: true);
    debugPrint("login apiResponse:-> $apiResponse");
    if (apiResponse.containsKey(API_RESPONSE.SUCCESS)) {
      Map<String, dynamic> _result = apiResponse[API_RESPONSE.SUCCESS]['data']['result'];
      Utils.userToken = _result['access_token'];
      Utils.userData = UserData.fromServerJson(_result['user']);
      if (Utils.userData != null) {
        MySharedPreferences().setUserDataString(Utils.userData!);
      }
      // Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TabScreen(),
        ),
      );
    }
  }
}
