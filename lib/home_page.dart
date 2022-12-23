import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_practice/colors.dart';
import 'package:flutter_practice/video_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List _info = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      setState(() {
        _info = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Training",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 30,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: AppColor.homePageIcons,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: AppColor.homePageIcons,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColor.homePageIcons,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("Your program",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        color: AppColor.homePageSubtitle,
                        fontWeight: FontWeight.w600)),
                Expanded(child: Container()),
                Text("Details",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      color: AppColor.homePageDetail,
                    )),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => VideoInfo());
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    AppColor.gradientFirst.withOpacity(0.8),
                    AppColor.gradientSecond.withOpacity(0.9),
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 10,
                        color: AppColor.gradientSecond.withOpacity(0.2))
                  ]),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 25, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next workout",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          color: AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Legs Toning",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          color: AppColor.homePageContainerTextSmall),
                    ),
                    Text(
                      "and Glutes Workout",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          color: AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: AppColor.homePageContainerTextSmall,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "60 min",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  color: AppColor.homePageContainerTextSmall),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.gradientFirst,
                                    blurRadius: 10,
                                    offset: Offset(3, 8))
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30),
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(8, 10),
                              blurRadius: 40,
                              color: AppColor.gradientSecond.withOpacity(0.3)),
                          BoxShadow(
                              offset: Offset(-1, -5),
                              blurRadius: 10,
                              color: AppColor.gradientSecond.withOpacity(0.3))
                        ]),
                  ),
                  Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 185, bottom: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/figure.png"),
                        ),
                      )),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: EdgeInsets.only(left: 120, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are doing great",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.homePageDetail),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Keep it up\n",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12,
                                    color: AppColor.homePagePlanColor),
                                children: [
                              TextSpan(
                                text: "stick to your plan",
                              )
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Area of focus",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: AppColor.homePageTitle),
                ),
              ],
            ),
            Expanded(
                child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                    itemCount: (_info.length.toDouble() / 2).toInt(),
                    itemBuilder: (_, index) {
                      int a = 2 * index;
                      int b = 2 * index + 1;
                      return Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 90) / 2,
                            height: 170,
                            margin:
                                EdgeInsets.only(left: 30, bottom: 15, top: 15),
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(_info[a]['img'])),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(5, 5),
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1)),
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(-5, -5),
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1))
                                ]),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  _info[a]['title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.homePageDetail),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 90) / 2,
                            height: 170,
                            margin:
                                EdgeInsets.only(left: 30, bottom: 15, top: 15),
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(_info[b]['img'])),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(5, 5),
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1)),
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(-5, -5),
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1))
                                ]),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  _info[b]['title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.homePageDetail),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
