import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/modules/conversations/conversations_bloc.dart';
import 'package:social_network/modules/conversations/conversations_states.dart';

import '../../core/app_constants.dart';
import '../../helpers/widgets/app_bar.dart';
import '../../helpers/widgets/drawer.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final conversationsBloc = ConversationsBloc(ConversationsInitialStates(), Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: BlocProvider<ConversationsBloc>(
        create: (context) => conversationsBloc,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.pagePadding),
          child: Container()
        ),
      ),
    );
  }
}