import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/home/cubit/home_cubit.dart';
import 'package:social_app/presentation/home/cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  final PageController controller = PageController(initialPage: 1);

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 3.0,
              onTap: (index) => cubit.changeCurrentIndex(controller, index),
            ),
            body: PageView(
              controller: controller,
              onPageChanged: (index) =>
                  cubit.changeCurrentIndex(controller, index),
              children: cubit.screens,
            ),
          ),
        );
      },
    );
  }
}
