import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/helpers/widgets/custom_button.dart';
import 'package:social_network/helpers/widgets/custom_text_field.dart';
import 'package:social_network/modules/new_post/new_post_bloc.dart';
import 'package:social_network/modules/new_post/new_post_events.dart';
import 'package:social_network/modules/new_post/new_post_states.dart';

import '../../core/repository/repository.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_text_styles.dart';
import '../../helpers/widgets/app_bar.dart';
import '../../helpers/widgets/drawer.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final newPostBloc = NewPostBloc(NewPostInitialState(), Repository());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.feedBackground,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: BlocProvider<NewPostBloc>(
          create: (context) => newPostBloc,
          child: BlocConsumer<NewPostBloc, NewPostState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'New post',
                        style: AppTextStyles.boldBlack18,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'What do you think',
                            textEditingController: textController,
                            onChanged: (value) {
                              newPostBloc.add(ChangeDescription(description: value));
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              newPostBloc.add(AddImage());
                            },
                            icon: const Icon(Icons.image_rounded))
                      ],
                    ),
                    state is PostState
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(File(state.image!.path))))
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                          width: double.infinity, height: 50, child: CustomButton(onPressed: () {
                            newPostBloc.add(NewPost());
                          }, text: 'Post')),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
