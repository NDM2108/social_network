import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/repository/api_paths.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/modules/feed/comment_item.dart';

import '../../helpers/response/feed_model.dart';
import '../../helpers/widgets/custom_text_field.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final Function(String)? onComment;
  final Function()? onLike;

  const PostItem({Key? key, required this.post, this.onComment, this.onLike}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/user_feed?userId=${widget.post.userId}');
            },
            child: Row(
              children: [
                Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        ApiPaths.assets + (widget.post.userPicturePath ?? ''),
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/user.png');
                        },
                        fit: BoxFit.cover,
                      ),
                    )),
                Text(
                  (widget.post.firstName ?? '') + ' ' + (widget.post.lastName ?? ''),
                  style: AppTextStyles.boldBlack15,
                )
              ],
            ),
          ),
          widget.post.description != null
              ? Padding(padding: const EdgeInsets.all(8), child: Text(widget.post.description!))
              : Container(),
          Image.network(
            ApiPaths.assets + (widget.post.picturePath ?? ''),
            errorBuilder: (context, error, stackTrace) => Container(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onLike,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          'assets/images/like_icon.svg',
                          color: checkLiked() ? AppColors.primary : Colors.black,
                        ),
                      ),
                    ),
                    Text(checkLiked() ? 'Liked' : 'Like'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset('assets/images/comment_icon.svg'),
                    ),
                    const Text('Comment'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset('assets/images/share_icon.svg'),
                    ),
                    const Text('Share')
                  ],
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              (widget.post.likes?.length ?? 0).toString() + ' Likes',
              style: AppTextStyles.normalGrey15,
            ),
          ),
          widget.post.comments != null && widget.post.comments!.isNotEmpty
              ? const Divider(thickness: 1)
              : Container(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.post.comments?.length ?? 0,
            itemBuilder: (context, index) {
              return CommentItem(comment: widget.post.comments![index]);
            },
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: CustomTextField(
                height: 46,
                borderRadius: 25,
                hintText: 'Add your comment',
                textEditingController: commentTextController,
                onSubmitted: (value) {
                  commentTextController.text = '';
                  if (widget.onComment != null) {
                    widget.onComment!(value);
                  }
                }),
          ),
        ],
      ),
    );
  }

  bool checkLiked() {
    if (widget.post.likes == null) {
      return false;
    }
    return widget.post.likes!
        .containsKey(SharedPreferencesRepository().getUserInformation()?.user?.id);
  }
}
