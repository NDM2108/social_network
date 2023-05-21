import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';

import '../../core/repository/api_paths.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarPath = SharedPreferencesRepository().getUserInformation()?.user?.picturePath ?? '';
    final userId = SharedPreferencesRepository().getUserInformation()?.user?.id ?? '';
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        'Instello',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset('assets/images/messages_icon.svg')),
        GestureDetector(
          onTap: () {
            context.push('/user_feed?userId=$userId');
          },
          child: Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  ApiPaths.assets + (avatarPath),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/user.png');
                  },
                  fit: BoxFit.cover,
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
