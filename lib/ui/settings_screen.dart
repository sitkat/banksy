import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';
import 'navigation_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          color: AppColors.accent,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationScreen()));
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.accent, fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final Uri url = Uri.parse('https://google.com');
                await launchUrl(url);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/privacy.png',
                  ),
                  const SizedBox(width: 25.0),
                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () async {
                final Uri url = Uri.parse('https://google.com');
                await launchUrl(url);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/terms.png',
                  ),
                  const SizedBox(width: 25.0),
                  const Text(
                    'Terms of use',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () async {
                final Uri url = Uri.parse('https://google.com');
                await launchUrl(url);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/info.png',
                  ),
                  const SizedBox(width: 25.0),
                  const Text(
                    'Subscription info',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () async {
                final Uri url = Uri.parse('https://google.com');
                await launchUrl(url);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/rate.png',
                  ),
                  const SizedBox(width: 25.0),
                  const Text(
                    'Rate app',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
