import 'package:dedsec/constants.dart';
import 'package:dedsec/providers/intro_provider.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  late final GifController controller1, controller2, controller3;

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    controller2 = GifController(vsync: this);
    controller3 = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final introprov = context.watch<IntroProvider>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                "Skip",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (n) {
              if (n > 1) {
                introprov.setName("Sign Up");
              } else {
                introprov.setName("Continue");
              }
            },
            children: [
              Container(
                color: Color(0xff0D1117),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gif(
                      autostart: Autostart.loop,
                      placeholder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      image: const AssetImage('assets/1.gif'),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 50),
                      child: const Text(
                        "Welcome to Dedsec",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 100),
                      child: const Text(
                        "Connect & collaborate with fellow students through group chat",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
              Container(
                color: bg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gif(
                      autostart: Autostart.loop,
                      placeholder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      image: const AssetImage('assets/2.gif'),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 100),
                      child: const Text(
                        "Quick AI Assistance",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 100),
                      child: const Text(
                        "Got questions or douts? Our AI Chatbot is here to help!",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
              Container(
                color: bg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gif(
                      autostart: Autostart.loop,
                      placeholder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      image: const AssetImage('assets/3.gif'),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 50),
                      child: const Text(
                        "Let's get started!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 100),
                      child: const Text(
                        "Explore exciting features to enhance your learning experience",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.shade500,
                    activeDotColor: Colors.white,
                    dotHeight: size.height * 0.01,
                    dotWidth: 10,
                  ),
                  controller: _controller,
                  count: 3,
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (introprov.btnName == "Continue") {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              } else {
                                Navigator.pushNamed(context, '/login');
                                //Navigator.pushReplacementNamed(context, '/');
                              }
                            },
                            child: Text(
                              introprov.btnName,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
