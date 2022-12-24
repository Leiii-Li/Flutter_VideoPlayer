import 'dart:convert';
import 'dart:math';

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
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  bool _isMute = false;
  String _currentPosition = "00:00";
  double _progress = 0;
  Duration? _duration;
  Duration? _position;

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
                                  _disposeController();
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.red[700],
                                  inactiveTrackColor: Colors.red[100],
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: 0.5,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 8),
                                  thumbColor: Colors.redAccent,
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape:
                                      RoundSliderOverlayShape(overlayRadius: 8),
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  activeTickMarkColor: Colors.red[700],
                                  inactiveTickMarkColor: Colors.red[100],
                                  valueIndicatorShape:
                                      PaddleSliderValueIndicatorShape(),
                                  valueIndicatorColor: Colors.redAccent,
                                  valueIndicatorTextStyle:
                                      TextStyle(color: Colors.white)),
                              child: Slider(
                                value: max(0, min(_progress * 100, 100)),
                                min: 0,
                                max: 100,
                                divisions: 100,
                                onChanged: (value) {
                                  setState(() {
                                    _progress = value * 0.01;
                                  });
                                },
                                onChangeStart: (value) {
                                  _controller?.pause();
                                },
                                onChangeEnd: (value) {
                                  final duration = _controller?.value.duration;
                                  if (duration != null) {
                                    var newValue = max(0, min(value, 99)) * 0.01;
                                    var millis =
                                        (duration.inMicroseconds * newValue)
                                            .toInt();
                                    _controller
                                        ?.seekTo(Duration(microseconds: millis));
                                    _controller?.play();
                                  }
                                },
                              )),
                        ),
                        _controllerView(context)
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

  var _onUpdateControllerTime = 0;

  void _onControllerListener() async {
    if (_disposed) {
      return;
    }
    final now = DateTime.now().microsecondsSinceEpoch;
    if ((now - _onUpdateControllerTime) < 1000) {
      return;
    }
    _onUpdateControllerTime = now;

    if (_controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (_controller?.value.isInitialized == false) {
      debugPrint("controller is not prepare");
      return;
    }
    _position = await _controller?.value.position;

    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = covertTwo(remained ~/ 60.0);
    final sec = covertTwo((remained % 60.0).toInt());
    debugPrint("$mins:$sec");

    setState(() {
      _isPlaying = _controller?.value.isPlaying ?? false;
      _currentPosition = "$mins:$sec";
      _progress = _position!.inMicroseconds.ceilToDouble() /
          _duration!.inMicroseconds.ceilToDouble();
    });
  }

  void _onTapVideo(int index) {
    _isPlayingIndex = index;
    String videoUrl = _info[index]["videoUrl"];
    debugPrint("VideoUrl $videoUrl");
    final oldController = _controller;
    _controller = VideoPlayerController.network(videoUrl);
    if (oldController != null) {
      oldController.pause();
      oldController.removeListener(_onControllerListener);
    }
    _controller?.initialize().then((value) {
      _isMute = (_controller?.value.volume == 0);
      oldController?.dispose();
      _controller?.addListener(_onControllerListener);
      _controller?.play();
      _duration = _controller?.value.duration;
      _position = _controller?.value.position;

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

  Widget _controllerView(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (_isMute) {
                  _controller?.setVolume(1.0);
                  _isMute = false;
                } else {
                  _controller?.setVolume(0);
                  _isMute = true;
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4,
                      color: Color.fromARGB(50, 0, 0, 0))
                ]),
                child: Icon(
                  _isMute ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var targetIndex = _isPlayingIndex - 1;
              if (targetIndex < 0 || _info.isEmpty) {
                Get.snackbar("Video", "No more video to play",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.face,
                      size: 30,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(bottom: 10));
                return;
              } else {
                _onTapVideo(targetIndex);
              }
            },
            child: Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                if (_isPlaying == true) {
                  _controller?.pause();
                } else {
                  _controller?.play();
                }
              });
            },
            child: Icon(
              _isPlaying == true ? Icons.pause : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              var targetIndex = _isPlayingIndex + 1;
              if (targetIndex >= _info.length || _info.isEmpty) {
                Get.snackbar("Video", "No more video to play",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.face,
                      size: 30,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(bottom: 10));
                return;
              } else {
                _onTapVideo(targetIndex);
              }
            },
            child: Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            _currentPosition,
            style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: AppColor.secondPageTitleColor.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  _disposeController() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  String covertTwo(int value) {
    if (value < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }
}
