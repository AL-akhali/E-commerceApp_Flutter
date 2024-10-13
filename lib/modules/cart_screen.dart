import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: cubit.carts.isEmpty ?Center(child: CircularProgressIndicator(),):
                  ListView.separated(
                    itemCount: cubit.carts.length,
                    separatorBuilder: (context,index)
                    {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context,index){
                      return Container(
                        decoration: BoxDecoration(
                          color: thirdColor,
                        ),
                        child:Row(
                          children:
                          [
                            Image.network(cubit.carts[index].url!,height: 150,width: 150,fit: BoxFit.fill,),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("${cubit.carts[index].name!}",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children:
                                    [
                                      Text("${cubit.carts[index].price!} \$"),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if(cubit.carts[index].price != cubit.carts[index].oldPrice)
                                      Text("${cubit.carts[index].oldPrice!} \$",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:
                                    [
                                      OutlinedButton(onPressed: ()
                                      {
                                        cubit.addOrRemoveFavorites(productID: cubit.carts[index].id.toString());
                                      },
                                          child: Icon(Icons.favorite,
                                            color: cubit.favoritesID.contains(cubit.carts[index].id.toString())? Colors.red : Colors.grey,),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          cubit.addOrRemoveProductsFromCart(id: cubit.carts[index].id.toString());
                                        },
                                        child: Icon(Icons.delete,color: Colors.red,),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Text('  ${cubit.totalPrice}: المجــــموع'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}