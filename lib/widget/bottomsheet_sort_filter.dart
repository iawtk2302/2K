import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/widget/custom_textbutton.dart';

import '../bloc/product/product_bloc.dart';

class BottomSheet_Sort_Filter extends StatefulWidget {
  const BottomSheet_Sort_Filter(
      {super.key,
      required this.index,
      required this.sortBy,
      required this.listGender});
  final int index;
  final SortBy sortBy;
  final List<String> listGender;
  @override
  State<BottomSheet_Sort_Filter> createState() =>
      _BottomSheet_Sort_FilterState();
}

class _BottomSheet_Sort_FilterState extends State<BottomSheet_Sort_Filter> {
  SortBy? _character = SortBy.none;
  Map<String, bool> isChecked = {
    "Men": false,
    "Women": false,
    // "Unisex": false,
  };
  @override
  void initState() {
    _character = widget.sortBy;
    print(widget.listGender);
    widget.listGender.forEach((element) {
      isChecked.update(element.toString(), (value) => true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Sort & Filter'.tr,
                      style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sort by'.tr,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 35,
                  //   child: RadioListTile<SortBy>(
                  //     activeColor: Theme.of(context).primaryIconTheme.color,
                  //     title: const Text('Featured'),
                  //     value: SortBy.featured,
                  //     groupValue: _character,
                  //     contentPadding: const EdgeInsets.all(0),
                  //     onChanged: (SortBy? value) {
                  //       setState(() {
                  //         _character = value;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 35,
                  //   child: RadioListTile<SortBy>(
                  //     activeColor: Theme.of(context).primaryIconTheme.color,
                  //     title: const Text('Newest'),
                  //     value: SortBy.newest,
                  //     groupValue: _character,
                  //     contentPadding: const EdgeInsets.all(0),
                  //     onChanged: (SortBy? value) {
                  //       setState(() {
                  //         _character = value;
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile<SortBy>(
                      activeColor: Theme.of(context).primaryIconTheme.color,
                      title: Text('Price: Low-High'.tr),
                      value: SortBy.lowHigh,
                      groupValue: _character,
                      contentPadding: const EdgeInsets.all(0),
                      onChanged: (SortBy? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile<SortBy>(
                      activeColor: Theme.of(context).primaryIconTheme.color,
                      title: Text('Price: High-Low'.tr),
                      value: SortBy.highLow,
                      groupValue: _character,
                      contentPadding: const EdgeInsets.all(0),
                      onChanged: (SortBy? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 10,
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Gender'.tr,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context).primaryColor,
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).primaryIconTheme.color),
                          value: isChecked['Men'],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked['Men'] = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Men'.tr)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context).primaryColor,
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).primaryIconTheme.color),
                          value: isChecked['Women'],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked['Women'] = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Women'.tr)
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  //   child: Row(
                  //     children: [
                  //       Checkbox(
                  //         checkColor: Theme.of(context).primaryColor,
                  //         activeColor: Theme.of(context).primaryColor,
                  //         fillColor: MaterialStateProperty.all(
                  //             Theme.of(context).primaryIconTheme.color),
                  //         value: isChecked['Unisex'],
                  //         onChanged: (bool? value) {
                  //           setState(() {
                  //             isChecked['Unisex'] = value!;
                  //           });
                  //         },
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text('Unisex')
                  //     ],
                  //   ),
                  // ),
                ]),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3 + 20,
                            child: CustomTextButton(
                              onPressed: () {},
                              text: 'Reset'.tr,
                              hasLeftIcon: false,
                              isDark: false,
                              hasRightIcon: false,
                            )),
                        Container(
                            // height: 80,
                            width: MediaQuery.of(context).size.width / 3 + 20,
                            child: CustomTextButton(
                              onPressed: () {
                                List<String> listGender = [];
                                isChecked.forEach((key, value) {
                                  if (value == true) {
                                    listGender.add(key);
                                  }
                                });
                                Navigator.pop(context);
                                context.read<ProductBloc>().add(ReLoadProduct(
                                        context: context,
                                        gender: listGender,
                                        listCategory: state.listCategory,
                                        sortBy: _character!,
                                        idCategory: state
                                            .listCategory[widget.index]
                                            .idCategory
                                            .toString())
                                    // Sort_Filter_Product(
                                    //       listCategory: state.listCategory,
                                    //       listProduct: state.listProduct,
                                    //       sortBy: _character!,
                                    //       gender: listGender,
                                    //       context: context)
                                    );
                              },
                              text: 'Apply'.tr,
                              hasLeftIcon: false,
                              isDark: true,
                              hasRightIcon: false,
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
