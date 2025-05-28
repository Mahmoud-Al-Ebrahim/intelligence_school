import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../theme/colors.dart';



class MYVideoPlayer extends StatefulWidget {
  const MYVideoPlayer({Key? key, required this.url}) : super(key: key);

  final String url ;
  @override
  State<MYVideoPlayer> createState() => _MYVideoPlayerState();
}

class _MYVideoPlayerState extends State<MYVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller..addListener(() {
      setState(() {

      });
    }
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getPosition() {
    final duration = Duration(
        milliseconds: _controller.value.position.inMilliseconds.round());

    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':').padLeft(2,'0');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
                _controller.value.isPlaying
                    ? Container()
                    : const Icon(Icons.play_arrow,
                        size: 50, color: Colors.white),
                buildSpeed(),
                Positioned(
                  left: 8,
                  bottom: 28,
                  child: Text(getPosition(),style: const TextStyle(fontSize: 14 , color: Colors.white)),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 16,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                          bufferedColor:
                              Colors.grey.shade300,
                          playedColor: primaryColor,
                          backgroundColor: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }

  Widget buildSpeed() {
    const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<double>(
        initialValue: _controller.value.playbackSpeed,
        tooltip: 'Playback speed',
        onSelected: _controller.setPlaybackSpeed,
        itemBuilder: (context) => allSpeeds
            .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                  value: speed,
                  child: Text(
                    '${speed}x',
                    style: const TextStyle(color: primaryColor),
                  ),
                ))
            .toList(),
        child: Container(
          color: Colors.white38,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            '${_controller.value.playbackSpeed}x',
           style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
