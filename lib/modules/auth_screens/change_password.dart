import 'package:ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constants.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('تغير كلمة المرور'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'كلمة المرور الحالية',
              ),

            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'كلمة المرور الجديده',
              ),

            ),
            SizedBox(
              height: 25,
            ),
            BlocConsumer<LayoutCubit,LayoutState>(
              listener: (context,state)
              {
                if(state is ChangePasswordSuccessState)
                  {
                    showSnackBarItem(context, 'تم التحديث بنجاح', true);
                    Navigator.pop(context);
                  }
                if(state is FailedToChangePasswordState)
                {
                  showSnackBarItem(context, state.error, true);
                }

              },
              builder: (context,state)
              {
                return MaterialButton(
                  onPressed: ()
                  {
                    if(currentPasswordController.text.trim() == currentPassword)
                    {
                      if(newPasswordController.text.length >= 6)
                      {
                        cubit.changePassword(userCurrentPassword: currentPassword!, newPassword: newPasswordController.text.trim());
                      }
                      else
                      {
                        showSnackBarItem(context, 'كلمة يجب ان تكون اعلى من 6 رموز', false);
                      }

                    }
                    else
                    {
                      showSnackBarItem(context, "تحقق من كلمه السر", false);
                    }
                    NavigateTo(context, ChangePassword());
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