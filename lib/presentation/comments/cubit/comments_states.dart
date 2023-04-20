abstract class CommentsStates {}

class CommentsInitialState extends CommentsStates {}

class CommentCheckTheTextIsEmptyOrNotState extends CommentsStates{}
class CommentAddSuccessState extends CommentsStates {}

class CommentAddLoadingState extends CommentsStates {}

class CommentAddErrorState extends CommentsStates {}

class CommentGetSSuccessState extends CommentsStates {}

class CommentGetSLoadingState extends CommentsStates {}

class CommentGetSErrorState extends CommentsStates {}

class CommentLikeState extends CommentsStates {}
