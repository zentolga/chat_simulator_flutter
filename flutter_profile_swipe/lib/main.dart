import 'package:flutter/material.dart';
import 'package:flutter_swipe_cards/flutter_swipe_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Swipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProfileSwipePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileSwipePage extends StatefulWidget {
  const ProfileSwipePage({super.key});

  @override
  State<ProfileSwipePage> createState() => _ProfileSwipePageState();
}

class _ProfileSwipePageState extends State<ProfileSwipePage> {
  late List<SwipeItem> _swipeItems;
  late MatchEngine _matchEngine;

  final List<Map<String, String>> _profiles = [
    {"name": "Elif", "bio": "Sanat ve müzik tutkunu.", "image": "assets/images/girl1.jpg"},
    {"name": "Zeynep", "bio": "Kitap kurdu ve kahve sever.", "image": "assets/images/girl2.jpg"},
    {"name": "Ayşe", "bio": "Gezmeyi ve fotoğraf çekmeyi sever.", "image": "assets/images/girl3.jpg"},
    {"name": "Selin", "bio": "Spor ve sağlıklı yaşam meraklısı.", "image": "assets/images/girl4.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _swipeItems = _profiles.map((profile) {
      return SwipeItem(
        content: profile,
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profilleri Kaydır")),
      body: SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (BuildContext context, int index) {
          final profile = _profiles[index];
          return Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(profile["image"]!),
                ),
                const SizedBox(height: 20),
                Text(profile["name"]!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(profile["bio"]!, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
              ],
            ),
          );
        },
        onStackFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tüm profiller gösterildi!")));
        },
        upSwipeAllowed: false,
        fillSpace: true,
      ),
    );
  }
}