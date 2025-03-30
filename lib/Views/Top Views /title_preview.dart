import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/data/Models/tmdb_models.dart';
import 'package:my_first_app/logic/api_data/api_data_cubit.dart';
import 'package:my_first_app/logic/api_data/api_data_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TitlePreview extends StatefulWidget {
  TitlePreview(this.item, {super.key}) {
    title = item.originalTitle ?? item.title ?? "No title";
    desc = item.overview ?? "...";
  }

  late YoutubePlayerController ytController;

  final Results item;

  late String title;
  late String desc;

  // const TitlePreview({super.key});

  @override
  State<TitlePreview> createState() => _TitlePreviewState();
}

class _TitlePreviewState extends State<TitlePreview> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YtCubit(widget.title),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<YtCubit, YtState>(
                builder: (context, state) {
                  if (state is YtLoadedState) {
                    print(state.id);
                    widget.ytController = YoutubePlayerController(
                        initialVideoId: state.id,
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                          loop: true,
                        ));
                    return Container(
                      height: 350,
                      child: YoutubePlayer(
                        controller: widget.ytController,
                        liveUIColor: Colors.amber,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   width: 180,
              //   height: 50,
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(18.0),
              //                 side: const BorderSide()))),
              //     onPressed: () {
              //       if (widget.ytController.value.volume == 0) {
              //         widget.ytController
              //             .pause(); //check if volume is already set to 0 (i.e mute)
              //         widget.ytController.setVolume(100);
              //       } else {
              //         widget.ytController.setVolume(0);
              //       }
              //     },
              //     child: const Text(
              //       "Unmute/Mute",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.desc,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   width: 180,
              //   height: 50,
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(18.0),
              //                 side: const BorderSide()))),
              //     onPressed: () {},
              //     child: const Text(
              //       "Bookmark",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.ytController.dispose();
    super.dispose(); // Have tried to use super.dispose below the close() also
  }
}

// class TitlePreview extends StatelessWidget {
  

//   @override
//   Widget 
// }
