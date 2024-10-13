import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/models/banner_model.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/modules/cart_screen.dart';
import 'package:ecommerce/modules/cate_screen.dart';
import 'package:ecommerce/modules/fav_screen.dart';
import 'package:ecommerce/modules/home_screen.dart';
import 'package:ecommerce/modules/profile_screen.dart';
import 'package:ecommerce/shared/components/constants.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/layout/layout_cubit/layout_state.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutState>{
  LayoutCubit():super(LayoutInitialState());

  int bottomNavIndex = 0;
  List<Widget> LayoutScreens = [ProfileScreen(),CategoriesScreen(),FavScreen(),CartScreen(),HomeScreen()];

  void changeBottomNavIndex({required int index})
  {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }
  //Banner
  List<BannerModel> banners = [];
  void getBannerData()async
  {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/banners"),
    );

    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
      {
        for(var item in responseBody['data'])
          {
            banners.add(BannerModel.fromJson(data: item));
          }
        emit(GetBannersSuccessState());
      }
    else
      {
        emit(FailedToGetBannersState());
      }
  }

  //Category
  List<CategoryModel> category = [];
  void getCategoryData()async
  {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/categories"),
    );

    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      for(var item in responseBody['data']['data'])
      {
        category.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategorySuccessState());
    }
    else
    {
      emit(FailedToGetCategoryState());
    }
  }

  //Products
  List<ProductModel> product = [];
  void getProductData()async
  {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/home"),
      headers:
        {
        'Authorization' : token!,
        }
        );

    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      for(var item in responseBody['data']['products'])
      {
        product.add(ProductModel.fromJson(data: item));
      }
      emit(GetProductSuccessState());
    }
    else
    {
      emit(FailedToGetProductState());
    }
  }

  //Search
  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input})
  {
    filteredProducts = product.where((element) => element.name!.toLowerCase().startsWith(input.toLowerCase())).toList();
    emit(FilterProductSuccessState());
  }

  //Favorites
  List<ProductModel> favorites = [];
  Set<String> favoritesID = {};
  void getFavorites()async
  {
    favorites.clear();
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'Authorization' : token!,
        }
    );

    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      for(var item in responseBody['data']['data'])
      {
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoritesID.add(item['product']['id'].toString());
      }
      emit(FavoritesProductSuccessState());
    }
    else
    {
      emit(FailedToFavoritesProductState());
    }
  }

  //AddAndRemoveFavorites
  void addOrRemoveFavorites({required String productID})async
  {
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'Authorization' : token!,
        },
        body:
        {
          'product_id' : productID
        }
    );
    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      if(favoritesID.contains(productID) == true)
        {
          favoritesID.remove(productID);
        }
      else
        {
          favoritesID.add(productID);
        }
      getFavorites();
      emit(AddAndRemoveFavoritesProductSuccessState());
    }
    else
    {
      emit(FailedToAddAndRemoveFavoritesProductState());
    }
  }

  //Get Cart
  List<ProductModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  void getCart()async
  {
    carts.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/carts"),
      headers:
        {
          'Authorization' : token!,
        }
    );

    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      for(var item in responseBody['data']['cart_items'])
      {
        cartsId.add(item['product']['id'].toString());
        carts.add(ProductModel.fromJson(data: item['product']));
      }
      totalPrice = responseBody['data']['total'];
      emit(GetCartsSuccessState());
    }
    else
    {
      emit(FailedToGetCartsState());
    }
  }

  //AddAndRemoveCarts
  void addOrRemoveProductsFromCart({required String id})async
  {
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers:
        {
          'Authorization' : token!,
        },
        body:
        {
          'product_id' : id
        }
    );
    final responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      if(cartsId.contains(id) == true)
      {
        cartsId.remove(id);
      }
      else
      {
        cartsId.add(id);
      }
      getCart();
      emit(AddAndRemoveProductToCartSuccessState());
    }
    else
    {
      emit(FailedToAddAndRemoveProductToCartState());
    }
  }

  //ChangePassword
  void changePassword({required String userCurrentPassword,required String newPassword})async
  {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        headers:
        {
          'Content-Type' : 'application/json',
          'Authorization' : token!,
        },
        body:
        {
          'current_password' : userCurrentPassword,
          'new_password' : newPassword,
        }
    );
    final responseBody = jsonDecode(response.body);
    if(response.statusCode == 200)
    {
      if(responseBody['status'] == true)
        {
          await CacheHelper.InsertToCache(key: 'password', value: newPassword);
          currentPassword = await CacheHelper.getData(key: 'password');
          emit(ChangePasswordSuccessState());
        }
      else
        {
          emit(FailedToChangePasswordState(error : responseBody['messsge']));
        }
    }
    else
    {
      emit(FailedToChangePasswordState(error: 'هناك شي خطا حاول مره احرى'));
    }
  }

  //UpdateProfile
  void updateUserData({required String name,required String phone,required String email})async
  {
    emit(UpdateUserDataLoadingState());
    try{
      emit(UpdateUserDataLoadingState());
      Response response = await http.put(
          Uri.parse("https://student.valuxapps.com/api/change-password"),
          headers:
          {
            'Authorization' : token!,
          },
          body:
          {
            'name' : name,
            'phone' : phone,
            'email' : email,
          }
      );
      final responseBody = jsonDecode(response.body);
      if(response.statusCode == 200)
      {
        if(responseBody['status'] == true)
        {
          getUserData();
          emit(UpdateUserDataSuccessState());
        }
        else
        {
          emit(FailedToUpdateUserDataState(error : responseBody['messsge']));
        }
      }
    }catch(e)
    {
      emit(FailedToUpdateUserDataState(error:e.toString()));
    }
  }
  //Profile
  UserModel? userModel;
  void getUserData()async{
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers:
      {
        'Authorization' : token!,
      }
    );
    var responseData =jsonDecode(response.body);
    if (responseData['status'] == true)
      {
        userModel = UserModel.fromJson(data: responseData['data']);
        print("Response is : $responseData");
        emit(GetUserDataSuccessState());
      }
    else
      {
        print("Response is : $responseData");
        emit(FailedToGetUserDataState(error: responseData['message']));
      }
  }
}

