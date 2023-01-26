import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:ali/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class ShopSettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return profileBuilder(context, state);
      },
    );
  }

  Widget profileBuilder(context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null,
        builder: (context) {
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data.name!;
          phoneController.text = model.data.phone!;
          emailController.text = model.data.email!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    myDevidor(),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                    ),
                    myDevidor(),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                    ),
                    myDevidor(),
                    Container(
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(.5)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.maxFinite,
                      child: MaterialButton(
                        textColor: Colors.white,
                        child: Text(
                          'update'.toUpperCase(),
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                    ),
                    myDevidor(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(.5)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.maxFinite,
                      child: MaterialButton(
                        textColor: Colors.white,
                        child: Text(
                          'logout'.toUpperCase(),
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        //function passed to the button
                        onPressed: () {
                          signOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
}
