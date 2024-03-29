import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/bottomsheet_sort_filter.dart';

import '../bloc/product/product_bloc.dart';
import '../model/brand.dart';
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
    // context.read<ProductBloc>().add(LoadProduct(
    //     idBrand: widget.brand.id,
    //     context: context,
    //     gender: [],
    //     sortBy: SortBy.featured));
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // context.read<ProductBloc>()..emit(ProductLoading());
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    // color: Colors.white,
                  ),
                ),
                title: Text(
                  widget.brand.name!.toUpperCase(),
                  // style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        // showModalBottomSheet(
                        //     isScrollControlled: true,
                        //     backgroundColor: Colors.transparent,
                        //     context: context,
                        //     builder: (context) {
                        //       return BottomSheet_Sort_Filter(
                        //         index: isChoose,
                        //         listGender: [],
                        //         sortBy: SortBy.featured,
                        //       );
                        //     });
                      },
                      icon: const Icon(
                        Icons.tune,
                        // color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              body: const Loading());
        } else if (state is ProductLoaded) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                // systemOverlayStyle: SystemUiOverlayStyle(
                //   // Status bar color
                //   statusBarColor: Theme.of(context).scaffoldBackgroundColor,

                //   // Status bar brightness (optional)
                //   statusBarIconBrightness:
                //       Brightness.dark, // For Android (dark icons)
                //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
                // ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // context.read<ProductBloc>()..emit(ProductLoading());
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    // color: Colors.black,
                  ),
                ),
                title: Text(
                  widget.brand.name!.toUpperCase(),
                  // style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return BottomSheet_Sort_Filter(
                                index: isChoose,
                                listGender: state.gender,
                                sortBy: state.sortBy,
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.tune,
                        // color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              body: Column(
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
                                    context.read<ProductBloc>().add(
                                        ReLoadProduct(
                                            gender: state.gender,
                                            sortBy: state.sortBy,
                                            listCategory: state.listCategory,
                                            context: context,
                                            idCategory: state
                                                .listCategory[index]
                                                .idCategory!));
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                          ),
                          children: List<Widget>.generate(
                            state.listProduct.length,
                            (int index) {
                              const int count = 8;
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
                        )),
                  ),
                ],
              ));
        } else {
          return Container();
        }
      },
    );
  }
}
