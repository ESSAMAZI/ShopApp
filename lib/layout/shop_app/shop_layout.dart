import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/modules/search/search_Screen.dart';
import 'package:shopapp/shared/components/components.dart';
//import 'package:shopapp/shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitshop = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            //ايقونه بحث
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubitshop.bottomScreens[cubitshop.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubitshop.bottomitems,
            currentIndex: cubitshop.currentIndex,
            onTap: (index) {
              cubitshop.changeBottom(index);
              // print('token = = $token');
            },
          ),
        );
      },
    );
  }
}
