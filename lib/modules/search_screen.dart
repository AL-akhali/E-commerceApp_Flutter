import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('منطقة البحث'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          onChanged: (input)
          {
            cubit.filteredProducts;
          },
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
      )
    );
  }
}
