import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_states.dart';
import 'package:ecommerce/modules/auth_screens/login.dart';
import 'package:ecommerce/modules/home_screen.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

   RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state)
      {
        if(state is RegisterSuccessState)
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        else if (state is FailedToRegisterState)
        {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text(state.message,style: const TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context,state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('عمل حساب',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                  SizedBox(
                    height: 30.0,
                  ),
                  _textFiledItem(controller: nameController, hintText: "اسم المستخدم"),
                  SizedBox(
                    height: 20.0,
                  ),
                  _textFiledItem(controller: emailController, hintText: "البريد الاكتروني"),
                  SizedBox(
                    height: 20.0,
                  ),
                  _textFiledItem(isSrecure: true, controller: passwordController, hintText: "كلمة المرور"),
                  SizedBox(
                    height: 20.0,
                  ),
                  _textFiledItem(controller: phoneController, hintText: "رقم الهاتف"),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text
                        );
                      }
                    },
                    child: Text(state is RegisterLoadingState ?"انتــــظر....." :"تسجيل" , style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                    padding: EdgeInsets.symmetric(vertical: 12.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    ),
                    color: mainColor,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Text('تسجيل الدخول',style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),)
                      ),
                      Text('لــدي بالفعل حساب'),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _textFiledItem({
  bool? isSrecure,
  required TextEditingController controller,
  required String hintText
}) {
  return TextFormField(
  controller: controller,
  validator: (input)
{
if(controller.text.isEmpty)
{
return "$hintText name must not null";
}
else
{
return null ;
}
},
    obscureText: isSrecure ?? false,
decoration: InputDecoration(
border: OutlineInputBorder(),
hintText: hintText,
),
);
}
