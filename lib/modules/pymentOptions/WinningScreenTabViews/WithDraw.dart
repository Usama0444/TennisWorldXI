import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WithDraw extends StatelessWidget {
  const WithDraw({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey.withOpacity(0.05),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      '13 November 2022',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.military_tech,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Successful',
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '5:00 PM',
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '₹49',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/phonepe.png',
                          width: 20,
                          height: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'For transactions older than last 6 months, tap on the download icon\nto review your yealy summary',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromARGB(255, 138, 133, 133),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
