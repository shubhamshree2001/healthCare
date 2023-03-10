import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/guides_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/guidesRepo/guides_repo.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:audioplayers/audioplayers.dart';

class GuidesAudioTemelateController extends GetxController {
  final GuidesRepo guidesRepo;

  GuidesAudioTemelateController({required this.guidesRepo});
  AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void onInit() {}

  // Future<void> getAudio() async {
  //   var url = "";
  //   if (playing.value) {
  //     var res = await audioPlayer.pause().obs;
  //     if (res.value == 1) {
  //       playing.value = false;
  //     } else {
  //       //var res = await audioPlayer.play(url).obs;
  //     }
  //   }
  // }
  // Future getAudioUrl() async{
  //   final response = await http.get(Uri.parse(uri))
  // }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
