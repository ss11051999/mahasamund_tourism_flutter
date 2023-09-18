import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Apis/fetch_audio_data.dart';
import 'package:mahasamund_tourism/Pages/main_page.dart';
import 'package:mahasamund_tourism/Pages/welcome_page.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';
import 'package:mahasamund_tourism/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Provider/music_player_provider.dart';
import 'Provider/player_position_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await fetchAudioData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahasamund Tourism',
      theme: ThemeData(primarySwatch: Colors.brown),
      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   // useMaterial3: true,
      // ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MusicPlayerProvider()),
          ChangeNotifierProvider(create: (context) => PlayerPositionProvider())
        ],
        child: const MainPage(),
      ),
    );
  }
}
