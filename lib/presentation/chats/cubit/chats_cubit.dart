import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/constatnts.dart';
import 'package:social_app/shared/firebase/get_users.dart';

import '../../../data/models/user_model.dart';

part 'chats_states.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  static ChatsCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];
  String userStatus = '';

  getUsers() {
    userStatus = FirebaseStatus.loading.name;
    emit(ChatsLoadingState());
    GetUsers.getInstance.getUsers(onSuccessListen: (userModels) {
      users = userModels;
      userStatus = FirebaseStatus.success.name;
      if (!isClosed) {
        emit(ChatsSuccessState());
      }
    }, onErrorListen: (error) {
      userStatus = FirebaseStatus.error.name;
      if (!isClosed) {
        emit(ChatsErrorState());
      }
    });
  }
}
