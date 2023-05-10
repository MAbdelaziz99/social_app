abstract class CommentsStates {}

class CommentsInitialState extends CommentsStates {}

class CommentCheckTheTextIsEmptyOrNotState extends CommentsStates{}
class CommentAddSuccessState extends CommentsStates {}

class CommentAddLoadingState extends CommentsStates {}

class CommentAddErrorState extends CommentsStates {}

class CommentGetSuccessState extends CommentsStates {}

class CommentGetLoadingState extends CommentsStates {}

class CommentGetErrorState extends CommentsStates {}

class CommentLikeSuccessState extends CommentsStates {}

class CommentLikeErrorState extends CommentsStates {}

