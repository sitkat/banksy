import 'package:banksy/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../data/database_helper.dart';
import '../data/utils/app_parser.dart';
import '../theme/app_colors.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<Map<String, dynamic>> news = [];
  AppParser appParser = AppParser();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query('News');
    setState(() {
      news = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, 'News'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30, bottom: 10),
            child: Text(
              'Most Popular',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final _news = news[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(newsDetails: _news),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              _news['name'] ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _news['description'] ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.whiteWithOpacity,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(_news['imageId']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 150,
                            ),
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        image: DecorationImage(
                                          image: AssetImage(_news['authorImage']),
                                        ),
                                      ),
                                      height: 14,
                                      width: 14,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${_news['author'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.whiteWithOpacity,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.today_outlined, color: AppColors.whiteWithOpacity, size: 12,),
                                        SizedBox(width: 5,),
                                        Text(
                                          '${appParser.formatTimeAgo(_news['date']) ?? ''}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: AppColors.whiteWithOpacity,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 15),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_rounded, color: AppColors.whiteWithOpacity, size: 12,),
                                        SizedBox(width: 5,),
                                        Text(
                                          '${_news['takesTime'] ?? ''}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: AppColors.whiteWithOpacity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}