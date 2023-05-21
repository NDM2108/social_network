import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network/modules/new_post/new_post_events.dart';
import 'package:social_network/modules/new_post/new_post_states.dart';

import '../../core/repository/repository.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  Repository repository;
  XFile? image;
  String description = '';

  NewPostBloc(NewPostState initialState, this.repository) : super(initialState) {
    on<AddImage>(_addImage);
    on<ChangeDescription>(_changeDescription);
    on<NewPost>(_newPost);
  }

  void _addImage(AddImage event, Emitter<NewPostState> emit) async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(PostState(image: image, description: description));
    }
  }

  void _changeDescription(ChangeDescription event, Emitter<NewPostState> emit) async {
    description = event.description;
  }

  void _newPost(NewPost event, Emitter<NewPostState> emit) async {
    if (image != null) {
      repository.newPost(description, image!.path, image!.name);
    }
  }
}
