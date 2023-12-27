import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../theme/app_colors.dart';

class CommunityDetailScreen extends StatefulWidget {
  final Map<String, dynamic> communityDetails;

  const CommunityDetailScreen({Key? key, required this.communityDetails})
      : super(key: key);

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {


  YoutubePlayerController? _youtubePlayerController;
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.communityDetails['imageId'],
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        isLive: false,
      ),
    )..addListener(listener);;
  }
  void listener() {
    setState(() {
      _fullScreen = _youtubePlayerController!.value.isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fullScreen ? null : AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          color: AppColors.accent,
          onPressed: () {
            Navigator.pop(context, 'CommunityScreen');
          },
        ),
        title: Text(
          'All communities',
          style: TextStyle(color: AppColors.accent, fontSize: 13.0),
        ),
      ),
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _youtubePlayerController!,
            showVideoProgressIndicator: true,
            aspectRatio: 16 / 9,
          ),
          builder: (context, player) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player,
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
                                  image: AssetImage(
                                      widget.communityDetails['authorImage']),
                                ),
                              ),
                              height: 14,
                              width: 14,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${widget.communityDetails['author'] ?? ''}',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.whiteWithOpacity,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.communityDetails['date'] ?? ''}',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.whiteWithOpacity,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Text(
                      widget.communityDetails['name'] ?? '',
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
                      widget.communityDetails['description'] ?? '',
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
            );
          }),
    );
  }
}
