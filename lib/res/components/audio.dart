import 'package:just_audio/just_audio.dart';

class Audio {
  static AudioPlayer audioPlayers = AudioPlayer();

  static Future<void> depositmusic() async {
    var duration = await audioPlayers.setAsset('assets/music/mp3.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);

  }

}
