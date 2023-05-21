import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/modules/feed/post_item.dart';
import 'package:social_network/modules/user_feed/user_feed_bloc.dart';
import 'package:social_network/modules/user_feed/user_feed_events.dart';
import 'package:social_network/modules/user_feed/user_feed_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/repository/api_paths.dart';
import '../../core/repository/repository.dart';
import '../../helpers/response/feed_model.dart';
import '../../helpers/response/user_model.dart';
import '../../helpers/widgets/app_bar.dart';
import '../../helpers/widgets/custom_button.dart';
import '../../helpers/widgets/drawer.dart';

class UserFeedPage extends StatefulWidget {
  final String userId;

  const UserFeedPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserFeedPage> createState() => _UserFeedPageState();
}

class _UserFeedPageState extends State<UserFeedPage> {
  final userFeedBloc = UserFeedBloc(UserFeedInitialState(), Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.feedBackground,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: BlocProvider<UserFeedBloc>(
          create: (context) => userFeedBloc..add(GetUserFeedPosts(userId: widget.userId)),
          child: BlocConsumer<UserFeedBloc, UserFeedState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is UserFeedPostState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    userFeedBloc.add(GetUserFeedPosts(userId: widget.userId));
                  },
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              ApiPaths.assets + (state.userInfo.picturePath ?? ''),
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/user.png');
                              },
                              fit: BoxFit.cover,
                            ),
                          )),
                      Text(
                        (state.userInfo.firstName ?? '') + ' ' + (state.userInfo.lastName ?? ''),
                        style: AppTextStyles.boldBlack22,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: isMyFeed()
                            ? SizedBox(
                                height: 40,
                                width: 200,
                                child: CustomButton(
                                  onPressed: () {
                                    context.push('/new_post');
                                  },
                                  text: AppLocalizations.of(context)!.signIn,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: CustomButton(
                                      onPressed: () {
                                        userFeedBloc.add(AddOrRemoveFriend(userId: widget.userId));
                                      },
                                      color: isFriend(state.userInfo) ? AppColors.greyTextColor : null,
                                      text: 'Kết bạn',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: CustomButton(
                                      onPressed: () {
                                        context.push(
                                            '/chat?userId=${widget.userId}&userName=${(state.userInfo.firstName ?? '') + ' ' + (state.userInfo.lastName ?? '')}');
                                      },
                                      text: 'Nhắn tin',
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.feed.posts?.length ?? 0,
                        itemBuilder: (context, index) {
                          return PostItem(post: state.feed.posts?[index] ?? Post());
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

  bool isMyFeed() {
    return widget.userId == SharedPreferencesRepository().getUserInformation()?.user?.id;
  }

  bool isFriend(User user) {
    if (user.friends == null || user.friends!.isEmpty) {
      return false;
    }
    return user.friends!.contains(SharedPreferencesRepository().getUserInformation()?.user?.id);
  }
}
