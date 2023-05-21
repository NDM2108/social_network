import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/app_constants.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/helpers/widgets/custom_text_field.dart';
import 'package:social_network/helpers/widgets/user_item.dart';
import 'package:social_network/modules/explore/explore_bloc.dart';
import 'package:social_network/modules/explore/explore_states.dart';

import '../../helpers/widgets/app_bar.dart';
import '../../helpers/widgets/drawer.dart';
import 'explore_events.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final textController = TextEditingController();
  final exploreBloc = ExploreBloc(ExploreInitialState(), Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: BlocProvider<ExploreBloc>(
        create: (context) => exploreBloc,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: AppTextStyles.boldBlack18,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                hintText: 'Find someone',
                textEditingController: textController,
                onSubmitted: (value) {
                  exploreBloc.add(SearchName(name: value));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is UsersList) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return UserItem(user: state.users[index]);
                        },
                      ),
                    );
                  }
                  return Container();
                },
                listener: (context, state) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
