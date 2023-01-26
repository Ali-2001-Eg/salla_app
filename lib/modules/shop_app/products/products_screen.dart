import 'package:ali/layout/shop_app/shop_cubit/cubit.dart';
import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:ali/models/shop_app/categories_model.dart';
import 'package:ali/models/shop_app/home_model.dart';
import 'package:ali/shared/components/components.dart';
import 'package:ali/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider is in the main
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavState) {
          if (!(state.favModel.status)!) {
            ShowToast(
              message: state.favModel.message,
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => ProductsBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel,
                context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget ProductsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                //item is a list of widgets
                items: model!.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                )),
            const SizedBox(
              height: 20.0,
            ),
            DotsIndicator(dotsCount: model.data.banners.length,),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItems(
                            categoriesModel!.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                //to make spaces between the products to allow me write info for products
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                //I will increase the ratio divided to make a space under image
                childAspectRatio: 1 / 1.79,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridView(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridView(ProductsModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.0, height: 1.5),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.0, height: 1.5, color: defaultColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.0,
                            height: 1.5,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    Spacer(),
                    //more space required to make the icon clickable
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            (ShopCubit.get(context).favourites[model.id])!
                                ? defaultColor
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItems(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.black.withOpacity(.7),
              width: 100.0,
              child: Text(
                ' ${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      );
}
