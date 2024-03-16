import 'package:dedsec/providers/home_provider.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final loginprov = context.watch<LoginProvider>();
    final homeprov = context.watch<HomeProvider>();
    NoiseMeter().noise.listen(
      (NoiseReading noiseReading) {
        if (noiseReading.meanDecibel > 60) {
          homeprov.updateProgress1(1);
        } else {
          homeprov.updateProgress1(0);
        }

        if (noiseReading.meanDecibel > 70) {
          homeprov.updateProgress2(1);
        } else {
          homeprov.updateProgress2(0);
        }

        if (noiseReading.meanDecibel > 80) {
          homeprov.updateProgress3(1);
        } else {
          homeprov.updateProgress3(0);
        }
        print('Noise: ${noiseReading.meanDecibel} dB');
        print('Max amp: ${noiseReading.maxDecibel} dB');
      },
      onError: (Object error) {
        print(error);
      },
      cancelOnError: true,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      //Text("Welcome ${loginprov.user!.name ?? ""}!"),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: homeprov.progress3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: homeprov.progress2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                    SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: homeprov.progress1,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
