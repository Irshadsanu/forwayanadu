import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class HowToPayScreen extends StatefulWidget {
String videoId,description;
   HowToPayScreen({Key? key,required this .videoId,required this .description}) : super(key: key);

  @override
  State<HowToPayScreen> createState() => _HowToPayScreenState();
}

class _HowToPayScreenState extends State<HowToPayScreen> {
//     YoutubePlayerController? videoController;
//     late PlayerState _playerState;
//     late YoutubeMetaData _videoMetaData;
//     double _volume = 100;
//     bool _muted = false;
//     bool _isPlayerReady = false;
// @override
//   void  initState() {
//   super.initState();
//
//   print("dmmkdddd"+widget. videoId);
//   videoController = YoutubePlayerController(
//
//     initialVideoId:widget.videoId,
//     flags: const YoutubePlayerFlags(
//       autoPlay: false,
//       hideControls: false,
//       endAt: 0,
//       // mute: true,
//       showLiveFullscreenButton: false,
//       // loop: true
//     ),
//   )..addListener(listener);
//
//  setState(() {
//    videoController!.addListener(() {
//      if (videoController!.value.isFullScreen) {
//        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//      } else {
//        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//        SystemChrome.setPreferredOrientations([
//          DeviceOrientation.portraitUp,
//        ]);
//      }
//    });
//  });
//
// }
//
//     void listener() {
//       if (_isPlayerReady && mounted && !videoController!.value.isFullScreen) {
//         setState(() {
//           _playerState = videoController!.value.playerState;
//           _videoMetaData = videoController!.metadata;
//         });
//       }
//     }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text('How To Pay',style: wardAppbarTxt),
            centerTitle: true,
            leadingWidth: 55,
            toolbarHeight: height*0.12,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                  onTap: (){
                    callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
            ),

          ),
        ),
        body: Consumer<HomeProvider>(
          builder: (context,value,child) {
            return SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: SizedBox(

                      height: 400,

                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: PromotionWidget(link: widget.videoId)),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(left: 20,right: 15,top: 15),
                    child: RichText(text: TextSpan(children: [
                      // TextSpan(text: "How to pay ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      TextSpan(text:widget.description,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),

                    ])),
                  ),

                ],
              ),
            );
          }
        ),
      ),
    );
  }
  // @override
  // void dispose() {
  // setState(() {
  //   videoController!.dispose();
  //   videoController=null;
  // });
  //
  //   super.dispose();
  // }
}



class PromotionWidget extends StatefulWidget {
  const PromotionWidget({
     required this.link,
  });
  final String link;

  @override
  State<PromotionWidget> createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget> {
  YoutubePlayerController? videoController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  void  initState() {
    super.initState();


    videoController = YoutubePlayerController(

      initialVideoId:widget.link,
      flags: const YoutubePlayerFlags (
        autoPlay: true,
        hideControls: true,

        endAt: 0,
        // mute: true,
        showLiveFullscreenButton: false,
        loop: true
      ),
    )..addListener(listener);

    setState(() {
      videoController!.addListener(() {
        if (videoController!.value.isFullScreen) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        }
      });
    });

  }
  void listener() {
    if (_isPlayerReady && mounted && !videoController!.value.isFullScreen) {
      setState(() {
        _playerState = videoController!.value.playerState;
        _videoMetaData = videoController!.metadata;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: videoController!,
      showVideoProgressIndicator: false,
    );
  }
}