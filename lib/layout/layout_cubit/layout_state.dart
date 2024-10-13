abstract class LayoutState{}

class LayoutInitialState extends LayoutState{}
class ChangeBottomNavIndexState extends LayoutState{}
class GetUserDataLoadingState extends LayoutState{}
class GetUserDataSuccessState extends LayoutState{}
class FailedToGetUserDataState extends LayoutState
{
  String error;
  FailedToGetUserDataState({required this.error});
}
class GetBannersLoadingState extends LayoutState{}
class GetBannersSuccessState extends LayoutState{}
class FailedToGetBannersState extends LayoutState {}

class GetCategoryLoadingState extends LayoutState{}
class GetCategorySuccessState extends LayoutState{}
class FailedToGetCategoryState extends LayoutState {}

class GetProductLoadingState extends LayoutState{}
class GetProductSuccessState extends LayoutState{}
class FailedToGetProductState extends LayoutState {}

class FilterProductSuccessState extends LayoutState{}
class FailedToFilterProductState extends LayoutState {}

class FavoritesProductSuccessState extends LayoutState{}
class FailedToFavoritesProductState extends LayoutState {}

class AddAndRemoveFavoritesProductSuccessState extends LayoutState{}
class FailedToAddAndRemoveFavoritesProductState extends LayoutState {}

class GetCartsSuccessState extends LayoutState{}
class FailedToGetCartsState extends LayoutState {}

class AddAndRemoveProductToCartSuccessState extends LayoutState{}
class FailedToAddAndRemoveProductToCartState extends LayoutState {}

class ChangePasswordLoadingState extends LayoutState{}
class ChangePasswordSuccessState extends LayoutState{}
class FailedToChangePasswordState extends LayoutState
{
  String error;
  FailedToChangePasswordState({required this.error});
}

class UpdateUserDataLoadingState extends LayoutState{}
class UpdateUserDataSuccessState extends LayoutState{}
class FailedToUpdateUserDataState extends LayoutState
{
  String error;
  FailedToUpdateUserDataState({ required this.error});
}