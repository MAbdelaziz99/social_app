import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/presentation/likes/cubit/likes_states.dart';
import 'package:social_app/presentation/likes/firebase/get_likes_users.dart';
import 'package:social_app/shared/constatnts.dart';

class LikesCubit extends Cubit<LikesStates> {
  LikesCubit() : super(LikesInitialState());

  static LikesCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];
  String usersStatus = '';

  getUsers({required CollectionReference<Map<String, dynamic>> likeRef}) {
    usersStatus = FirebaseStatus.loading.name;
    emit(LikesLoadingState());
    GetLikesUsers.getInstance().getUsers(
        likeRef: likeRef,
        onSuccessListen: (event) {
          users = event;
          usersStatus = FirebaseStatus.success.name;
          emit(LikesSuccessState());
        },
        onErrorListen: (error) {
          usersStatus = FirebaseStatus.error.name;
          emit(LikesErrorState());
        });
  }
}
