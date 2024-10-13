import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constants.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfile extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    nameController.text = cubit.userModel!.name!;
    phoneController.text = cubit.userModel!.phone!;
    emailController.text = cubit.userModel!.email!;
    return Scaffold(
      appBar: AppBar(
        title: Text('تحديث البيانات'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'اسم المستخدم',
              ),

            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'رقم الهاتف',
              ),

            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'البريد الاكتروني',
              ),

            ),
            SizedBox(
              height: 25,
            ),
            BlocConsumer<LayoutCubit,LayoutState>(
              listener: (context,state)
              {
                if(state is UpdateUserDataSuccessState)
                {
                  showSnackBarItem(context, 'تم التحديث بنجاح', true);
                  Navigator.pop(context);
                }
                if(state is FailedToUpdateUserDataState)
                {
                  showSnackBarItem(context, state.error, true);
                }

              },
              builder: (context,state)
              {
                return MaterialButton(
                  onPressed: ()
                  {
                    if(nameController.text.isNotEmpty&&phoneController.text.isNotEmpty&&emailController.text.isNotEmpty)
                     {
                      cubit.updateUserData(name: nameController.text, phone: phoneController.text, email: emailController.text);
                     }
                    else
                      {
                        showSnackBarItem(context, 'رجاء ادخل البيانات', false);
                      }
                  },
                  child: Text(state is ChangePasswordLoadingState ? "انتظر" :" تم تحديث البيانات"),
                  minWidth: double.infinity,
                  color: mainColor,
                  textColor: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
void showSnackBarItem(BuildContext context,String message,bool forTrueOrFulse)
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
    backgroundColor: forTrueOrFulse ? Colors.green : Colors.red,));
}