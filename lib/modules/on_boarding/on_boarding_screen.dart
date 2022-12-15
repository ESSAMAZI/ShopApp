// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/shop_login_Screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/boardingModel.dart';

class OnBoadingScreen extends StatefulWidget {
  const OnBoadingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoadingScreen> createState() => _OnBoadingScreenState();
}

class _OnBoadingScreenState extends State<OnBoadingScreen> {
  // التنقل بين عناصر الترحيب بزر
  var boardController = PageController();

//استدعاء مودل خاص بقائمه الترحيب
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding_1.PNG',
      title: 'تسوق اونلاين ',
      body: 'كل ما ترغب به موجود تحت سقف واحد',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_2.PNG',
      title: 'اضف ما تريد',
      body: 'اضف ما تريد من منتجات الى السله الخاصه بك',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_3.PNG',
      title: 'تسوق وتمتع بتخفيضات ',
      body: ' تسوق وتابع جديد المنتجات العالميه تمتع بتخفيضات كبرى',
    ),
  ];

// الوصول الى اخر القائمه الترحيب
  bool isList = false;

  void submit() {
    CacheHelper.saveDatas(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DefaulteTextButton(
              onPressed: () {
                submit();
              },
              text: 'Skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            //توسيط
            Expanded(
              // نمط الترحيب
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if (value == boarding.length - 1) {
                    setState(() {
                      isList = true;
                    });
                    //اذا وصل الى النهايه

                  } else {
                    setState(() {
                      isList = false;
                    });
                  }
                },
                //يحتوي على صور وعلى ونصوص
                itemBuilder: (context, index) =>
                    buildBoardingItems(boarding[index]),
                // عدد الصوه التي تتحرك
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                // Text('data'),
                //ايقونه التنقل
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey, //لون الدوائر
                    activeDotColor: Colors.blue, //لون المستطيل
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 7, //المسافة بين الدوائره
                    expansionFactor: 4, // طول المستطيل
                  ),
                ),
                // مسافةجانبية
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isList) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
//التصميم

  Widget buildBoardingItems(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // PageView.builder(itemBuilder: (context, index) => ),
          Expanded(
              child: Image(
            image: AssetImage(model.image),
            width: double.infinity,
          )),
          SizedBox(height: 10),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
}
