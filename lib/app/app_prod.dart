import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_base.dart';
import 'package:ordersaman/common/constants/env.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:ordersaman/common/widgets/global_error_widget.dart';

class AppProd extends StatelessWidget {
  final Env env;
  const AppProd({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context: context);

    return
    // MultiRepositoryWrapper(
    // env: env,
    //child: MultiBlocWrapper(
    //  env: env,
    //// child:
    BaseApp(
      builder: (context, Widget? widget) {
        setErrorBuilder(context);
        return widget!;
      },
    );
    //  ),
    //);
  }
}
