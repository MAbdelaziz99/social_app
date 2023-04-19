import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/search_for_users/cubit/search_states.dart';
import 'package:social_app/presentation/search_for_users/firebase/search_users_getting.dart';

import '../../../data/models/user_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];
  StreamController<String> streamController = StreamController<String>();

  getUsers() {
    emit(SearchLoadingState());

    startStream();

    Stream<String> streamName = streamController.stream;

    streamName.listen((userName) {
      users = [];
      SearchUsersGetting.getInstance().getUsers(onSuccessListen: (event) {
        for (var element in event.docs) {
          UserModel userModel = UserModel.fromJson(element.data());
          validateUserName(userName, userModel);
        }
        emit(SearchSuccessState());
      });
    });
  }

  void validateUserName(String userName, UserModel userModel) {
    if (userName.isNotEmpty) {
      if (userModel.name!
          .toLowerCase()
          .startsWith(userName.toLowerCase())) {
        users.add(userModel);
      }
    } else {
      users.add(userModel);
    }
  }

  void startStream() {
    streamController.add('');
  }
}
