import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/screen/product_screen.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/product/product_bloc.dart';
import 'contact_us.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});
  // final
  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Brand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        state.listBrand.length - 1,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: BrandItem(
                                icon: state.listBrand[index].imageUrl!,
                                text: state.listBrand[index].name!.tr,
                                onPress: () {
                                  context.read<ProductBloc>().add(LoadProduct(
                                      idBrand: state.listBrand[index].id!,
                                      context: context,
                                      gender: ["Women", "Men"],
                                      sortBy: SortBy.none));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => ProductScreen(
                                                brand: state.listBrand[index],
                                              ))));
                                },
                              ),
                            ))),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  const BrandItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final String icon;
  final String text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all(Color.fromARGB(255, 225, 224, 224)),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22)),
      ),
      onPressed: () {
        onPress();
      },
      child: Row(children: [
        Image(
          height: 30,
          width: 30,
          fit: BoxFit.scaleDown,
          image: NetworkImage(icon.toString()),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: const TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              fontFamily: 'Urbanist'),
        ),
      ]),
    );
  }
}
