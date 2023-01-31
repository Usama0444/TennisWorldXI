import 'package:TennixWorldXI/constant/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewMatchSetup extends StatefulWidget {
  NewMatchSetup({super.key});

  @override
  State<NewMatchSetup> createState() => _NewMatchSetupState();
}

class _NewMatchSetupState extends State<NewMatchSetup> {
  var dropVal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: myText(
          'New Match Setup',
          Colors.white,
          20.0,
          FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText('Overs', Colors.grey, 18.0, FontWeight.normal),
                      Text(':'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText('Balls Per Over', Colors.grey, 18.0, FontWeight.normal),
                      Text(':'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText('Match State', Colors.grey, 18.0, FontWeight.normal),
                      Text(':'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: DropdownButtonFormField<String>(
                        value: dropVal,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: Text(
                          'Search...',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey[600],
                          ),
                        ),
                        onChanged: (value) {
                          dropVal = value!;
                        },
                        validator: (value) => value == null ? 'Selection required' : null,
                        items: ['Group Match', 'Quarter-Final', 'Semi-Final', '3rd & 4th place', 'Final'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(child: myText('Select Team', Colors.grey, 22.0, FontWeight.bold)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: DropdownButtonFormField<String>(
                                        value: dropVal,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        hint: Text(
                                          'Search...',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        onChanged: (value) {
                                          dropVal = value!;
                                        },
                                        validator: (value) => value == null ? 'Selection required' : null,
                                        items: ['Group Match', 'Quarter-Final', 'Semi-Final', '3rd & 4th place', 'Final'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              myText('DSP', Colors.red[900], 16.0, FontWeight.w900),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: myText('Edit Squad', Colors.white, 20.0, FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    width: 4,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(child: myText('Select Team', Colors.grey, 22.0, FontWeight.bold)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: DropdownButtonFormField<String>(
                                        value: dropVal,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        hint: Text(
                                          'Search...',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        onChanged: (value) {
                                          dropVal = value!;
                                        },
                                        validator: (value) => value == null ? 'Selection required' : null,
                                        items: ['Group Match', 'Quarter-Final', 'Semi-Final', '3rd & 4th place', 'Final'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              myText('Dhanesh xi', Colors.red[900], 16.0, FontWeight.w900),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: myText('Edit Squad', Colors.white, 20.0, FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'NEXT',
                          style: TextStyle(fontSize: 20),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myText(txt, color, fontsize, fontWeight) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    );
  }
}
