import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/modal/product.dart';

import '../widget/custom_textbutton.dart';
import '../widget/product_description.dart';
import '../widget/product_detail_header.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  itemCount: widget.product.image!.length,
                  itemBuilder: (context, index) => Hero(
                      tag: widget.product.image![index],
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.product.image![index],
                      )),
                  // Image(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(widget.product.image![index]),
                  //   ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Row(
                  children: List.generate(
                      widget.product.image!.length,
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ProductDetailHeader(
                    name: widget.product.name.toString(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ProductDescription(
                        description: widget.product.description.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          Expanded(child: getCategorySize()),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: getCategoryColor(),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            '\$${widget.product.price}' + '.00',
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
                ],
              ),
            )

            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Expanded(
            //             child: ProductDetailHeader(
            //           name: widget.product.name.toString(),
            //         )),
            //         // SizedBox(
            //         //   height: 10,
            //         // ),
            //         Divider(
            //           height: 1,
            //         ),
            //         Expanded(child: ProductDescription()),
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 10.0),
            //             child: Row(
            //               children: [
            //                 getCategorySize(),
            //                 SizedBox(
            //                   width: 20,
            //                 ),
            //                 Expanded(
            //                   child: getCategoryColor(),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         // SizedBox(
            //         //   height: 10,
            //         // ),
            //         Expanded(
            //           child: Row(
            //             children: [
            //               Text(
            //                 'Quantity',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 20,
            //                     fontFamily: 'Urbanist'),
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Material(
            //                 color: Color(0xFFF3F3F3),
            //                 borderRadius: BorderRadius.all(Radius.circular(25)),
            //                 child: Container(
            //                   width: 140,
            //                   height: 45,
            //                   decoration: BoxDecoration(
            //                       // color: Color(0xFFF3F3F3),
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(25))),
            //                   child: Row(children: [
            //                     Expanded(
            //                       child: IconButton(
            //                         splashRadius: 23,
            //                         icon: Icon(Icons.horizontal_rule),
            //                         onPressed: () {},
            //                       ),
            //                     ),
            //                     Expanded(
            //                       child: Center(
            //                           child: Text(
            //                         '3',
            //                         style: TextStyle(
            //                             fontSize: 20,
            //                             fontWeight: FontWeight.bold,
            //                             fontFamily: 'Urbanist'),
            //                       )),
            //                     ),
            //                     Expanded(
            //                       child: IconButton(
            //                         splashRadius: 23,
            //                         icon: Icon(Icons.add),
            //                         onPressed: () {},
            //                       ),
            //                     )
            //                   ]),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         // SizedBox(
            //         //   height: 10,
            //         // ),
            //         Divider(
            //           height: 1,
            //         ),
            //         // SizedBox(
            //         //   height: 10,
            //         // ),
            //         Expanded(
            //           child: Row(
            //             // mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text('Total price'),
            //                   SizedBox(
            //                     height: 5,
            //                   ),
            //                   Text(
            //                     '\$100.00',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 25,
            //                         fontFamily: 'Urbanist'),
            //                   )
            //                 ],
            //               ),
            //               Expanded(
            //                 child: Align(
            //                     alignment: Alignment.centerRight,
            //                     child: CustomTextButton(
            //                         onPressed: () {}, text: 'Add to Card')),
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
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
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SizeItem(index),
                  ))),
          // child: Row(
          //   children: List.generate(3, (index) => SizeItem(index)),
          // ),
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
}
