import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/custom_textbutton.dart';
import '../widget/product_description.dart';
import '../widget/product_detail_header.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

List<Color> ColorData = [
  Colors.black,
  Colors.purple,
  Colors.brown,
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.pink,
];
List<int> sizeData = [31, 32, 33];

class _ProductDetailState extends State<ProductDetail> {
  int currentIndex = 0;
  int indexSize = 0;
  int indexColor = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (() {
              Navigator.pop(context);
            }),
          )),
      body: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2 - 150,
              child: PageView.builder(
                onPageChanged: (value) => {
                  print(value),
                  setState(() {
                    currentIndex = value;
                  })
                },
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/09087d4d-6300-44ad-be5f-6e9ebf8d3790/infinity-run-3-air-x-hola-lou-mens-road-running-shoes-1bRq75.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Row(
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.black
                                    : Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            height: 10,
                            width: currentIndex == index ? 25 : 10,
                          ),
                        )),
              ),
            )
          ]),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ProductDetailHeader()),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Divider(
                    height: 1,
                  ),
                  Expanded(child: ProductDescription()),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          getCategorySize(),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: getCategoryColor(),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Urbanist'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Material(
                          color: Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Container(
                            width: 140,
                            height: 45,
                            decoration: BoxDecoration(
                                // color: Color(0xFFF3F3F3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Row(children: [
                              Expanded(
                                child: IconButton(
                                  splashRadius: 23,
                                  icon: Icon(Icons.horizontal_rule),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: Text(
                                  '3',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Urbanist'),
                                )),
                              ),
                              Expanded(
                                child: IconButton(
                                  splashRadius: 23,
                                  icon: Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Divider(
                    height: 1,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total price'),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$100.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: 'Urbanist'),
                            )
                          ],
                        ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: CustomTextButton(
                                  onPressed: () {}, text: 'Add to Card')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column getCategoryColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Urbanist'),
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ColorItem(index),
                  ))),
        )
      ],
    );
  }

  InkWell ColorItem(int index) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      onTap: () {
        setState(() {
          indexColor = index;
        });
      },
      child: Stack(children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: ColorData[index],
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        if (indexColor == index)
          Container(
            height: 40,
            width: 40,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
      ]),
    );
  }

  Widget getCategorySize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Urbanist'),
        ),
        Expanded(
          child: Row(
            children: List.generate(3, (index) => SizeItem(index)),
          ),
        )
      ],
    );
  }

  Padding SizeItem(index) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            indexSize = index;
          });
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: index == indexSize ? Colors.black : Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '${sizeData[index]}',
              style: TextStyle(
                  color: indexSize == index ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
