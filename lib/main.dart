import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF7F1FF),
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Video Mobile FT",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  margin: EdgeInsets.only(bottom: 12),
                ),
              ),
              ButterflyMediaCard(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("rizal.jpeg"), // file foto

                  ///POTO
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Rizal Rinaldi R. IF-C22", //Nama
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButterflyMediaCard extends StatefulWidget {
  const ButterflyMediaCard({super.key});

  @override
  _ButterflyMediaCardState createState() => _ButterflyMediaCardState();
}

class _ButterflyMediaCardState extends State<ButterflyMediaCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/rizalv.mp4')

      ///Vidio
      ..initialize().then((_) {
        setState(() {}); // Reload setelah video terinisialisasi
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Image.asset(
                        'assets/poto.jpg', // Gambar jika video belum dimuat
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'DEBUG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                backgroundColor: const Color(0xFFD0C4F7),
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.purple,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
