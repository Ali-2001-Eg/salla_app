import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/shop_app/login_screen _shop_app/login-screen_shopapp.dart';


import '../network/local/cache_helper.dart';
import '../styles/colors.dart';

//we can create a reusable component to determine team work
Widget defaultButton({
  //we initiate default value for this button and we can change it
  // double width = double.infinity,
  Color background = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(.5)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // width: width,
      child: MaterialButton(
        textColor: Colors.white,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        //function passed to the button
        onPressed: function(),
      ),
    );

Widget buildTaskItem(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {

      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),

            SizedBox(
              width: 20.0,
            ),

          ],
        ),
      ),
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
            ),
            Text('There is no data Please Add Archived Tasks',
                style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
      builder: (context) => ListView.separated(
          //it requires two functional Widget and requires an integer num to be item count to be listed
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: tasks.length),
    );



Widget myDevidor() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


void NavigateTo(context, Widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}

//to navigate and delete roots to prevent back step
void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false,
    );

void ShowToast({
  required message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context) => CacheHelper.clearData(key: 'token').then((value) {
      if (value) {
        NavigateAndFinish(context, ShopLoginSreen());
      }
    });
void printFullText(String? text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((element) {
    print(element.group(0));
  });
}

String auth = CacheHelper.getData(key: 'token');

Widget buildProductLists(model, context, {bool isSearch = false}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  '${model.image}',
                ),
                width: 120,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 30.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12.0, height: 1.5),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12.0, height: 1.5, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10.0,
                            height: 1.5,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
