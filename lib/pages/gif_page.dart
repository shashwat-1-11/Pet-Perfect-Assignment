import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_assignment/blocs/gif_bloc/gif_bloc.dart';
import 'package:pet_perfect_assignment/models/gif_model.dart';
import 'package:video_player/video_player.dart';
import 'dummy_page.dart';

class GIFPage extends StatefulWidget {
  const GIFPage({Key? key}) : super(key: key);

  @override
  _GIFPageState createState() => _GIFPageState();
}

class _GIFPageState extends State<GIFPage> {

  final GIFBloc _newsBloc = GIFBloc();
  late VideoPlayerController controller;
  bool isLoaded = false;

  @override
  void initState() {
    _newsBloc.add(GetGIF());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIF Page'),
      ),
      body: _buildGIF(),
      floatingActionButton: Visibility(
        visible: isLoaded,
        child: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage()));
          }
        ),
      ),
    );
  }
  Widget _buildGIF(){
    return Center(
      child: Container(
        child: BlocProvider(
          create: (_) => _newsBloc,
          child: BlocListener<GIFBloc, GIFState>(
            listener: (context, state) {
              if (state is GIFError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<GIFBloc, GIFState>(
              builder: (context, state) {
                if (state is GIFInitial) {
                  return _buildLoading();
                } else if (state is GIFLoading) {
                  return _buildLoading();
                } else if (state is GIFLoaded) {
                  Future.delayed(Duration.zero, () async {
                    setState(() {
                      isLoaded = true;
                    });
                  });
                  return _buildLoadedGIF(context, state.gifModel);
                } else if (state is GIFError) {
                  return Container();
                } else {
                  return Container();
                }
              }
            )
          )
        ),
      ),
    );
  }

  Widget _buildLoadedGIF(BuildContext context, GIFModel model){
    var lastCharacter = model.url![model.url!.length - 1];
    if(lastCharacter == 'g' || lastCharacter == 'G'){
      print('rendering image');
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Image(
            image: NetworkImage(model.url!),

        ),
      );
    }else{
      print('rendering a video');
      late VideoPlayerController controller;
      Future<void> video;
      controller = VideoPlayerController.network(model.url!);
      video = controller.initialize();
      return FutureBuilder(
        future: video,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return InkWell(
                onTap: (){
                  if (controller.value.isPlaying) {
                    setState(() {
                      print('pausing video');
                      controller.pause();
                    });
                  } else {
                    setState(() {
                      print('playing video');
                      controller.play();
                    });
                  }
                },
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              );
            } else{
              return CircularProgressIndicator();
            }
          }
      );

    }
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());


}
