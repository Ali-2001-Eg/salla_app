import 'package:ali/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_cubit/cubit.dart';
import '../../../layout/shop_app/shop_cubit/states.dart';

class ShopFavoritesScreen extends StatelessWidget {
  ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: state is! ShopLoadingGetFavouritesState,
        builder: (context) {
          return ListView.separated(
            itemBuilder: (context, index) => buildProductLists(
                cubit.favouritesModel!.data!.favData[index].product!, context),
            separatorBuilder: (context, index) => myDevidor(),
            itemCount: cubit.favouritesModel!.data!.favData.length,
          );
        },
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
