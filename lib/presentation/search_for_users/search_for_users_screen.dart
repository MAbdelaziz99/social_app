import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/presentation/search_for_users/cubit/search_cubit.dart';
import 'package:social_app/presentation/search_for_users/cubit/search_states.dart';
import 'package:social_app/shared/components/user_item.dart';
import 'package:social_app/shared/style/colors.dart';

class SearchForUsersScreen extends StatefulWidget {
  const SearchForUsersScreen({Key? key}) : super(key: key);

  @override
  State<SearchForUsersScreen> createState() => _SearchForUsersScreenState();
}

class _SearchForUsersScreenState extends State<SearchForUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit()..getUsers(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Write the user name',
                      hintStyle:
                          TextStyle(color: lightGreyColor, fontSize: 16.0.sp),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cubit.streamController.add(value);
                      });
                    },
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0).r,
                    child: DefaultUserItem(
                      users: cubit.users,
                      usersStatus: cubit.usersStatus,
                    )));
          },
        ));
  }
}
