// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/categories_moadel.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => builderCateItem(
                  ShopCubit.get(context).categoriesModels!.data!.data[index]),
              separatorBuilder: (context, index) =>
                  Container(height: 1, width: 1, color: Colors.grey),
              itemCount:
                  ShopCubit.get(context).categoriesModels!.data!.data.length);
        });
  }

  Widget builderCateItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${model.name}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            //يحرك العنصر الى اخر شي
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
