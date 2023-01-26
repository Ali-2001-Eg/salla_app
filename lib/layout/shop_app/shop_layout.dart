import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:ali/modules/shop_app/search/search_screen.dart';
import 'package:ali/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, ShopSearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_sharp),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            onTap: (int index) {
              cubit.changeIndex(index);
            },
            //required to mark the selected item
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
