import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_practice/colors.dart';
import 'package:video_player/video_player.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return VideoInfoState();
  }
}

class VideoInfoState extends State<VideoInfo> {
  List _info = [];
  bool _playAreaShowing = false;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        _info = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: _playAreaShowing == false
            ? BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColor.gradientFirst.withOpacity(0.8),
                  AppColor.gradientSecond.withOpacity(0.9)
                ], begin: FractionalOffset(0.0, 0.4), end: Alignment.topRight),
              )
            : BoxDecoration(color: AppColor.gradientSecond),
        child: Column(
          children: [
            _playAreaShowing == false
                ? Container(
                    height: 300,
                    padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColor.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outlined,
                              size: 20,
                              color: AppColor.secondPageIconColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Legs Toning",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 25,
                                    color: AppColor.secondPageTitleColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "and Glutes Workout",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 25,
                                    color: AppColor.secondPageTitleColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor
                                            .secondPageContainerGradient1stColor,
                                        AppColor
                                            .secondPageContainerGradient2ndColor,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "68 min",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color: AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor
                                            .secondPageContainerGradient1stColor,
                                        AppColor
                                            .secondPageContainerGradient2ndColor,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 20,
                                    color: AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Resistent band kettebell",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        color: AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding:
                              EdgeInsets.only(top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _playAreaShowing = false;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 20,
                                  color: AppColor.secondPageIconColor,
                                ),
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: AppColor.secondPageTopIconColor,
                              )
                            ],
                          ),
                        ),
                        _playView(context),
                      ],
                    ),
                  ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70))),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Circuit 1: Legs Toning",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Icon(
                            Icons.loop,
                            size: 30,
                            color: AppColor.loopColor,
                          ),
                          Text(
                            "3 sets",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15, color: AppColor.setsColor),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: _info.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          itemBuilder: (_, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _onTapVideo(index);
                                  if (_playAreaShowing == false) {
                                    _playAreaShowing = true;
                                  }
                                });
                              },
                              child: _listViewItemCreate(index),
                            );
                          }))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  _listViewItemCreate(int index) {
    return Container(
      height: 135,
      width: 200,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(_info[index]["thumbnail"]),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _info[index]["title"],
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _info[index]["time"],
                      style: GoogleFonts.aBeeZee(
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Color(0xFFeaeefc),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "15s rest",
                    style: TextStyle(color: Color(0xFF839fed)),
                  )),
                ),
                Row(
                  children: [
                    for (int i = 1; i < 70; i++)
                      i.isEven
                          ? Container(
                              width: 3,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Color(0xFF839fed),
                                  borderRadius: BorderRadius.circular(2)),
                            )
                          : Container(
                              width: 3,
                              height: 1,
                              color: Colors.white,
                            )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onTapVideo(int index) {
    String videoUrl = _info[index]["videoUrl"];
    debugPrint("VideoUrl $videoUrl");
    _controller = VideoPlayerController.network(videoUrl);
    _controller?.initialize().then((value) {
      _controller?.play();
      setState(() {});
    });
  }

  Widget _playView(BuildContext context) {
    if (_controller != null && (_controller?.value.isInitialized == true)) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller!),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: Text("Preparing...")),
      );
    }
  }
}
