part of 'messages_cubit.dart';

abstract class MessagesStates {}

class MessagesInitialState extends MessagesStates {}

class MessagesAddLoadingState extends MessagesStates {}

class MessagesAddSuccessState extends MessagesStates {}

class MessagesAddErrorState extends MessagesStates {}

class MessagesGetLoadingState extends MessagesStates {}

class MessagesGetSuccessState extends MessagesStates {}

class MessagesDeleteLoadingState extends MessagesStates {}

class MessagesDeleteSuccessState extends MessagesStates {}

class MessagesDeleteErrorState extends MessagesStates {}
