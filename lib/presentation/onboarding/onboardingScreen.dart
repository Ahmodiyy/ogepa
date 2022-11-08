import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:ogepa/constant.dart';

import '../register/register.dart';
import 'onboardingWidget.dart';

class OnboardScreen extends StatefulWidget {
  static String id = 'onboardscreen';
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: pageIndex == 2
            ? AppBar(
                backgroundColor: Colors.white12,
                elevation: 0.0,
              )
            : AppBar(
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('seen', true);
                        Navigator.pushReplacementNamed(context, Register.id);
                      },
                      child: const Text(
                        'skip',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.white12,
                elevation: 0.0,
              ),
        body: Container(
          padding: EdgeInsets.only(bottom: 100),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: const [
              Onboarding(
                imageName: 'images/report.png',
                title: 'Report',
                description: 'REPORT AN ENVIRONMENTAL VIOLATIONS',
              ),
              Onboarding(
                imageName: 'images/recycle.png',
                title: 'Recycler',
                description: 'LIST OF HAZARDOUS WASTE RECYCLERS',
              ),
              Onboarding(
                imageName: 'images/consult.png',
                title: 'Consultants',
                description: 'LIST OF ACCREDITED ENVIRONMENTAL CONSULTANTS',
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: constantAppColorTheme,
          height: 100,
          child: Center(
            child: Column(
              children: [
                pageIndex == 2
                    ? Expanded(
                        flex: 2,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff087D04),
                            ),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('seen', true);
                            Navigator.pushReplacementNamed(
                                context, Register.id);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Get Started',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 2,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xffF087D04),
                            ),
                          ),
                          onPressed: () {
                            pageController.nextPage(
                                duration: Duration(microseconds: 100),
                                curve: Curves.ease);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                const Expanded(child: SizedBox()),
                Expanded(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xff087D04),
                      dotColor: Colors.white,
                      dotHeight: 5,
                      dotWidth: 5,
                      expansionFactor: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
