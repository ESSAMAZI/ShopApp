// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';

import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';

import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';

class SetttingsScreen extends StatelessWidget {
  SetttingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Shop_Login_Cubit()..getUserData(),
      child: BlocConsumer<Shop_Login_Cubit, Shop_Login_States>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = Shop_Login_Cubit.get(context).usermodel;

          return ConditionalBuilder(
            condition: Shop_Login_Cubit.get(context).usermodel != null,
            builder: (context) {
              nameController.text = model!.data!.name!;
              emailController.text = model.data!.email!;
              phoneController.text = model.data!.phone!;

              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateUserState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 15),
                      defaultTextFormFiled(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String Value) {
                            if (Value.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                          labelText: 'Name',
                          prefixIcon: Icons.person),
                      const SizedBox(height: 15),
                      defaultTextFormFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String Value) {
                            if (Value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          labelText: 'Email',
                          prefixIcon: Icons.email),
                      const SizedBox(height: 15),
                      defaultTextFormFiled(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String Value) {
                            if (Value.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                          labelText: 'Phone',
                          prefixIcon: Icons.phone_android),
                      const SizedBox(height: 15),
                      defaultButton(
                          onPressed: () {
                            ///
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).PostUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'Update',
                          radius: 10),
                      const SizedBox(height: 15),
                      defaultButton(
                          onPressed: () {
                            singOut(context);
                          },
                          text: 'Logout',
                          radius: 10),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
