import 'package:banksy/ui/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> newsDetails;

  const NewsDetailScreen({Key? key, required this.newsDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          color: AppColors.accent,
          onPressed: () {
            Navigator.pop(context, 'NewsScreen');
          },
        ),
        title: Text(
          'All news',
          style: TextStyle(color: AppColors.accent, fontSize: 13.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(newsDetails['imageId']),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            image: AssetImage(newsDetails['authorImage']),
                          ),
                        ),
                        height: 14,
                        width: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${newsDetails['author'] ?? ''}',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.whiteWithOpacity,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${newsDetails['date'] ?? ''}',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.whiteWithOpacity,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Text(
                newsDetails['name'] ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 25),
              Text(
                newsDetails['description'] ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 30,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.whiteWithOpacity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
