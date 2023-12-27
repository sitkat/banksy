import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/onboard_model.dart';
import '../theme/app_colors.dart';
import 'navigation_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isView = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: ListView.builder(
                          itemCount: screens.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                  width: MediaQuery.of(context).size.width / 4.8 ,
                                  height: 3.0,
                                  decoration: BoxDecoration(
                                      color: currentIndex == index
                                          ? AppColors.accent
                                          : AppColors.accentWithOpacity,
                                      borderRadius: BorderRadius.circular(10.0)),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Image.asset(screens[index].image),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40.0),
                            Text(
                              screens[index].text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              screens[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13, color: AppColors.whiteWithOpacity),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: InkWell(
                    onTap: () async {
                      if (index == screens.length - 1) {
                        await _storeOnBoardInfo();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationScreen()));
                      }
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.bounceIn);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Terms of use | Privacy Policy',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.whiteWithOpacity,
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
