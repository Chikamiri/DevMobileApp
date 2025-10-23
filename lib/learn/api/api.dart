import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YoutubeSearchPlayer(),
    );
  }
}

class YoutubeSearchPlayer extends StatefulWidget {
  const YoutubeSearchPlayer({super.key});
  @override
  State<YoutubeSearchPlayer> createState() => _YoutubeSearchPlayerState();
}

class _YoutubeSearchPlayerState extends State<YoutubeSearchPlayer> {
  final TextEditingController _controller = TextEditingController();
  final String apiKey = '';
  List<Map<String, String>> videos = [];
  String? selectedId;
  bool loading = false;
  YoutubePlayerController? ytController;

  Future<void> searchVideos(String query) async {
    setState(() => loading = true);
    final url = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'part': 'snippet',
      'q': query,
      'type': 'video',
      'maxResults': '5',
      'key': apiKey,
    });
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final items = data['items'] as List;
      videos = items
          .map(
            (it) => {
              'id': it['id']['videoId'],
              'title': it['snippet']['title'],
            },
          )
          .cast<Map<String, String>>()
          .toList();
    } else {
      videos = [];
    }
    setState(() => loading = false);
  }

  void playVideo(String id) {
    setState(() => selectedId = id);
    ytController?.dispose();
    ytController = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    ytController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Search Player')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Nhập từ khóa tìm kiếm...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchVideos(_controller.text),
                ),
              ],
            ),
            if (loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (selectedId != null && ytController != null)
              YoutubePlayer(
                controller: ytController!,
                showVideoProgressIndicator: true,
              ),
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(videos[i]['title'] ?? ''),
                  onTap: () => playVideo(videos[i]['id']!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
