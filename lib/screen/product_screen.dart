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
              height: 40,
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
