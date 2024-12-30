import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/reels/upload_view2.dart';
import 'package:tiktok_clone/reels/upload_view_model.dart';
import 'upload_view_model.dart';

class UploadPage extends ConsumerStatefulWidget {
  const UploadPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadPageState();
}

class _UploadPageState extends ConsumerState<UploadPage> {
  @override
  void initState() {
    super.initState();
    final viewModel=ref.read(uploadViewModelProvider);
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(uploadViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Upload")),
        foregroundColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.uploadVideosToFirebase();
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                  child: const Text(
                    'UPLOAD REEL',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              if (viewModel.isUploading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 11),
                  Text(
                    'Uploading Video',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
                ),
               SizedBox(height: 11),
              ElevatedButton(
              onPressed: ()  async {
                 await viewModel.initState();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReelPage(
                      title: 'TikTok Clone',
                    ),
        
                  ),
                );
              },style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
              child: const Text(
                "WATCH REELS",
                style: TextStyle(color: Colors.white),
              ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
