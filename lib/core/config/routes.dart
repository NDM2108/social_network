import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/modules/chat_room/chat_room.dart';
import 'package:social_network/modules/conversations/conversations_page.dart';
import 'package:social_network/modules/explore/explore_page.dart';
import 'package:social_network/modules/new_post/new_post_page.dart';
import 'package:social_network/modules/sign_in/sign_in_page.dart';

import '../../modules/feed/feed_page.dart';
import '../../modules/sign_up/sign_up_page.dart';
import '../../modules/user_feed/user_feed_page.dart';
import '../shared_preferences/shared_preferences_repository.dart';

class Routes {
  static GoRouter router = GoRouter(
    initialLocation: SharedPreferencesRepository().getAccessToken() != null ? '/feed' : '/sign_in',
    routes: <RouteBase>[
      GoRoute(
        path: '/sign_in',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: '/sign_up',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: '/feed',
        builder: (BuildContext context, GoRouterState state) {
          return const FeedPage();
        },
      ),
      GoRoute(
        path: '/user_feed',
        builder: (BuildContext context, GoRouterState state) {
          return UserFeedPage(userId: state.queryParameters['userId'] ?? '');
        },
      ),
      GoRoute(
        path: '/new_post',
        builder: (BuildContext context, GoRouterState state) {
          return const NewPostPage();
        },
      ),
      GoRoute(
        path: '/explore',
        builder: (BuildContext context, GoRouterState state) {
          return const ExplorePage();
        },
      ),
      GoRoute(
        path: '/conversations',
        builder: (BuildContext context, GoRouterState state) {
          return const ConversationsPage();
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (BuildContext context, GoRouterState state) {
          return ChatRoom(
            userId: state.queryParameters['userId'] ?? '',
            userName: state.queryParameters['userName'] ?? '',
          );
        },
      ),
    ],
  );
}
