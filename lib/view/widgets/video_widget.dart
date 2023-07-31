

import 'package:flutter/material.dart';
import 'package:movie/models/series.dart';
import 'package:pod_player/pod_player.dart';

class VideoWidget extends StatefulWidget {


  final String id;
  VideoWidget(this.id);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.id}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: false,
            isLooping: false,
            videoQualityPriority: [1080, 720]
        )
    )..initialise();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      controller:controller,
      // videoThumbnail:  DecorationImage(
      //   image: NetworkImage(widget.series.backdrop_path),
      //   fit: BoxFit.cover,
      // ),
    );
  }
}