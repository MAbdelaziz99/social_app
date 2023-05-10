part of 'chats_cubit.dart';

abstract class ChatsStates {}

class ChatsInitialState extends ChatsStates {}

class ChatsLoadingState extends ChatsStates {}

class ChatsErrorState extends ChatsStates {}

class ChatsSuccessState extends ChatsStates {}
