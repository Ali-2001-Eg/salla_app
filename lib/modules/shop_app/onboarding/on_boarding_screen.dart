import 'package:ali/shared/components/components.dart';
import 'package:ali/shared/network/local/cache_helper.dart';
import 'package:ali/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_screen _shop_app/login-screen_shopapp.dart';

class BoardingModel {
  final String title;
  final String image;
  final String body;

  BoardingModel({required this.title, required this.image, required this.body});
}

bool isLast = false;

//stateful because it doesn't need bloc provider
//the only change is set state to the last page to
// ensure that the third page is the last to prevent scrolling
class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //to catch the page while navigation
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'on board title 1 ',
        image: 'images/on_boarding_1.jpg',
        body: 'on board body 1'),
    BoardingModel(
        title: 'on board title 2 ',
        image: 'images/on_boarding_1.jpg',
        body: 'on board body 2'),
    BoardingModel(
        title: 'on board title 3 ',
        image: 'images/on_boarding_1.jpg',
        body: 'on board body 3'),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true)
        //is bool
        .then((value) => NavigateAndFinish(context, ShopLoginSreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  //the page controller
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      activeDotColor: defaultColor,
                      expansionFactor: 4.0,
                      dotWidth: 10.0,
                      spacing: 5.0),
                ),
                //to position the last element in the last space
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
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
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
