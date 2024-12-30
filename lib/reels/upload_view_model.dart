import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';


final uploadViewModelProvider =
    ChangeNotifierProvider.autoDispose<UploadViewModel>((ref) {
  return UploadViewModel(ref);
});
class UploadViewModel extends ChangeNotifier {
  final Ref ref;
  UploadViewModel(this.ref);

 late List<VideoPlayerController> controller=[];
  late PageController pageController= PageController();
  int currentIndex = 0;
  List<String> videoUrls = [];
  bool isUploading = false;
  bool isLoading = true; 
  Future<void> initState() async {
      isLoading = true;
      notifyListeners();
    videoUrls = await fetchVideoUrls();
    controller =  videoUrls.map((url) => VideoPlayerController.networkUrl(Uri.parse(url))).toList();
      for (var ctrl in controller) {
        await ctrl.initialize(); 
      }        
      if (videoUrls.isNotEmpty) {
        controller[currentIndex].play();
      }
      isLoading= false;
          notifyListeners();
  }
  Future<void> uploadVideosToFirebase() async {
    isUploading= true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance.ref().child('videos');

    try {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement()..accept = 'video/mp4';
      uploadInput.multiple = true; 
      uploadInput.click();
        await uploadInput.onChange.first;
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;

      for (var file in files) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        await reader.onLoad.first;

        final blob = file.slice();
        final uploadTask = storageRef.child(file.name).putBlob(blob);

        await uploadTask.whenComplete(() {
          print('Uploaded: ${file.name}');
        });
      }
    } catch (e) {
      print("Error uploading videos: $e");
    }
    isUploading= false;
    notifyListeners();
  }
Future<List<String>> fetchVideoUrls() async {
    final storageRef = FirebaseStorage.instance.ref().child('videos');
    final ListResult result = await storageRef.listAll();

    List<String> urls = [];
    for (var ref in result.items) {
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
void onPageChanged(int index) {
  if (controller.isNotEmpty) {
    controller[currentIndex].pause();
    currentIndex = index;
    controller[currentIndex].play();
  }
    notifyListeners();
}
 @override
void dispose() {
  for (var ctrl in controller) {
    ctrl.dispose();
  }
  if (pageController.hasClients) {
    pageController.dispose();
  }
  super.dispose();
}
}
