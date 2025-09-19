import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_base.dart';
import 'package:ordersaman/common/constants/env.dart';
import 'package:ordersaman/common/utils/size_config.dart';

class AppDev extends StatefulWidget {
  final Env env;
  const AppDev({super.key, required this.env});

  @override
  State<AppDev> createState() => _AppDevState();
}

class _AppDevState extends State<AppDev> {
  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context: context);
    // return MultiRepositoryWrapper(
    //  env: widget.env,
    //  child:
    //  MultiBlocWrapper(env: widget.env, child:
    return BaseApp();
    //),
    //);
  }
}
