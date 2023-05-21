import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/themes/app_text_styles.dart';

import '../../core/repository/api_paths.dart';
import '../../core/shared_preferences/shared_preferences_repository.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarPath = SharedPreferencesRepository().getUserInformation()?.user?.picturePath ?? '';
    final name = (SharedPreferencesRepository().getUserInformation()?.user?.firstName ?? '') +
        ' ' +
        (SharedPreferencesRepository().getUserInformation()?.user?.lastName ?? '');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 60,
                    height: 60,
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
                Text(
                  name,
                  style: AppTextStyles.boldBlack22,
                )
              ],
            ),
          ),
          ListTile(
            leading: SizedBox(
                width: 28, height: 28, child: SvgPicture.asset('assets/images/feed_icon.svg')),
            title: const Text('Feed'),
            onTap: () {
              context.pushReplacement('/feed');
            },
          ),
          ListTile(
            leading: SizedBox(
                width: 28, height: 28, child: SvgPicture.asset('assets/images/explore_icon.svg')),
            title: const Text('Explore'),
            onTap: () {
              context.pushReplacement('/explore');
            },
          ),
          ListTile(
            leading: SizedBox(
                width: 28, height: 28, child: SvgPicture.asset('assets/images/setting_icon.svg')),
            title: const Text(
              'Settings',
              style: AppTextStyles.normalGrey15,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: SizedBox(
                width: 28, height: 28, child: SvgPicture.asset('assets/images/logout_icon.svg')),
            title: const Text(
              'Logout',
              style: AppTextStyles.normalGrey15,
            ),
            onTap: () {
              SharedPreferencesRepository().clear();
              context.pushReplacement('/sign_in');
            },
          ),
        ],
      ),
    );
  }
}
