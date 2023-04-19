import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/presentation/likes/cubit/likes_states.dart';
import 'package:social_app/presentation/likes/firebase/likes_users_getting.dart';

class LikesCubit extends Cubit<LikesStates> {
  LikesCubit() : super(LikesInitialState());

  static LikesCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  getUsers({required CollectionReference<Map<String, dynamic>> likeRef}) {
    emit(LikesLoadingState());
    LikesUsersGetting.getInstance().getUsers(
      likeRef: likeRef,
      onSuccessListen: (event) {
        users = event;
        emit(LikesSuccessState());
      },
    );
  }
}
