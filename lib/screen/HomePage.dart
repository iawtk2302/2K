import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';

import '../widget/ItemProductWithoutAnim.dart';
import '../widget/brandCatagoty.dart';
import '../widget/custom_search.dart';
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
              backgroundImage:
                  // height: 100,
                  // width: 100,
                  NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL.toString()),
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
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Andrew Ainsley',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CustomSearch(
                    hintText: 'Search',
                    icon: Icon(Icons.search),
                    isPassword: true),
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
                  Text('See all',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Urbanist'))
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
              Row(children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:
                              440 / MediaQuery.of(context).size.width,
                          crossAxisCount: 2,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: ((context, index) => BrandCatagory(
                              imgUri: catagoryBrand[index]['imgUri']!,
                              name: catagoryBrand[index]['name']!,
                            ))),
                  ),
                ),
              ]),
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
                  Text('See all',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Urbanist'))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: ((context, index) => BrandItem(
                          name: catagoryBrand[index]['name']!,
                          isChoose: isChoose,
                          index: index,
                        )),
                  )),
              SizedBox(
                height: 20,
              ),

              // Container(
              //   height: 150,
              //   child: PageView.builder(
              //       itemBuilder: ((context, index) => Container(
              //             height: 100,
              //             color: Colors.red,
              //             child: Text(index.toString()),
              //           ))),
              // )

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
            ]),
          ),
        ));
  }
}

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
        margin: EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.9),
            color: isChoose == index ? Colors.black : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: InkWell(
          onTap: () {},
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
          ),
        ));
  }
}
