// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/modules/login/shop_login_Screen.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class Shop_Register_Screen extends StatelessWidget {
  Shop_Register_Screen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controllerEmail = TextEditingController();
    var controllerPassword = TextEditingController();
    var controllerPhone = TextEditingController();
    var controllerName = TextEditingController();
    return BlocProvider(
      create: (context) => Shop_Register_Cubit(),
      child: BlocConsumer<Shop_Register_Cubit, Shop_Register_States>(
        listener: (context, state) {
          //الاستماع و معرفة حاله الاتصال اذا ترو
          if (state is Shop_Register_Success_State) {
            if (state.loginmodel.status!) {
              //print(state.loginmodel.message);
              // print('token');
              //print(state.loginmodel.data!.token);
              //جلب التوكن
              ShowToast(
                  text: state.loginmodel.message!, states: ToastStates.SUCCESS);
              CacheHelper.saveDatas(
                key: 'token',
                value: state.loginmodel.data!.token,
              ).then((value) {
                token = state.loginmodel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              //print(state.loginmodel.message);
              ShowToast(
                  states: ToastStates.ERROR, text: state.loginmodel.message!);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'REGISTER now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
                        // الاسم
                        defaultTextFormFiled(
                            controller: controllerName,
                            type: TextInputType.name,
                            validate: (String Value) {
                              if (Value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            labelText: 'Users Name',
                            prefixIcon: Icons.person),
                        const SizedBox(height: 20),
                        // الهاتف
                        defaultTextFormFiled(
                            controller: controllerPhone,
                            type: TextInputType.phone,
                            validate: (String Value) {
                              if (Value.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            labelText: 'Phone Number',
                            prefixIcon: Icons.phone),
                        const SizedBox(height: 20),
                        //الايميل
                        defaultTextFormFiled(
                            controller: controllerEmail,
                            type: TextInputType.emailAddress,
                            validate: (String Value) {
                              if (Value.isEmpty) {
                                return 'please enter your email Address';
                              }
                            },
                            labelText: 'EMAIL Address',
                            prefixIcon: Icons.email),
                        const SizedBox(height: 20),
                        //كلمه
                        defaultTextFormFiled(
                          controller: controllerPassword,
                          suffixIcon: Shop_Register_Cubit.get(context).suffixR,
                          suffixPressed: () {
                            Shop_Register_Cubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword:
                              Shop_Register_Cubit.get(context).isPasswordShow,
                          type: TextInputType.visiblePassword,
                          validate: (String Value) {
                            if (Value.isEmpty) {
                              return 'Password is too short  ';
                            }
                          },
                          labelText: 'Password',
                          onSubmit: (vlue) {
                            if (formKey.currentState!.validate()) {
                              //print('object');
                              Shop_Register_Cubit.get(context).userRegister(
                                  email: controllerEmail.text,
                                  name: controllerName.text,
                                  phone: controllerPhone.text,
                                  password: controllerPassword.text);
                            }
                          },
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                          //حيث تكون حاله الاستيت
                          condition: state is! Shop_Register_Loadin_State,
                          //انها لم تجلب البيانات رح تكون دائره الانتظار
                          //tru
                          builder: (context) => defaultButton(
                            radius: 7,
                            //height: 42,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //print('object');
                                // String psss = controllerPassword.text;
                                Shop_Register_Cubit.get(context).userRegister(
                                    email: controllerEmail.text,
                                    name: controllerName.text,
                                    phone: controllerPhone.text,
                                    password: controllerPassword.text);
                              }
                            },
                            text: 'REGISTER',
                            isUpperCase: true,
                          ),
                          //false
                          fallback: (context) =>
                              //نوضع دائره في حل تنفيذ
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do  have an account?'),
                            DefaulteTextButton(
                                onPressed: () {
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: 'Login')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
