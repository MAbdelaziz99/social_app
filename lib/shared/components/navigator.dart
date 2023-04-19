import 'package:flutter/material.dart';

navigateTo({required context, required routeName}) =>
    Navigator.pushNamed(context, routeName);

navigateToAndRemoveUntil({required context, required routeName}) =>
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);


