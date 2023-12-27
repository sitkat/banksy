import 'package:banksy/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../data/database_helper.dart';
import '../data/utils/app_parser.dart';
import '../theme/app_colors.dart';
import 'community_detail_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late List<Map<String, dynamic>> communities = [];
  AppParser appParser = AppParser();

  @override
  void initState() {
    super.initState();
    _fetchCommunities();
  }

  Future<void> _fetchCommunities() async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query('Community');
    setState(() {
      communities = result;
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
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];

                final String videoId = community['imageId'] ?? '';

                YoutubePlayerController _youtubePlayerController =
                    YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: YoutubePlayerFlags(autoPlay: false, isLive: false),
                );
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommunityDetailScreen(communityDetails: community),
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
                              community['name'] ?? '',
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
                              community['description'] ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.whiteWithOpacity,
                              ),
                            ),
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    child: YoutubePlayer(
                                      controller: _youtubePlayerController,
                                      showVideoProgressIndicator: true,
                                      aspectRatio: 16 / 9,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommunityDetailScreen(
                                                    communityDetails:
                                                        community),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              community['authorImage']),
                                        ),
                                      ),
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.today_outlined,
                                          color: AppColors.whiteWithOpacity,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${appParser.formatTimeAgo(community['date']) ?? ''}',
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
                                        Icon(
                                          Icons.access_time_rounded,
                                          color: AppColors.whiteWithOpacity,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${community['takesTime'] ?? ''}',
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
