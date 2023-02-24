import 'package:covid_19_tracker_app_flutter/models/channel_model.dart';
import 'package:covid_19_tracker_app_flutter/models/video_model.dart';
import 'package:covid_19_tracker_app_flutter/pages/video_page/video_detail_screen.dart';
import 'package:covid_19_tracker_app_flutter/services/youtube_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constant.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await YoutubeService.instance
        .fetchChannel(channelId: 'UCabsTV34JwALXKGMqHpvUiA');
    setState(() {
      _channel = channel;
    });
  }

  Future _refreshChannel() async {
    setState(() {
      _channel = null;
    });
    _initChannel();
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 30,
            color: kShadowColor,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(_channel.profilePictureUrl)),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} người đăng ký',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Kênh Youtube chính thức của VTV24 - Đài Truyền Hình Việt Nam",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoDetailScreen(video: video),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10),
        // height: 500.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kShadowColor,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Image(
              width: MediaQuery.of(context).size.width - 30,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(height: 10.0),
            Text(
              video.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              DateFormat('kk:mm - dd/MM/yyyy').format(video.publishedAt),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              video.description,
              maxLines: 3,
              style: TextStyle(
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await YoutubeService.instance
        .fetchVideosFromPlaylist(
            playlistId: "PL1Vi4Nt_Cpb6q3onrLHLgi38Nmcpgbgp-");
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bản tin COVID-19'),
      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: _refreshChannel,
                child: ListView.builder(
                  itemCount: 1 + _channel.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return _buildProfileInfo();
                    }
                    Video video = _channel.videos[index - 1];
                    return _buildVideo(video);
                  },
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
