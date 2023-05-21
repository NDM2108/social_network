class FeedModel {
    List<Post>? posts;

    FeedModel({
        this.posts,
    });

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}

class Post {
    List<Comment>? comments;
    String? id;
    String? userId;
    String? firstName;
    String? lastName;
    String? picturePath;
    String? userPicturePath;
    String? location;
    String? description;
    Map<String, bool>? likes;
    DateTime? createdAt;
    DateTime? updatedAt;

    Post({
        this.comments,
        this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.picturePath,
        this.userPicturePath,
        this.location,
        this.description,
        this.likes,
        this.createdAt,
        this.updatedAt,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        id: json["_id"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picturePath: json["picturePath"],
        userPicturePath: json["userPicturePath"],
        location: json["location"],
        description: json["description"],
        likes: Map.from(json["likes"]!).map((k, v) => MapEntry<String, bool>(k, v)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "_id": id,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "picturePath": picturePath,
        "userPicturePath": userPicturePath,
        "location": location,
        "description": description,
        "likes": Map.from(likes!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Comment {
    String? id;
    String? postId;
    String? userId;
    String? userPicturePath;
    String? userFirstName;
    String? userLastName;
    String? content;

    Comment({
        this.id,
        this.postId,
        this.userId,
        this.userPicturePath,
        this.userFirstName,
        this.userLastName,
        this.content,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        postId: json["postId"],
        userId: json["userId"],
        userPicturePath: json["userPicturePath"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "userId": userId,
        "userPicturePath": userPicturePath,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "content": content,
    };
}
