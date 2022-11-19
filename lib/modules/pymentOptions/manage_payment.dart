import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManagePayment extends StatefulWidget {
  const ManagePayment({Key? key}) : super(key: key);
  @override
  _ManagePaymentState createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: AllCoustomTheme.getThemeData().primaryColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: AppBar().preferredSize.height,
                          child: Row(
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
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
                                child: Center(
                                  child: Text(
                                    'Manage Payment',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: AllCoustomTheme.getThemeData().backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: AppBar().preferredSize.height,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.grey[100],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Debit\\Credit Cards',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Add a card for convenient payment from payment option',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/cards.png',
                          height: 60,
                          width: 350,
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.grey[100],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Wallets',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/phonepe.png',
                                width: 30,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'PhonePe',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/googlepay.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Google Pay',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/paytm.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Paytm',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/amazonpay.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Amazon Pay',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/bhimpay.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Bhim Pay',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/netbank.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'NetBanking',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Link Account',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showInSnackBars(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
