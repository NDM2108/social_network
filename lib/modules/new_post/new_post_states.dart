import 'package:image_picker/image_picker.dart';

abstract class NewPostState {}

class NewPostInitialState extends NewPostState {}

class PostState extends NewPostState {
  XFile? image;
  String description;

  PostState({required this.image, required this.description});
}
  