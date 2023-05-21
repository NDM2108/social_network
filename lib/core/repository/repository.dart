import 'package:dio/dio.dart';
import 'package:social_network/core/repository/api_paths.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';

import '../../helpers/response/feed_model.dart';

class Repository {
  final Dio dio = Dio();

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  Future<Response> register(Map<String, dynamic> data) async {
    final Response reponse = await dio.post(ApiPaths.register, data: data);
    return reponse;
  }

  Future<Response> login(Map<String, dynamic> data) async {
    final Response reponse = await dio.post(ApiPaths.login, data: data);
    return reponse;
  }

  Future<Response> getFeedPosts(int page, int pageSize) async {
    final Response reponse = await dio.get(ApiPaths.getFeedPosts,
        queryParameters: {
          'page': page,
          'pageSize': pageSize
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> getUserInfo(String userId) async {
    final Response reponse = await dio.get(ApiPaths.userInfomation + userId,
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> getUserFeedPosts(String userId) async {
    final Response reponse = await dio.get(ApiPaths.getUserPosts(userId),
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> like(String postId, String userId) async {
    final Response reponse = await dio.patch(ApiPaths.likePost(postId),
        data: {"userId": userId},
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> comment(String postId, String content) async {
    final user = SharedPreferencesRepository().getUserInformation()?.user!;
    final comment = Comment(
            postId: postId,
            userId: user?.id,
            userFirstName: user?.firstName,
            userLastName: user?.lastName,
            userPicturePath: user?.picturePath,
            content: content)
        .toJson();
    final Response reponse = await dio.patch(ApiPaths.commentPost(postId),
        data: comment,
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> addOrRemoveFriend(String userId) async {
    final Response reponse = await dio.patch(
        ApiPaths.userInfomation +
            (SharedPreferencesRepository().getUserInformation()?.user?.id ?? '') +
            '/' +
            userId,
        data: {"userId": userId},
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> newPost(String description, String picturePath, String pictureName) async {
    final file = await MultipartFile.fromFile(picturePath);
    FormData formData = FormData.fromMap({
      "userId": SharedPreferencesRepository().getUserInformation()?.user?.id,
      "description": description,
      "picturePath": pictureName,
      "picture": file,
    });
    final Response reponse = await dio.post(ApiPaths.newPost,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> searchName(String name) async {
    final Response reponse = await dio.post(ApiPaths.userInfomation,
        data: {"search": name},
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }

  Future<Response> getUserConversations(String userId) async {
    final Response reponse = await dio.get(ApiPaths.conversations + userId,
        options: Options(headers: {
          'Authorization': 'Bearer ${SharedPreferencesRepository().getAccessToken()}'
        }));
    return reponse;
  }
}
