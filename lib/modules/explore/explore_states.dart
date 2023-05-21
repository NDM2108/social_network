import 'package:social_network/helpers/response/user_model.dart';

abstract class ExploreState {}

class ExploreInitialState extends ExploreState {}

class UsersList extends ExploreState {
  final List<User> users;

  UsersList({ required this.users });
}
