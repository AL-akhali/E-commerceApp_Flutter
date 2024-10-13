import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/modules/auth_screens/change_password.dart';
import 'package:ecommerce/modules/auth_screens/update_profile.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
            listener: (context,state)
            {

            },
            builder: (context,state){
              final cubit = BlocProvider.of<LayoutCubit>(context);
              if(cubit.userModel == null) cubit.getUserData();
              return Scaffold(
                body: cubit.userModel == null ? Center(child: CircularProgressIndicator(),)
                    :
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                  width: double.infinity,
                  child: Column(
                      children:
                      [
                        CircleAvatar(
                          backgroundImage: NetworkImage(cubit.userModel!.image!),
                          radius: 45,
                        ),
                        SizedBox(height: 20,),
                        Text(cubit.userModel!.name!),
                        SizedBox(height: 10,),
                        Text(cubit.userModel!.name!),
                        SizedBox(height: 10,),
                        MaterialButton(
                            onPressed: ()
                        {
                          NavigateTo(context, ChangePassword());
                        },
                        child: Text("تغير كلمة المرور"),
                          color: mainColor,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 10,),
                        MaterialButton(
                          onPressed: ()
                          {
                            NavigateTo(context, UpdateProfile());
                          },
                          child: Text("تحدبث البيانات"),
                          color: mainColor,
                          textColor: Colors.white,
                        ),
                      ],

                                ),
                )
              );
        },
        );
  }
}
