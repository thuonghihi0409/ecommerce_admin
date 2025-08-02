import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/video/presentation/widget/video_item_widget.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final PageController _pageController = PageController();

  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://www.w3schools.com/html/mov_bbb.mp4',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.blackColor,
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          backgroundColor: Colors.transparent,
          showLeading: false,
        ),
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: videoUrls.length,
          itemBuilder: (context, index) {
            return VideoPlayerWidget(videoUrl: videoUrls[index]);
          },
        ),
      );
    });
  }
}
