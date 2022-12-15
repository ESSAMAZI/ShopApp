// ignore_for_file: file_names, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/categories_moadel.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/modules/description/description_Screen.dart';
import 'package:shopapp/shared/components/components.dart';

class ProdeutsScreen extends StatelessWidget {
  const ProdeutsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.modelF.status!) {
            ShowToast(text: state.modelF.message!, states: ToastStates.ERROR);
          }
          if (state.modelF.status!) {
            ShowToast(text: state.modelF.message!, states: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homemodel != null &&
              ShopCubit.get(context).categoriesModels != null,
          builder: (context) {
            //في حاله جلب البيانات
            return buiderWidget(ShopCubit.get(context).homemodel!,
                ShopCubit.get(context).categoriesModels!, context);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buiderWidget(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //شاشه العروض التي تمرر
          CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => FadeInImage(
                      // child: Image(
                      //   image: NetworkImage('${e.image}'),
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      //   height: 200,
                      // ),
                      placeholder:
                          const AssetImage('assets/images/loading.png'),
                      image: NetworkImage(
                        '${e.image}',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          //end شاشه العروض
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'categories',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                //الاقسام
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      //التمرير من الجوانب
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCateogreyItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: categoriesModel.data!.data.length),
                ),
                //end الاقسام
                const SizedBox(height: 10),
                const Text(
                  'New Products',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // المنتجات
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // print('object');
              navigateTo(context, const descriptionScreean());
            },
            child: Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                //حل مشاكل المساحه الفارغة بين العناصر
                crossAxisCount: 2, //2 جنب بعض
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                // المساحة
                childAspectRatio: 1 / 1.4,
                // اضافة صوره ومعلومات المنتج
                children: List.generate(
                  model.data!.products.length, //طول المنتجات
                  (index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
              ),
            ),
          )
        ]),
      );
  //صور المنتجات
  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        // height: 50,
        // width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              //انزل نص التخفيض الى اسفل
              alignment: AlignmentDirectional.bottomStart,
              children: [
                // Image(
                //   image: NetworkImage(model.image!),
                //   width: double.infinity,
                //   //  fit: BoxFit.contain,
                //   height: 150.0,
                // ),
                FadeInImage(
                  placeholder: const AssetImage('assets/images/loading.png'),
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 150.0,
                ),
                if (model.discount != 0)
                  // اضافه علامه انه عليه تخفيض
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              //معلومات الصنف
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        //    maxLines: 2,
                        //  overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          //  height: 1.3,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          //  maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.0,
                            //   height: 1.3,
                            color: Colors.grey,
                            //عمل خط اوشطب لنص
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          //ازله الحواف
                          // padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context).changeFavrites(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]!
                                    ? Colors.blue
                                    : Colors.grey,
                            radius: 15.0,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 14,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

//صور الاقسام
  Widget buildCateogreyItem(DataModel model) => Stack(
        //انزال النص الى اسفل
        alignment: AlignmentDirectional.bottomCenter,

        children: [
          Image(
            image: NetworkImage(model.image!),
            height: 100.0,
            width: 100.0,
          ),
          Container(
              color: Colors.black.withOpacity(.8),
              width: 100,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      );
}
