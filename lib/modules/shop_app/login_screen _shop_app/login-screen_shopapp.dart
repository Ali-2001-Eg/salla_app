import 'package:ali/layout/shop_app/shop_layout.dart';
import 'package:ali/modules/shop_app/cubit/cubit/cubit.dart';
import 'package:ali/modules/shop_app/cubit/states/states.dart';
import 'package:ali/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/components.dart';
import '../register_screen/shop_register_screen.dart';

class ShopLoginSreen extends StatelessWidget {
  ShopLoginSreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          listener: (context, state) {
        if (state is ShopLoginSuccessState) {
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
              auth = state.loginModel.data.token!;
              NavigateAndFinish(context, const ShopLayout());
            });
          } else {
            ShowToast(
                message: state.loginModel.message, state: ToastState.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
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
                        decoration: InputDecoration(
                          labelText: 'email address',
                          hintText: 'email address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        obscureText:
                            ShopLoginCubit.get(context).isPasswordShown,
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
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopLoginCubit.get(context)
                                  .changeSuffixAndObscureText();
                            },
                            icon: Icon(
                              ShopLoginCubit.get(context).suffix,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text(
                                'login'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Don't have an account"),
                          TextButton(
                              onPressed: () {
                                NavigateTo(context, ShopRegisterScreen());
                              },
                              child: Text('Register Now'.toUpperCase()))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
