import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:ali/models/shop_app/categories_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCategorySreen extends StatelessWidget {
  const ShopCategorySreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).categoriesModel != null,
        builder: (context) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildCatItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
