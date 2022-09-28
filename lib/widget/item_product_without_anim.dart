import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/screen/product_detail.dart';

class ItemProductWithoutAnim extends StatefulWidget {
  const ItemProductWithoutAnim({super.key, this.isLiked});
  final isLiked;
  @override
  State<ItemProductWithoutAnim> createState() => _ItemProductWithoutAnimState();
}

class _ItemProductWithoutAnimState extends State<ItemProductWithoutAnim> {
  bool isLike = false;
  @override
  void initState() {
    isLike = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => ProductDetail())));
      },
      // width: MediaQuery.of(context).size.width / 2,
      // height: 275,
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Stack(children: [
            Container(
              // decoration: const BoxDecoration(color: Color(0xFFF3F3F3)),
              height: 180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: const Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/09087d4d-6300-44ad-be5f-6e9ebf8d3790/infinity-run-3-air-x-hola-lou-mens-road-running-shoes-1bRq75.png')),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 50,
                width: 50,
                child: IconButton(
                  splashRadius: 20,
                  icon: isLike
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      isLike = !isLike;
                    });
                  },
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Spacer(),
              Expanded(
                child: const Text(
                  'K-Swiss Vista Train',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  // textAlign: TextAlign.left,
                ),
              ),
              // const Spacer(),
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                    ),
                    const Spacer(),
                    const Text(
                      '4.5 |',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFECEDEC),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          '7.483 sold',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // const Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    '\$110.00',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              // const Spacer()
            ],
          ),
        )
      ]),
    );
  }
}
