import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/favorite/favorite_bloc.dart';
import '../widget/item_product.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
        title: const Text('Favorite'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Loading();
          } else if (state is FavoriteLoaded) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                  ),
                  children: List<Widget>.generate(
                    state.products.length,
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
                        product: state.products[index],
                      );
                    },
                  ),
                ));
          }
          return Container();
        },
      ),
    );
  }
}
