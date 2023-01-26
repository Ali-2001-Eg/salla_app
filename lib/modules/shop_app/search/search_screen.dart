import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopErrorSearchState,
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Search Page'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: searchController,
                          validator: (value) {
                            if (value!.isEmpty) return 'search can\'t be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('search'),
                            hintText: 'search',
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .getSearchData(searchController.text);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (state is ShopLoadingSearchState)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 10),
                        if (state is ShopSuccessSearchState)
                          Expanded(
                              child: ListView.separated(
                            itemBuilder: (context, index) => buildProductLists(
                                cubit.searchModel!.data!.searchData[index],
                                context),
                            separatorBuilder: (context, index) => myDevidor(),
                            itemCount:
                                cubit.searchModel!.data!.searchData.length,
                          ))
                      ],
                    ),
                  ),
                )),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
