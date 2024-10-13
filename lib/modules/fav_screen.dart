import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit =  BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "اكتب للبحث",
                      suffixIcon: Icon(Icons.clear),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: cubit.favorites.length,
                        itemBuilder: (context,index)
                    {
                      return Container(
                        height: 200,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.4),
                        child: Row(
                          children:
                          [
                            Image.network(cubit.favorites[index].url!,width: 250,height: 150,fit: BoxFit.fill,),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    Text(cubit.favorites[index].name!,maxLines: 1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${cubit.favorites[index].price!}\$"),
                                    MaterialButton(
                                        onPressed: ()
                                    {
                                        cubit.addOrRemoveFavorites(productID: cubit.favorites[index].id.toString());
                                    },
                                      child: Text("مــٍســح"),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      color: mainColor,

                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      );
                    }),
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}