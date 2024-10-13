import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_states.dart';
import 'package:ecommerce/modules/home_screen.dart';
import 'package:ecommerce/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/auth_backgraound4.jpg'),fit: BoxFit.fitHeight)

        ),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context , state)
          {
            if(state is LoginSuccessState)
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
          builder: (context , state){
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text('سجــل دخــولك لتســتمتع بعروضنا',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('تسجيل الدخول',
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ) ,
                          ),
                          _textFiledItem(
                            controller: emailController,
                            hintText: 'البريد الاكتروني',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _textFiledItem(
                            controller: passwordController,
                            hintText: 'كلمة المرور',
                            isSrecure: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                BlocProvider.of<AuthCubit>(context).login(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            child: Text(state is LoginLoadingState ? "انتظـــر ..." :"تسجيل الدخول" , style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                            padding: EdgeInsets.symmetric(vertical: 12.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)
                            ),
                            color: mainColor,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                  },
                                  child: Text('عمل حســاب',style: TextStyle(
                                      color: mainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),)
                              ),
                              Text('ليس لــدي حساب...',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          RichText(
                              text: TextSpan(
                                children:
                                  [
                                    TextSpan(text: 'نسيت كلمة السر .... ',style: TextStyle(fontSize: 15)),
                                    TextSpan(text: 'اضغط هــنـــا',
                                        style: TextStyle(color: mainColor, fontSize: 18,fontWeight: FontWeight.bold)),
                                  ]
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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
        fillColor:Colors.white,
        hintText: hintText,
      ),
    );
    }
}
