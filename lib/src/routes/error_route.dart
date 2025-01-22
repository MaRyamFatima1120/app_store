import 'package:flutter/material.dart';
import '../../common/constants/global_variable.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ErrorPage router',style: textTheme(context).bodyMedium,),
      ),
    );
  }
}