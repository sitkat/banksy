import 'package:banksy/data/utils/app_parser.dart';
import 'package:banksy/theme/app_colors.dart';
import 'package:banksy/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../data/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;
  String cardNumber = '3123 4792 4629 4519';
  String expiredDate = '10/28';
  late List<Map<String, dynamic>> news = [];
  late List<Map<String, dynamic>> communities = [];

  AppParser appParser = AppParser();

  @override
  void initState() {
    super.initState();
    _fetchCommunities();
    _fetchNews();
    _loadIncomesFromDatabase();
  }

  Future<void> _loadIncomesFromDatabase() async {
    final database = await DatabaseHelper.instance.database;
    final results = await database.query('Income');
    double totalIncomes = 0;

    for (final entry in results) {
      final amount = entry['amount'] as double;
      totalIncomes += amount;
    }

    setState(() {
      balance = totalIncomes;
    });
  }

  Future<void> _fetchCommunities() async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query('Community');
    setState(() {
      communities = result;
    });
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
      appBar: CustomAppBar(context, 'Home'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.pinkAccent.shade100,
                    AppColors.accent,
                    Colors.grey,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance',
                      style: TextStyle(
                        color: AppColors.whiteWithOpacity,
                        fontSize: 10.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${balance}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Image.asset('assets/images/masterCard.png'),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Card number',
                              style: TextStyle(
                                color: AppColors.whiteWithOpacity,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${cardNumber}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expired Date',
                              style: TextStyle(
                                color: AppColors.whiteWithOpacity,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${expiredDate}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'News',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: news.length > 2 ? 2 : news.length,
                itemBuilder: (context, index) {
                  final _news = news[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(_news['imageId']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 78,
                              width: 78,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(height: 17),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            _news['authorImage'],
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
                                          Text(
                                            '${_news['takesTime'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.whiteWithOpacity,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            '${appParser.formatTimeAgo(_news['date']) ?? ''}',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Community',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: communities.length > 2 ? 2 : communities.length,
                itemBuilder: (context, index) {
                  final community = communities[index];
                  final String videoId = community['imageId'] ?? '';

                  YoutubePlayerController _youtubePlayerController =
                      YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(autoPlay: false, isLive: false),
                  );

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 78,
                                height: 78,
                                child: YoutubePlayer(
                                  controller: _youtubePlayerController,
                                  showVideoProgressIndicator: true,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    community['name'] ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(height: 17),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            community['authorImage'],
                                            height: 14,
                                            width: 14,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${community['author'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.whiteWithOpacity,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${community['takesTime'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.whiteWithOpacity,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            '${appParser.formatTimeAgo(community['date']) ?? ''}',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
