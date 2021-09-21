import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'page1.dart';
import 'package:video_player/video_player.dart';

void main() async {
  runApp(splash());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: Stack(
            children: <Widget>[
              Center(
                child: new SplashScreen(
                    seconds: 4,
                    navigateAfterSeconds: MyApp(),
                    image: new Image.asset(
                      'images/splash.gif',
                    ),
                    backgroundColor: Color.fromRGBO(61, 136, 221, 1),
                    photoSize: 180,
                    loadingText: Text(
                      'Welcome to Eczane',
                      style: TextStyle(fontSize: 30),
                    ),
                    loaderColor: Colors.white),
              ),
            ],
          ),
        ));
  }
}

class _MyAppState extends State<MyApp> {
  @override
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("images/tator.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String dropdownValue = 'English';
  String dropdownValue2 = 'Normal';

  Future _info() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.80),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              //test
              height: 503,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Eczane is a point of sale mobile application to be used by pharmacies instead of using the traditional computer-based software system that currently used in the pharmacies. Eczane enables the pharmacists to electronically manage/control all pharmacy staff, In addition, Eczane has the mobility feature that enable controlling/reporting everything remotely, which make it more comfortable for pharmacist, and give the manager the ability of viewing the details of the pharmacy and controlling it as well as the auto push notification alert system that will remind the users with all important Information about the stocks, Eczane contains all the needs from warehouses, statistical reports, sales, and a lot more. made by Mohanad Ashour and Yousef Alnajjar from Applied science university. ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _show() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.80),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: InkWell(
              // onTap: _controller.puse();,
              child: Container(
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: _controller.value.initialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : Container(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: FloatingActionButton(
                            onPressed: () {
                              // Wrap the play or pause in a call to `setState`. This ensures the
                              // correct icon is shown
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                }
                              });

                              setState(() {});
                            },

                            // Display the correct icon depending on the state of the player.
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        key: _scaffoldKey,
        endDrawer: new Drawer(
            child: Container(
          color: Color.fromRGBO(222, 234, 247, 1),
          child: ListView(
            children: <Widget>[
              Container(
                  height: 50,
                  child: DrawerHeader(
                      decoration: BoxDecoration(
                    color: Color.fromRGBO(66, 160, 206, 1),
                  ), child: null,)),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('Languge'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (newValue) {
                            print(newValue);

                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['English', 'Arabic']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('Theme'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: dropdownValue2,
                          onChanged: (newValue) {
                            print(newValue);

                            setState(() {
                              dropdownValue2 = newValue;
                            });
                          },
                          items: <String>['Normal', 'Dark', 'light']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: new Icon(Icons.info),
                          onTap: () {
                            _info();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: new Icon(Icons.videocam),
                          onTap: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });

                            _show();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 160, 206, 1),
          title: Center(
              child: Text(
            "Eczane",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.settings),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(123, 189, 221, 1), //back

        body: Page1(),
        //Center(child: new Image.asset("images/ph.png"))
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
