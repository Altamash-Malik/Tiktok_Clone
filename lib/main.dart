import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/navigation_bar/navbar_view.dart';
import 'package:tiktok_clone/navigation_bar/navbar_view_model.dart';
import 'package:tiktok_clone/reels/upload_view.dart';
import 'package:tiktok_clone/reels/upload_view_model.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'TIKTOK Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.white),
        useMaterial3: true,
      ),
      home: const NavPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

