import 'package:banksy/theme/app_colors.dart';
import 'package:banksy/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  late List<Map<String, dynamic>> communities = [];

  @override
  void initState() {
    super.initState();
    _fetchCommunities();
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

  Future<String?> _fetchChannelImage(String channelId, String apiKey) async {
    final url =
        'https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['items'] != null && data['items'].isNotEmpty) {
        return data['items'][0]['snippet']['thumbnails']['default']['url'];
      }
    }

    return null;
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
                // Ограничиваем количество карточек до 2
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
                    // Добавляем отступ между элементами списка
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YoutubePlayer(
                              width: 90,
                              controller: _youtubePlayerController,
                              showVideoProgressIndicator: true,
                            ),
                            SizedBox(width: 8),
                            // Добавляем промежуток между YoutubePlayer и текстом
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
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // Тут
                                        children: [
                                          // ClipRRect(
                                          //   borderRadius: BorderRadius.circular(12), // Радиус закругления углов
                                          //   child: Image.network(
                                          //     fetchChannelImage('marktilbury', ' ') ?? '',
                                          //     width: 24, // Ширина изображения канала
                                          //     height: 24, // Высота изображения канала
                                          //     fit: BoxFit.cover, // Заполнение изображения в области
                                          //   ),
                                          // ),
                                          Text(
                                            '${community['author'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.whiteWithOpacity,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${community['takesTime'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.whiteWithOpacity,
                                        ),
                                      ),
                                      Text(
                                        '${community['date'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.whiteWithOpacity,
                                        ),
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
