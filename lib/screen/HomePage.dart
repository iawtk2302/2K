import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sneaker_app/bloc/favorite/favorite_bloc.dart';
import 'package:sneaker_app/model/User.dart';
import 'package:sneaker_app/model/favorite.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/NotificationPage.dart';
import 'package:sneaker_app/screen/set_fingerprint.dart';
import 'package:sneaker_app/themes/ThemeService.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/user_bloc.dart';
import '../model/notification.dart';
import '../widget/CustomSearch.dart';
import '../widget/item_product_without_anim.dart';
import '../widget/brandCatagoty.dart';
import '../widget/custom_searchbar.dart';
import '../widget/item_SpecialOffer.dart';
import 'SearchScreen.dart';
import 'SpecialOffer.dart';
import 'enter_pin_code.dart';
import 'favorite_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final time = DateTime.now().hour;
  String? quote;
  getAmountNoti() async {}
  late int amountNoti = 0;
  @override
  void initState() {
    // BlocProvider.of<UserBloc>(context).add(LoadInfoUser());
    // BlocProvider.of<HomeBloc>(context).add(LoadHome());
    _checkTime();
    super.initState();
  }

  int isChoose = 0;
  _onTapSearchbar(BuildContext context) {
    Navigator.pushNamed(context, Routes.search);
  }

  _checkTime() {
    if (time > 6 && time <= 12) {
      quote = "Good Morning".tr;
    } else if (time > 12 && time < 18) {
      quote = "Good Afternoon".tr;
    } else {
      quote = "Good Everning".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserExist) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        // height: 100,
                        // width: 100,
                        NetworkImage(state.user.image.toString()),
                  );
                } else if (state is UserLoading) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote!.tr,
                  style: TextStyle(
                      // color: Color(0xFF757475),
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserExist) {
                      // print(state.user.firstName.toString());
                      return Text(
                        state.user.firstName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      );
                    } else if (state is UserLoading) {
                      return Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ]),
          actions: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserExist) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationPage(),
                            ));
                      },
                      child: const Icon(
                        Ionicons.notifications_outline,
                        size: 25,
                        // color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            IconButton(
              splashRadius: 10,
              onPressed: () async {
                List<Favorite> favorites = [];
                Customer user =
                    (context.read<UserBloc>().state as UserExist).user;
                await FirebaseFirestore.instance
                    .collection('Favorite')
                    .where('idUser', isEqualTo: user.idUser)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    favorites.add(Favorite.fromJson(element.data()));
                    print(element.data());
                  });
                }).then((value) => context.read<FavoriteBloc>()
                      ..add(LoadProductFavorite(favorites: favorites)));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ));
              },
              icon: const Icon(
                Ionicons.heart_outline,
                size: 25,
                // color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return HomeLoad();
              } else if (state is HomeLoaded) {
                return homeLoadCompleted(state);
              } else {
                return const Scaffold();
              }
            },
          ),
        ));
  }

  Padding HomeLoad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CustomSearch(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.tune),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Special Offers'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {},
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 180,
            decoration: BoxDecoration(
                color: Color(0xFFECECEC),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container()),
        SizedBox(
          height: 20,
        ),
        BrandCatagoryLoading(),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('More Popular',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Urbanist')),
            TextButton(
              // style: ButtonStyle(
              //     overlayColor: MaterialStateProperty.all(
              //         Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {
                // print('aa');
              },
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // SizedBox(
        //     height: 38,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 8,
        //       itemBuilder: ((context, index) => Row(
        //             children: [
        //               InkWell(
        //                 borderRadius: BorderRadius.all(Radius.circular(20)),
        //                 onTap: () {
        //                   setState(() {
        //                     isChoose = index;
        //                   });
        //                 },
        //                 child: BrandItem(
        //                   name: [index]['name']!,
        //                   isChoose: isChoose,
        //                   index: index,
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 8,
        //               )
        //             ],
        //           )),
        //     )),
        SizedBox(
          height: 20,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: SizedBox(
        //         child: GridView.count(
        //           physics: NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           mainAxisSpacing: 20,
        //           childAspectRatio: 0.65,
        //           crossAxisSpacing: 10,
        //           crossAxisCount: 2,
        //           children: List.generate(4, (index) {
        //             return ItemProductWithoutAnim(isLiked: true);
        //           }),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: 50,
        )
      ]),
    );
  }

  Padding homeLoadCompleted(HomeLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CustomSearch(
            hintText: 'Search'.tr,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            suffixIcon: Icon(Icons.tune,
                color: Theme.of(context).primaryIconTheme.color),
            onTap: () => _onTapSearchbar(context),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Special Offers'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SpecialOffer(listBanner: state.banner)));
              },
              child: Text('See all'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Item_SpecialOffer(
          imgUri: state.banner[Random().nextInt(state.banner.length - 1)].image,
        ),
        SizedBox(
          height: 20,
        ),
        BrandCatagoryLoaded(context, state),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('More Popular'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Urbanist')),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {
                // print('aa');
              },
              child: Text('See all'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  )),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // SizedBox(
        //     height: 38,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 8,
        //       itemBuilder: ((context, index) => Row(
        //             children: [
        //               InkWell(
        //                 borderRadius: BorderRadius.all(Radius.circular(20)),
        //                 onTap: () {
        //                   setState(() {
        //                     isChoose = index;
        //                   });
        //                 },
        //                 child: BrandItem(
        //                   name: state.listBrand[index].name,
        //                   isChoose: isChoose,
        //                   index: index,
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 8,
        //               )
        //             ],
        //           )),
        //     )),
        // SizedBox(
        //   height: 20,
        // ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: state.listProduct
                        .map((e) => ItemProductWithoutAnim(
                              isLiked: false,
                              product: e,
                            ))
                        .toList()),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        )
      ]),
    );
  }

  Row BrandCatagoryLoaded(BuildContext context, HomeLoaded state) {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 200,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 440 / MediaQuery.of(context).size.width,
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: state.listBrand.length,
              itemBuilder: ((context, index) =>
                  BrandCategory(brand: state.listBrand[index]))),
        ),
      ),
    ]);
  }

  Row BrandCatagoryLoading() {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 200,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 440 / MediaQuery.of(context).size.width,
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: ((context, index) => Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFECECEC),
                        child: Container(
                          height: 30,
                          width: 30,
                        ),
                        padding: EdgeInsets.all(12.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 45,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Theme.of(context).highlightColor,
                        ),
                      )
                    ],
                  ))),
        ),
      ),
    ]);
  }
}
// BlocBuilder<BrandBloc, BrandState>(
//                 builder: (context, state) {
//                   if (state is BrandLoading) {
//                     return BrandCatagoryLoading(context, state);
//                   } else if (state is BrandLoaded) {
//                     return BrandCatagoryLoaded(context, state);
//                   } else {
//                     return Scaffold();
//                   }
//                 },
//               ),

class BrandItem extends StatelessWidget {
  const BrandItem({
    Key? key,
    required this.name,
    required this.isChoose,
    required this.index,
  }) : super(key: key);
  final String name;
  final int isChoose;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color:ThemeService().theme==ThemeMode.light ?Colors.black: Theme.of(context).canvasColor, width: 1.9),
            color:ThemeService().theme==ThemeMode.light ?isChoose == index ?Colors.black:Colors.transparent: isChoose == index ? Theme.of(context).canvasColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            name.tr,
            style: TextStyle(
                color:ThemeService().theme==ThemeMode.light ? isChoose == index ? Colors.white : Colors.black:Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ));
  }
}
