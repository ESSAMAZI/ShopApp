// ignore_for_file: file_names, unrelated_type_equality_checks, dead_code, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          //تحديث البيانات عند الشاشه
          condition: //state is! ShopLoadingGetFavoritesState
              ShopCubit.get(context).favoritesModel != null,

          builder: (context) => ListView.separated(
              //physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buiderListProduct(
                  ShopCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data[index]
                      .product,
                  context),
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount:
                  ShopCubit.get(context).favoritesModel!.data!.data.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
