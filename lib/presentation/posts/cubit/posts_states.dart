abstract class PostsStates {}

class PostsInitialState extends PostsStates {}

class PostsGetLoadingState extends PostsStates {}

class PostsGetSuccessState extends PostsStates {}

class PostsGetErrorState extends PostsStates {}

class PostLikeSuccessState extends PostsStates {}

class PostLikeErrorState extends PostsStates {}

class PostChangeSliderIndex extends PostsStates {}
