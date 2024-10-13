import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void NavigateAndFinish(context , widget) {
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}
void NavigateTo(context , widget) {
 Navigator.push(context, MaterialPageRoute(builder: (context)=> widget),);
}
