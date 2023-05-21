import 'package:flutter/material.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/helpers/response/feed_model.dart';

import '../../core/repository/api_paths.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  ApiPaths.assets + (comment.userPicturePath ?? ''),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/user.png');
                  },
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: AppColors.commentBackground),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Align(alignment: Alignment.centerLeft, child: Text(comment.content ?? '')),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
