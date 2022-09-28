import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../bloc/brand_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../widget/item_product_without_anim.dart';
import '../widget/brandCatagoty.dart';
import '../widget/custom_searchbar.dart';
import '../widget/item_SpecialOffer.dart';
import 'SearchScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Map<String, String>> catagoryBrand = [
  {
    'imgUri': 'https://cdn-icons-png.flaticon.com/512/732/732229.png',
    'name': 'Nike'
  },
  {
    'imgUri': 'https://cdn-icons-png.flaticon.com/128/732/732160.png',
    'name': 'Adidas'
  },
  {
    'imgUri': 'https://cdn-icons-png.flaticon.com/128/47/47137.png',
    'name': 'Puma'
  },
  {
    'imgUri':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Vans-logo.svg/2560px-Vans-logo.svg.png',
    'name': 'Vans'
  },
  {
    'imgUri':
        'https://logos-world.net/wp-content/uploads/2021/08/Balenciaga-Logo.png',
    'name': 'Balenciaga'
  },
  {
    'imgUri':
        'https://1000logos.net/wp-content/uploads/2016/12/Converse-Logo-2007.png',
    'name': 'Converse'
  },
  {
    'imgUri':
        'https://brademar.com/wp-content/uploads/2022/05/New-Balance-Logo-PNG-2008-%E2%80%93-Now-2.png',
    'name': 'New balance'
  },
  {
    'imgUri': 'https://cdn-icons-png.flaticon.com/512/8469/8469246.png',
    'name': 'More'
  },
];

class _HomePageState extends State<HomePage> {
  int isChoose = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              // backgroundImage:
              //     // height: 100,
              //     // width: 100,
              //     NetworkImage(
              //         FirebaseAuth.instance.currentUser!.photoURL.toString()),
            ),
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(
                      color: Color(0xFF757475),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Andrew Ainsley',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                )
              ]),
          actions: [
            IconButton(
              splashRadius: 10,
              onPressed: () {},
              icon: Icon(
                Ionicons.notifications_outline,
                size: 25,
                color: Colors.black,
              ),
            ),
            IconButton(
              splashRadius: 10,
              onPressed: () {},
              icon: Icon(
                Ionicons.heart_outline,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading)
                return HomeLoad();
              else if (state is HomeLoaded)
                return HomeLoadCompleted(state);
              else
                return Scaffold();
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
          child: CustomSearchBar(
              hintText: 'Search', icon: Icon(Icons.search), isPassword: true),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Special Offers',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Urbanist')),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {},
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
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
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {
                print('aa');
              },
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      color: Colors.black)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: ((context, index) => Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          setState(() {
                            isChoose = index;
                          });
                        },
                        child: BrandItem(
                          name: catagoryBrand[index]['name']!,
                          isChoose: isChoose,
                          index: index,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  )),
            )),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    return ItemProductWithoutAnim(isLiked: true);
                  }),
                ),
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

  Padding HomeLoadCompleted(HomeLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CustomSearchBar(
              hintText: 'Search', icon: Icon(Icons.search), isPassword: true),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Special Offers',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Urbanist')),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {},
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      color: Colors.black)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Item_SpecialOffer(
          percentDiscount: '25%',
          imgUri:
              'https://www.banlegiasistore.com/images/upload/icon-image/photo-1542291026-7eec264c27ff.jpg',
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
            Text('More Popular',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Urbanist')),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 238, 234, 234))),
              onPressed: () {
                print('aa');
              },
              child: Text('See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      color: Colors.black)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: ((context, index) => Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          setState(() {
                            isChoose = index;
                          });
                        },
                        child: BrandItem(
                          name: catagoryBrand[index]['name']!,
                          isChoose: isChoose,
                          index: index,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  )),
            )),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    return ItemProductWithoutAnim(isLiked: true);
                  }),
                ),
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
              itemBuilder: ((context, index) => BrandCatagory(
                    imgUri: state.listBrand[index].imageUrl,
                    name: state.listBrand[index].name,
                  ))),
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
            border: Border.all(color: Colors.black, width: 1.9),
            color: isChoose == index ? Colors.black : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            name,
            style: TextStyle(
                color: isChoose == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
                fontSize: 16),
          ),
        ));
  }
}
