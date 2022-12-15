// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register/shop_register_screen.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controllerEmail = TextEditingController();
    var controllerPassword = TextEditingController();

    return BlocProvider(
      create: (context) => Shop_Login_Cubit(),
      child: BlocConsumer<Shop_Login_Cubit, Shop_Login_States>(
        listener: (context, state) {
          //الاستماع و معرفة حاله الاتصال اذا ترو
          if (state is Shop_Login_Success_State) {
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
                navigateAndFinish(context, ShopLayout());
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),

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
                          suffixIcon: Shop_Login_Cubit.get(context).suffix,
                          suffixPressed: () {
                            Shop_Login_Cubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword:
                              Shop_Login_Cubit.get(context).isPasswordShow,
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
                              Shop_Login_Cubit.get(context).userLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                            }
                          },
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                          //حيث تكون حاله الاستيت
                          condition: state is! Shop_Login_Loadin_gState,
                          //انها لم تجلب البيانات رح تكون دائره الانتظار
                          //tru
                          builder: (context) => defaultButton(
                            radius: 7,
                            //height: 42,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //print('object');
                                // String psss = controllerPassword.text;
                                Shop_Login_Cubit.get(context).userLogin(
                                    email: controllerEmail.text,
                                    password: controllerPassword.text);
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          //false
                          fallback: (context) =>
                              //نوضع دائره في حل تنفيذ
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            DefaulteTextButton(
                                onPressed: () {
                                  navigateTo(context, Shop_Register_Screen());
                                },
                                text: 'Register')
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
