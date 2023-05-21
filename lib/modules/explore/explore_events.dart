abstract class ExploreEvent {}

class SearchName extends ExploreEvent {
  final String name;

  SearchName({required this.name});
}