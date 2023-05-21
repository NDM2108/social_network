abstract class NewPostEvent {}

class AddImage extends NewPostEvent {}

class NewPost extends NewPostEvent {}

class ChangeDescription extends NewPostEvent {
  String description;

  ChangeDescription({required this.description});
}