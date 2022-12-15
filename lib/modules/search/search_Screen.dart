// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var foxrKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: foxrKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormFiled(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }
                      },
                      labelText: 'search',
                      prefixIcon: Icons.search,
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    const SizedBox(height: 15),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 15),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            //physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buiderListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data[index],
                                context,
                                isOldPrice: false,
                                favor: false),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 5),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data
                                .length),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
