abstract class AppStates {}
class AppInitialState extends AppStates{}
class ChangeIndexTapBarState extends AppStates{}
class ChangeBottomNavState extends AppStates{}
class GetBusinessNewsLoadingState extends AppStates{}
class GetBusinessNewsSuccessfulState extends AppStates{}
class GetBusinessNewsErrorState extends AppStates{
  final String error;

  GetBusinessNewsErrorState(this.error);
}
class GetGeneralNewsLoadingState extends AppStates{}
class GetGeneralNewsSuccessfulState extends AppStates{}
class GetGeneralNewsErrorState extends AppStates{
  final String error;

  GetGeneralNewsErrorState(this.error);
}

class GetEntertainmentNewsLoadingState extends AppStates{}
class GetEntertainmentNewsSuccessfulState extends AppStates{}
class GetEntertainmentNewsErrorState extends AppStates{
  final String error;

  GetEntertainmentNewsErrorState(this.error);
}

class GetHealthNewsLoadingState extends AppStates{}
class GetHealthNewsSuccessfulState extends AppStates{}
class GetHealthNewsErrorState extends AppStates{
  final String error;

  GetHealthNewsErrorState(this.error);
}
class GetScienceNewsLoadingState extends AppStates{}
class GetScienceNewsSuccessfulState extends AppStates{}
class GetScienceNewsErrorState extends AppStates{
  final String error;

  GetScienceNewsErrorState(this.error);
}
class GetSportNewsLoadingState extends AppStates{}
class GetSportNewsSuccessfulState extends AppStates{}
class GetSportNewsErrorState extends AppStates{
  final String error;

  GetSportNewsErrorState(this.error);
}

class GetTechnologyNewsLoadingState extends AppStates{}
class GetTechnologyNewsSuccessfulState extends AppStates{}
class GetTechnologyNewsErrorState extends AppStates{
  final String error;

  GetTechnologyNewsErrorState(this.error);
}

class GetSearchNewsLoadingState extends AppStates{}
class GetSearchNewsSuccessfulState extends AppStates{}
class GetSearchNewsErrorState extends AppStates{
  final String error;

  GetSearchNewsErrorState(this.error);
}

class ChangeSearchState extends AppStates{}