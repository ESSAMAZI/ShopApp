// ignore_for_file: non_constant_identifier_names, void_checks, avoid_types_as_parameter_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  double height = 40,
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormFiled(
        {required TextEditingController controller,
        required TextInputType type,
        //required Function onSubmit, //Add question mark
        void Function(String)? onSubmit,
        void Function(String)? onChange,
        void Function()? onTap,
        // required Function onChange, //Add question mark
        required Function validate,
        required String labelText,
        bool isPassword = false,
        required IconData prefixIcon,
        IconData? suffixIcon,
        void Function()? suffixPressed}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      //onFieldSubmitted: onSubmit != null ? onSubmit() : null, //do null checking
      // onChanged: onChange != null ? onChange() : null, //do null checking
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,

      // validator: (data) {
      //   if (data!.isEmpty) {
      //     return 'Filed is required';
      //   }
      //   return null;
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        //hintText: 'Email Address',
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

// Widget Buttonlogin({
//   double width = double.infinity,
//   double height = 50.0,
//   double borderRadius = 10.0,
//   @required String? TextLable,
//   required VoidCallback onPressed,
// }) =>
//     Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(borderRadius),
//         color: Colors.blue,
//       ),
//       child: MaterialButton(
//         onPressed: onPressed,
//         child: const Text(
//           'TextLable',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );

//داله الانتقال من شاشة الى اخرى
//فقط نرسل لها الشاشة
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

//تنهي الشاشة التي قبلها
void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
    //الغاء الصفحة السابقة
    (Route<dynamic> roue) => false);

Widget DefaulteTextButton(
        {required VoidCallback onPressed, required String text}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text),
    );

/// برمجه الاشعارات الرسائل الصغيرة السفليه
void ShowToast({required String text, required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//
//ProductData
Widget buiderListProduct(model, context,
        {bool isOldPrice = true, bool favor = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        //width: 120,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              //انزل نص التخفيض الى اسفل
              alignment: AlignmentDirectional.bottomStart,
              children: [
                // Image(
                //   image: NetworkImage(model.image!),
                //   width: 120,
                //   // fit: BoxFit.cover,
                //   height: 120.0,
                // ),
                FadeInImage(
                  placeholder: const AssetImage('assets/images/loading.png'),
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          // height: 1.3,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice.round()}',
                          //maxLines: 2,
                          //overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.0,
                            //height: 1.3,
                            color: Colors.grey,
                            //عمل خط اوشطب لنص
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      if (favor)
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
      ),
    );
