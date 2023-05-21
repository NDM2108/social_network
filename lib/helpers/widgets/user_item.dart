import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/helpers/response/user_model.dart';

import '../../core/repository/api_paths.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.textFieldBorder),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          context.push('/user_feed?userId=${user.id}');
        },
        child: Row(
          children: [
            Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    ApiPaths.assets + (user.picturePath ?? ''),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/user.png');
                    },
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              (user.firstName ?? '') + ' ' + (user.lastName ?? ''),
              style: AppTextStyles.normalBlack16,
            )
          ],
        ),
      ),
    );
  }
}
