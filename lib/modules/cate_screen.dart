import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesData = BlocProvider.of<LayoutCubit>(context).category;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: categoriesData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
          ), itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(categoriesData[index].url!),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(categoriesData[index].title!,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,fontSize: 25),),

              ],
            ),
          );        },
        ),
      ),
    );
  }
}
