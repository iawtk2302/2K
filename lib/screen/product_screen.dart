import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/item_product.dart';
import 'HomePage.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

List<Map<String, String>> catagoryBrand = [
  {'name': 'Men'},
  {'name': 'Woman'},
  {'name': 'Kids'},
  {'name': 'Jordan'},
  // {'name': 'Balenciaga'},
  // {'name': 'Converse'},
  // {'name': 'New balance'},
  // {'name': 'More'},
];

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  int isChoose = 0;

  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Nike',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 16),
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catagoryBrand.length,
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
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    10,
                    (int index) {
                      final int count = 10;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return ItemProduct(
                        isLiked: false,
                        animation: animation,
                        animationController: animationController,
                        callBack: () {},
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
