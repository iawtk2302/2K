import 'package:flutter/material.dart';
import 'package:sneaker_app/modal/product.dart';
import 'package:sneaker_app/screen/product_detail.dart';

class ItemProductWithoutAnim extends StatefulWidget {
  const ItemProductWithoutAnim({super.key, this.isLiked,required this.product});
  final product;
  final isLiked;
  @override
  State<ItemProductWithoutAnim> createState() => _ItemProductWithoutAnimState();
}

class _ItemProductWithoutAnimState extends State<ItemProductWithoutAnim> {
  late Product product;
  bool isLike = false;
  @override
  void initState() {
    isLike = widget.isLiked;
    product=widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        // Navigator.push(context,
        // MaterialPageRoute(builder: ((context) => ProductDetail())));
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
                          child: Hero(
                            tag: widget.product.image![0],
                            child: Image(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.product.image![0])),
                          ),
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
                          child: Container(
                            height: 60,
                            child: Text(
                              widget.product.name!.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              // softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              // textAlign: TextAlign.left,
                            ),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                            child: Text(
                              '\$' + '${widget.product.price}' + '.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
