// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/model/order.dart';

import '../bloc/home/user_bloc.dart';

class DeliveryAddress extends StatelessWidget {
  final MyOrder order;
  const DeliveryAddress({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 25,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Delivery Address'.tr,
                style: TextStyle(
                    
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserExist) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            state.user.firstName! + " " + state.user.lastName!),
                        Text(state.user.phone!),
                        Text(
                          order.detailAddress!,
                          // maxLines: 3,
                          // textAlign: TextAlign.left,
                          // overflow: TextOverflow.ellipsis,
                        )
                      ]),
                );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
