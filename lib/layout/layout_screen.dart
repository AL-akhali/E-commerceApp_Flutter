import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/modules/auth_screens/login.dart';
import 'package:ecommerce/modules/search_screen.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>
      (
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar : AppBar(
            title : Text("مركز التسوق"),
            actions: 
            [
              TextButton(
                  onPressed: ()
                  {
                     CacheHelper.DeleteCacheItem(key: 'token').then((value)
                     {
                       if(value)
                         {
                           NavigateAndFinish(context, LoginScreen());
                         }
                     });
                  },
                  child:
                  Text('تسجيل الخروج')
              ) ,
              IconButton(
                  onPressed: ()
                  {
                    NavigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavIndex,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: mainColor,
              onTap: (index)
              {
                cubit.changeBottomNavIndex(index: index);
              },
              items:
              const
              [
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "الصفحة الشخصية"),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: "الاصناف"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "المفضلات"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "السلة"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "الرئيسية"),
              ]
          ),
          body: cubit.LayoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
