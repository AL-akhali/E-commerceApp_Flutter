import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
            body: ListView(
              children:
              [
                cubit.banners.isEmpty?
                const Center(child: CupertinoActivityIndicator(),):
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: PageView.builder(
                      controller: pageController,
                      physics: BouncingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Image.network(cubit.banners[index].url!,fit: BoxFit.fill,),
                        );
                      }
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count:  3,
                    axisDirection: Axis.horizontal,
                    effect:  WormEffect(
                        spacing:  8.0,
                        radius:  25,
                        dotWidth:  24.0,
                        dotHeight:  16.0,
                        paintStyle:  PaintingStyle.stroke,
                        strokeWidth:  1.5,
                        dotColor:  Colors.grey,
                        activeDotColor:  secondColor
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Text("الاصناف",style: TextStyle(color:mainColor,fontSize:20,fontWeight: FontWeight.bold),),
                    Text("عــرض الكـــل",style: TextStyle(color:secondColor,fontSize:20,fontWeight: FontWeight.bold),),
                  ]
                ),
                cubit.category.isEmpty?
                const Center(child: CupertinoActivityIndicator(),):
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context,index)
                      {
                        return SizedBox(width: 20,);
                      },
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.category.length,
                      itemBuilder: (context,index){
                        return CircleAvatar(
                          radius: 60,
                          child: Image.network(cubit.category[index].url!,),
                        );
                      }
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Text("المنتجات",style: TextStyle(color:mainColor,fontSize:20,fontWeight: FontWeight.bold),),
                      Text("عــرض الكـــل",style: TextStyle(color:secondColor,fontSize:20,fontWeight: FontWeight.bold),),
                    ]
                ),
                SizedBox(
                  height: 20,
                ),
                cubit.product.isEmpty?
                const Center(child: CupertinoActivityIndicator(),):
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.filteredProducts.isEmpty ? cubit.product.length : cubit.filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.6,
                        ), itemBuilder: (context, index) {
                          return _productItem(
                              model: cubit.filteredProducts.isEmpty?
                              cubit.product[index]:cubit.filteredProducts[index],
                              cubit: cubit);
                        },
                    ),
              ],
            ) ,
            ),
          );
        }
        );
  }
}
Widget _productItem({required ProductModel model, required LayoutCubit cubit})
{
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        color: Colors.grey.withOpacity(0.2),
        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 12),
        child: Column(
          children: [
            Expanded(
              child: Image.network(model.url!),
            ),
            Text(model.name!,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,fontSize: 25),),
            Row(
              children:
              [
                Expanded(
                    child:
                    Row(
                      children:
                      [
                        Text("${model.price!}",style: TextStyle(fontSize: 18),),
                        SizedBox(width: 15,),
                        Text("${model.oldPrice!}",style: TextStyle(color: Colors.grey, fontSize: 18,decoration: TextDecoration.lineThrough),),
                      ],
                    )
                ),
                GestureDetector(
                  child: Icon(Icons.favorite,size: 20,
                    color: cubit.favoritesID.contains(model.id.toString())?Colors.red : Colors.grey,
                  ),
                  onTap: ()
                  {
                    cubit.addOrRemoveFavorites(productID: model.id.toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(0.6),
        child: GestureDetector
          (
          onTap: ()
          {
            cubit.addOrRemoveProductsFromCart(id: model.id.toString());
          },
          child: Icon(Icons.shopping_cart,
          color: cubit.cartsId.contains(model.id.toString())?Colors.red:Colors.white,),
        ),
      )
    ],

  );
}
