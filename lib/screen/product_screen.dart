import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/modal/brand.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/product/product_bloc.dart';
import '../widget/item_product.dart';
import 'HomePage.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.brand});
  final Brand brand;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

// List<Map<String, String>> catagoryBrand = [
//   {'name': 'Men'},
//   {'name': 'Woman'},
//   {'name': 'Kids'},
//   {'name': 'Jordan'},
//   // {'name': 'Balenciaga'},
//   // {'name': 'Converse'},
//   // {'name': 'New balance'},
//   // {'name': 'More'},
// ];

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  int isChoose = 0;

  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    context
        .read<ProductBloc>()
        .add(LoadProduct(idBrand: widget.brand.id, context: context));
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
            // context.read<ProductBloc>()..emit(ProductLoading());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.brand.name.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Loading();
          } else if (state is ProductLoaded) {
            Future.delayed(Duration(seconds: 1));
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, bottom: 16, left: 16),
                  child: SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listCategory.length,
                      itemBuilder: ((context, index) => Row(
                            children: [
                              InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                onTap: () {
                                  setState(() {
                                    isChoose = index;
                                  });
                                  context.read<ProductBloc>().add(ReLoadProduct(
                                      listCategory: state.listCategory,
                                      context: context,
                                      idCategory: state
                                          .listCategory[index].idCategory!));
                                },
                                child: BrandItem(
                                  name: state.listCategory[index].name!,
                                  isChoose: isChoose,
                                  index: index,
                                ),
                              ),
                              const SizedBox(
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
                          state.listProduct.length,
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
                              product: state.listProduct[index],
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
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
