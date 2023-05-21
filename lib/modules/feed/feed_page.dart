import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/modules/feed/feed_bloc.dart';
import 'package:social_network/modules/feed/feed_events.dart';
import 'package:social_network/modules/feed/feed_states.dart';
import 'package:social_network/modules/feed/post_item.dart';

import '../../core/repository/repository.dart';
import '../../helpers/response/feed_model.dart';
import '../../helpers/widgets/app_bar.dart';
import '../../helpers/widgets/drawer.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final scrollController = ScrollController();
  final feedBloc = FeedBloc(
    FeedInitialState(),
    Repository(),
  );

  @override
  void initState() {
    scrollController.addListener(() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        feedBloc.add(GetFeedPosts());
      }
    }
  });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.feedBackground,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: BlocProvider<FeedBloc>(
          create: (context) => feedBloc..add(GetFeedPosts()),
          child: BlocConsumer<FeedBloc, FeedState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FeedPostState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    feedBloc.add(GetFeedPosts());
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 16, left: 16),
                            child: Text(
                              'Feed',
                              style: AppTextStyles.boldBlack22,
                            ),
                          )),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            state.feed.posts?.length != null ? state.feed.posts!.length + 1 : 0,
                        itemBuilder: (context, index) {
                          if (index != state.feed.posts!.length) {
                            return PostItem(
                              post: state.feed.posts?[index] ?? Post(),
                              onLike: () {
                                feedBloc.add(LikePost(postId: state.feed.posts?[index].id ?? ''));
                              },
                              onComment: (value) {
                                feedBloc.add(CommentPost(
                                    postId: state.feed.posts?[index].id ?? '', content: value));
                              },
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      )
                    ]),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
