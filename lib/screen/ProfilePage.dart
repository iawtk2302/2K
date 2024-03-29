// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/ChooseAddressProfilePage.dart';
import 'package:sneaker_app/screen/edit_profile.dart';
import 'package:sneaker_app/screen/help_center.dart';
import 'package:sneaker_app/screen/security.dart';
import 'package:sneaker_app/screen/update_profile.dart';
import 'package:sneaker_app/service/FirebaseService.dart';
import 'package:sneaker_app/themes/LanguageService.dart';
import 'package:sneaker_app/widget/custom_switch_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/home/user_bloc.dart';
import '../themes/ThemeService.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Profile'.tr,
            style: const TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Urbanist'),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const SizedBox();
              } else if (state is UserExist) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(state.user.image!, scale: 1),
                          ),
                        ),
                        // Positioned(
                        //     bottom: 2,
                        //     right: 5,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: Theme.of(context).primaryIconTheme.color,
                        //       ),
                        //       height: 22,
                        //       width: 22,
                        //       child: IconButton(
                        //           // focusColor: Colors.black,
                        //           padding: EdgeInsets.zero,
                        //           iconSize: 15,
                        //           onPressed: () {},
                        //           splashRadius: 15,
                        //           // style: ButtonStyle(),
                        //           icon: Icon(
                        //             Icons.border_color,
                        //             color: Theme.of(context).primaryColor,
                        //           )),
                        //     ))
                      ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${state.user.firstName!} ${state.user.lastName!}',
                      style: const TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          fontFamily: 'Urbanist'),
                    ),
                    Text(
                      state.user.phone!,
                      style: const TextStyle(
                          // color: Colors.black,
                          // fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Urbanist'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final userState = state as UserExist;
              final user = userState.user;
              return ItemProfile(
                leftIcon: Icons.person_outline,
                label: 'Edit Profile'.tr,
                rightIcon: Icons.chevron_right,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfile(user: user),
                      ));
                },
              );
            },
          ),
          ItemProfile(
            leftIcon: Icons.mode_of_travel,
            label: 'Address'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              // Navigator.pushNamed(context, Routes.chooseAddress);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          const ChooseAddressProfilePage())));
            },
          ),
          ItemProfile(
            leftIcon: Icons.security,
            label: 'Security'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Security())));
            },
          ),
          ItemProfile(
            leftIcon: Icons.language,
            label: 'Language'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              LocalizationService().switchLang();
            },
          ),
          ItemProfile(
            leftIcon: Icons.dark_mode,
            label: 'Dark Mode'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              ThemeService().switchTheme();
            },
          ),
          ItemProfile(
            leftIcon: Icons.lock_outline,
            label: 'Privacy Police'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () async {
              final Uri _url = Uri.parse(
                  'https://agreementservice.svs.nike.com/gb/en_gb/rest/agreement?agreementType=privacyPolicy&uxId=com.nike.unite&country=GB&language=en&requestType=redirect');
              if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
              }
            },
          ),
          ItemProfile(
            leftIcon: Icons.help_outline,
            label: 'Help Center'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpCenter(),
                  ));
            },
          ),
          ItemProfile(
            leftIcon: Icons.logout,
            label: 'Sign out'.tr,
            rightIcon: Icons.chevron_right,
            onPress: () {
              signOut();
            },
          ),
        ],
      )),
    );
  }
}

class ItemProfile extends StatelessWidget {
  const ItemProfile({
    Key? key,
    required this.leftIcon,
    required this.rightIcon,
    required this.label,
    required this.onPress,
  }) : super(key: key);
  final IconData leftIcon;
  final IconData rightIcon;
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Icon(leftIcon),
              const SizedBox(
                width: 16,
              ),
              Text(
                label,
                style: const TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Urbanist'),
              ),
            ],
          ),
          Row(
            children: [
              if (label == 'Language' || label == 'Ngôn ngữ')
                Text(
                  label == 'Language' ? 'English (US)' : 'Vietnamese (VN)',
                  style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Urbanist'),
                ),
              if (label != 'Dark Mode' && label != 'Chế độ tối')
                IconButton(
                  icon: Icon(rightIcon),
                  onPressed: () {
                    onPress();
                  },
                )
              else
                const CustomSwitchButton()
            ],
          )
        ]),
      ),
    );
  }
}

signOut() {
  FirebaseService().signOut();
}
