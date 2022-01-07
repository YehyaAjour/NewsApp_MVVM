abstract class AppStates {}
class AppInitialState extends AppStates{}
class ChangeBottomNavState extends AppStates{}
class GetBusinessNewsLoadingState extends AppStates{}
class GetBusinessNewsSuccessfulState extends AppStates{}
class GetBusinessNewsErrorState extends AppStates{
  final String error;

  GetBusinessNewsErrorState(this.error);
}

