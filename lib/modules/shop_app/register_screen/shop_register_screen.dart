import 'package:ali/modules/shop_app/login_screen%20_shop_app/login-screen_shopapp.dart';
import 'package:ali/modules/shop_app/register_screen/cubit/cubit/cubit.dart';
import 'package:ali/modules/shop_app/register_screen/cubit/states/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                //عشان ناكد ان لما بينتخلص من التوكن يحفظ هنا التوكن الجديد
                auth = state.loginModel.data.token!;
                NavigateAndFinish(context, ShopLoginSreen());
              });
            } else {
              ShowToast(
                  message: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'register'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'register now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'user name is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'user name',
                              hintText: 'user name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'email is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'email address',
                              hintText: 'email address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            onFieldSubmitted: (value) {},
                            obscureText:
                                ShopRegisterCubit.get(context).isPasswordShown,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'password',
                              hintText: 'password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ShopRegisterCubit.get(context)
                                      .changeSuffixAndObscureText();
                                },
                                icon: Icon(
                                  ShopRegisterCubit.get(context).suffix,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone is too short';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'phone',
                              hintText: 'phone',
                              border: OutlineInputBorder(),
                              prefixIcon: const Icon(
                                Icons.phone,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (context) => Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text);
                                    }
                                  },
                                  child: Text(
                                    'register'.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        ],
                      ),
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
