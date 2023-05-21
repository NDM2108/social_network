class ApiPaths {
  static const String register = 'https://api.instello.me/auth/register';
  static const String login = 'https://api.instello.me/auth/login';
  static const String getFeedPosts = 'https://api.instello.me/posts';
  static const String assets = 'https://api.instello.me/assets/';
  static const String userInfomation ='https://api.instello.me/users/';
  static const String newPost ='https://api.instello.me/posts/';
  static const String conversations ='https://api.instello.me/conversations/';
  static const String socket = 'http://localhost:8900';

  static String getUserPosts(String userId) => 'https://api.instello.me/posts/$userId/';
  static String likePost(String postId) => 'https://api.instello.me/posts/$postId/like';
  static String commentPost(String postId) => 'https://api.instello.me/comments/$postId/insertComment';
}