import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/reels/upload_view.dart';
import 'package:tiktok_clone/reels/upload_view_model.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class MyReelPage extends ConsumerStatefulWidget {
  const MyReelPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyReelPage> createState() => _MyReelPageState();
}

class _MyReelPageState extends ConsumerState<MyReelPage> {
   @override
void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(uploadViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        // ignore: prefer_const_constructors
        title: Center(
          child: const Text(
            "Reels",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
        ],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: viewModel.isLoading
        ? const Center(child: CircularProgressIndicator()) 
        : PageView.builder(
        controller: viewModel.pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: viewModel.onPageChanged,
        itemCount: viewModel.videoUrls.length,
        itemBuilder: (context, index){
          return Stack(
            children: [
              Center(
                child:  viewModel.controller[index].value.isInitialized ? AspectRatio(
                      aspectRatio: viewModel.controller[index].value.aspectRatio,
                      child: VideoPlayer(viewModel.controller[index]),
                      )
                    : const CircularProgressIndicator(),
                      ),
              Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: Colors.black54,
                  onPressed: () {
                    setState(() {
                    viewModel.controller[index].value.isPlaying ? viewModel.controller[index].pause() : viewModel.controller[index].play();
                    });
                  },
                  child: Icon(
                  viewModel.controller[index].value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                IconButton(
               onPressed: () {},
                  icon: const Icon(
                  CupertinoIcons.heart,
                      size: 33,
                      color: Colors.pinkAccent,
                        ),
                ), const SizedBox(height: 25),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.chat_bubble,
                    size: 33,
                    color: Colors.pinkAccent,
                  ),
                ),const SizedBox(height: 25),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.arrow_turn_up_right,
                    size: 33,
                    color: Colors.pinkAccent,
                  ),
                ),const SizedBox(height: 25),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.ellipsis_vertical,
                    size: 33,
                    color: Colors.pinkAccent,
                ),
                ),
                ],
                ),
              ),
           ),
          ],
              );
        }
        ),
      ),
      );
  }
}

