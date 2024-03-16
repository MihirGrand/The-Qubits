import 'dart:developer';

import 'package:dedsec/constants.dart';
import 'package:dedsec/providers/audio_provider.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:dedsec/providers/room_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final loginprov = context.watch<LoginProvider>();
    final audioprov = context.read<AudioProvider>();
    final roomprov = context.watch<RoomProvider>();
    final PageController _controller = PageController();
    NoiseMeter().noise.listen(
      (NoiseReading noiseReading) {
        if (noiseReading.meanDecibel > 60) {
          audioprov.updateProgress1(1);
        } else {
          audioprov.updateProgress1(0);
        }

        if (noiseReading.meanDecibel > 70) {
          audioprov.updateProgress2(1);
        } else {
          audioprov.updateProgress2(0);
        }

        if (noiseReading.meanDecibel > 80) {
          audioprov.updateProgress3(1);
        } else {
          audioprov.updateProgress3(0);
        }
        /*print('Noise: ${noiseReading.meanDecibel} dB');
        print('Max amp: ${noiseReading.maxDecibel} dB');*/
      },
      onError: (Object error) {
        print(error);
      },
      cancelOnError: true,
    );
    var children = loginprov.homes?.first.rooms!.map((e) {
      var temp = e.devices?.where((element) => element.type == 0);
      if (temp != null && temp.isNotEmpty) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: bgS,
              ),
              child: Center(
                child: Text(
                  temp.first.name ?? "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: bgS,
                        ),
                        child: Text(
                          e.name ?? "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.transparent,
                        ),
                        child: Text(
                          "Live",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: bgS,
                        child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: iconClr,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: bgS,
                        child: IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: iconClr,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      } else {
        return Container(
          child: Text("No camera devices found!"),
        );
      }
    }).toList();

    var devices = loginprov.homes?.first.rooms?.first.devices
        ?.where((element) => element.type != 0)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: Text(
          loginprov.homes?.first.name ?? "",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: bgS,
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: iconClr,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: bgS,
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: iconClr,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        height: 300,
                        child: PageView(
                          controller: _controller,
                          children: children ?? [],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: children?.length ?? 0,
                      effect: const ExpandingDotsEffect(
                        dotColor: bgS,
                        activeDotColor: theme,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: bgS,
                                ),
                                child: Expanded(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Icon(Icons.power_settings_new,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: bgS,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.power_settings_new,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: bgS,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.shield_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: bgS,
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("      "),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: bgS,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    itemCount: devices?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var temp = devices;
                      IconData icon = Icons.camera_alt;
                      int type = devices![index].type ?? 0;
                      if (type == 0) {
                        icon = Icons.camera;
                      } else if (type == 1) {
                        icon = Icons.mic;
                      } else if (type == 2) {
                        icon = Icons.vibration;
                      } else if (type == 3) {
                        icon = Icons.door_back_door;
                      } else if (type == 4) {
                        icon = Icons.window;
                      }
                      if (temp != null && temp.isNotEmpty) {
                        return Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: bgS,
                                borderRadius: BorderRadius.circular(40),
                                child: ListTile(
                                  leading: Icon(icon),
                                  title: Text(
                                    temp[index].name ?? "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  tileColor: bgS,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: bgS,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.create,
                                  color: iconClr,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          child: Text("No camera devices found!"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
