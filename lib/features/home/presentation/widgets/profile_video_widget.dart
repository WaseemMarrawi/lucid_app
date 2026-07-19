import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';


class ProfileVideoWidget extends StatefulWidget {
  final String videoUrl;

  const ProfileVideoWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<ProfileVideoWidget> createState() => _ProfileVideoWidgetState();
}


class _ProfileVideoWidgetState extends State<ProfileVideoWidget> {

  VideoPlayerController? _controller;

  bool _initialized = false;


  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }



  Future<void> _initializeVideo() async {

    try {

      // يأخذ من الكاش أو يحمل أول مرة
      final file = await DefaultCacheManager()
          .getSingleFile(
        widget.videoUrl,
      );


      _controller =
          VideoPlayerController.file(
            File(file.path),
          );


      await _controller!.initialize();


      await _controller!.setLooping(
        true,
      );


      await _controller!.setVolume(
        0,
      );


      await _controller!.play();



      if(mounted){

        setState(() {

          _initialized = true;

        });

      }


    } catch(e){

      debugPrint(
        "Video Cache Error: $e",
      );

    }

  }




  @override
  void dispose() {

    _controller?.dispose();

    super.dispose();

  }




  @override
  Widget build(BuildContext context) {


    if(!_initialized || _controller == null){

      return const SizedBox.expand();

    }



    return SizedBox.expand(

      child: FittedBox(

        fit: BoxFit.cover,


        child: SizedBox(

          width: _controller!.value.size.width,

          height: _controller!.value.size.height,


          child: VideoPlayer(
            _controller!,
          ),

        ),

      ),

    );

  }

}