import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';

part 'chats_states.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  static ChatsCubit get(context) => BlocProvider.of(context);

  List<UserModel> user = [];

}
