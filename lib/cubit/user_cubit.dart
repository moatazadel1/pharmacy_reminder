import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import 'package:reminder_app/cache/cache_helper.dart';
import 'package:reminder_app/core/api/api_consumer.dart';
import 'package:reminder_app/core/api/end_points.dart';
import 'package:reminder_app/core/errors/exceptions.dart';
import 'package:reminder_app/core/functions/constant.dart';
import 'package:reminder_app/core/functions/upload_image_to_api.dart';
import 'package:reminder_app/core/models/notification_model.dart';
import 'package:reminder_app/core/utils/notification/local_notification_service.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/models/add_model.dart';
import 'package:reminder_app/models/admin_model.dart';
import 'package:reminder_app/models/all_products_model.dart';
import 'package:reminder_app/models/all_users_model.dart';
import 'package:reminder_app/models/calender_search_model.dart';
import 'package:reminder_app/models/check_code_model.dart';
import 'package:reminder_app/models/delete_product_model.dart';

import 'package:reminder_app/models/edit_user_model.dart';
import 'package:reminder_app/models/expired_model.dart';
import 'package:reminder_app/models/exsearch_model.dart';
import 'package:reminder_app/models/forget_model.dart';
import 'package:reminder_app/models/latest_items_model.dart';

import 'package:reminder_app/models/reset_pass_model.dart';
import 'package:reminder_app/models/search_model.dart';
import 'package:reminder_app/models/showone_model.dart';
import 'package:reminder_app/models/sign_in_model.dart';
import 'package:reminder_app/models/sign_up_model.dart';
import 'package:reminder_app/models/soonexpired_model.dart';
import 'package:reminder_app/models/soonsearch_model.dart';
import 'package:reminder_app/models/update_item_model.dart';
import 'package:reminder_app/models/user_model.dart';
import 'package:reminder_app/models/usercount_model.dart';
import 'package:reminder_app/service/service_Locator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Profile Pic
  XFile? profilePic;
  //product Pic
  XFile? productPic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //forget password
  TextEditingController forgetPassword = TextEditingController();
  //checck code
  TextEditingController check_Code = TextEditingController();
  //reset password
  TextEditingController reset_Password = TextEditingController();
  //reset password confirm
  TextEditingController reset_confirm = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController updateName = TextEditingController();
  TextEditingController updateEmail = TextEditingController();
  TextEditingController UpdatePass = TextEditingController();
  TextEditingController UpdateConfirm_pass = TextEditingController();

  TextEditingController productName = TextEditingController();
  TextEditingController proDate = TextEditingController();
  TextEditingController expDate = TextEditingController();
  TextEditingController startReminder = TextEditingController();
  TextEditingController BatchNumber = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController quantity = TextEditingController();

  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateProDate = TextEditingController();
  TextEditingController updateExpDate = TextEditingController();
  TextEditingController updateStartReminder = TextEditingController();
  TextEditingController updateCode = TextEditingController();
  TextEditingController updateDescription = TextEditingController();
  TextEditingController updateCategory = TextEditingController();
  TextEditingController updateQuantity = TextEditingController();

  //Admin Sign in email
  TextEditingController adminSignInEmail = TextEditingController();
  //Admin Sign in password
  TextEditingController adminSignInPassword = TextEditingController();
  //Admin Sign in password
  TextEditingController searchController = TextEditingController();

  //exsearch
  TextEditingController exsearchController = TextEditingController();

  TextEditingController soonsearchController = TextEditingController();
  TextEditingController searchCalender = TextEditingController();

  SignInModel? user; //هناخد متغير من الموديل اللي عملناه علشان نستقبل الريسبوند
  AddItemModel? product;
  AdminLoginModel? admin;
  UserCountModel? count;
  LatestItemsModel? items;
  AllUsersModel? dUser;
  ForgetModel? check;

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  uploadProductPic(XFile image) {
    productPic = image;
    emit(UploadProductPic());
  }

  // Method to reset the product picture
  void resetProductPic() {
    productPic = null;
    emit(UserImageReset());
  }

  signIn() async {
    try {
      emit(SignInLoading());
      const url = 'http://mohamedsadek.c1.is/api/user/Login';
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': signInEmail.text,
          'password': signInPassword.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = SignInModel.fromJson(data);
        getIt<CacheHelper>().saveData(key: ApiKey.token, value: user!.token);
        emit(SignInSuccess());
      } else {
        final errorData = json.decode(response.body);
        emit(SignInFailure(errmessage: errorData['error']));
      }
    } catch (e) {
      emit(SignInFailure(errmessage: 'An unexpected error occurred.'));
    }
  }

  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoints.signUp,
        isFormData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirm_password: confirmPassword.text,
          ApiKey.image: await uploadImageToAPI(profilePic!)
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccess(message: signUpModel.status));
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(SignUpFailure(errMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> getUserProfile() async {
    try {
      emit(GetUserLoading());
      final response = await api.get(
        EndPoints.Profile,
      );
      emit(GetUserSuccess(user: UserModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(GetUserFailure(errMessage: e.errModel.errorMessage));
    }
  }

  logOut() async {
    try {
      emit(LogOutLoading());
      final response = await api.post(
        EndPoints.LogOut,
      );
      emit(LogOutSuccess());
    } on ServerException catch (e) {
      emit(LogOutFailure(errmessage: e.errModel.message));
    }
  }

  forgetPass() async {
    try {
      emit(ForgetPassLoading());
      final response = await api.post(
        EndPoints.forgetpassword,
        data: {
          ApiKey.email: forgetPassword.text,
        },
      );
      final forgetModel = ForgetModel.fromJson(response);
      final successMessage = forgetModel.status
          ? 'Password reset successful'
          : 'Password reset failed';
      check = ForgetModel.fromJson(
          response); // Ensure you create SignInModel class accordingly
      getIt<CacheHelper>().saveData(key: ApiKey.token, value: check!.token);

      emit(ForgetPassSuccess(message: successMessage));
    } on ServerException catch (e) {
      emit(ForgetPassFailure(errMessage: e.errModel.errorMessage));
    }
  }

  checkCode() async {
    try {
      emit(CheckCodeLoading());
      final response = await api.post(
        EndPoints.checkCode,
        data: {
          ApiKey.code: check_Code.text,
        },
      );

      emit(CheckCodeSuccess());
    } on ServerException catch (e) {
      emit(CheckCodeFailure(errMessage: e.errModel.errorMessage));
    }
  }

  resetPass() async {
    try {
      emit(ResetPasswordLoading());
      final response = await api.post(
        EndPoints.resetPassword,
        isFormData: true,
        data: {
          ApiKey.password: reset_Password.text,
        },
      );

      final resetModel = ResetPassModel.fromJson(response.data);
      emit(ResetPasswordSuccess(message: resetModel));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(ResetPasswordFailure(
            errMessage: 'Unauthorized access. Please check your credentials.'));
      } else {
        emit(ResetPasswordFailure(errMessage: 'Error: ${e.message}'));
      }
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: 'Unexpected error occurred.'));
    }
  }

  Future<void> updateProfile() async {
    try {
      emit(EditUserLoading());

      // Check if profilePic is not null
      if (profilePic == null) {
        throw Exception("Profile picture is required.");
      }

      log("Uploading image...");
      var imageFile = await uploadImageToAPI(profilePic!);
      log("Image uploaded: $imageFile");

      if (imageFile == null) {
        throw Exception("Failed to upload image.");
      }

      log("Sending update profile request...");
      final response = await api.post(
        EndPoints.updateProfile,
        isFormData: true,
        data: {
          ApiKey.name: updateName.text,
          ApiKey.email: updateEmail.text,
          ApiKey.password: UpdatePass.text,
          ApiKey.confirm_password: UpdateConfirm_pass.text,
          ApiKey.image: imageFile
        },
      );

      log("Update profile response received.");
      final editUserModel = EditUserModel.fromJson(response);
      emit(EditUserSuccess(message: editUserModel.status));
    } on ServerException catch (e) {
      log("ServerException: ${e.errModel.errorMessage}");
      emit(EditUserFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      log("Exception: ${e.toString()}");
      emit(EditUserFailure(errMessage: e.toString()));
    }
  }

  addItem() async {
    try {
      emit(AddItemLoading());
      // Convert the XFile to a MultipartFile
      var imageFile = await uploadImageToAPI(productPic!);
      // Create a FormData object for sending multipart/form-data
      var formData = FormData.fromMap({
        ApiKey.title: productName.text,
        ApiKey.pro_date: proDate.text,
        ApiKey.exp_date: expDate.text,
        ApiKey.start_reminder: startReminder.text,
        ApiKey.code: BatchNumber.text,
        ApiKey.description: description.text,
        ApiKey.type: category.text,
        ApiKey.quantity: quantity.text,
        ApiKey.item_image:
            imageFile, // Use the converted MultipartFile directly
      });
      final response = await api.post(
        EndPoints.addItem,
        data: formData,
      );
      product = AddItemModel.fromJson(response);
      await getIt<CacheHelper>().saveData(key: ApiKey.id, value: product!.id);
      emit(AddItemSuccess(message: AddItemModel.fromJson(response)));
      // Schedule a notification
      scheduleNotificationForProduct(
        id: product!.id,
        productName: productName.text,
        startReminder: startReminder.text,
        expDate: expDate.text,
      );
    } on ServerException catch (e) {
      emit(AddItemFailure(errMessage: e.errModel.errorMessage));
    }
  }

  Future<void> allData() async {
    try {
      emit(AllProductsLoading());
      final response = await api.get(
        EndPoints.alldata,
      );
      emit(AllProductsSuccess(products: AllProductsModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(AllProductsFailure(errMessage: e.errModel.errorMessage));
    }
  }

  expiredData() async {
    try {
      emit(ExpiredLoading());
      final response = await api.get(
        EndPoints.expire,
      );
      emit(ExpiredSuccess(exproducts: ExpiredProductModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(ExpiredFailure(errMessage: e.errModel.errorMessage));
    }
  }

  soonExpiredData() async {
    try {
      emit(SoonExpiredLoading());
      final response = await api.get(
        EndPoints.soonexpire,
      );
      emit(SoonExpiredSuccess(
          soonexproducts: SoonExpiredProModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(SoonExpiredFailure(errMessage: e.errModel.errorMessage));
    }
  }

  showOne() async {
    try {
      emit(ShowOneLoading());
      final id = await getIt<CacheHelper>().getData(key: ApiKey.id);
      final response = await api.get(
        EndPoints.showone(id),
      );
      emit(ShowOneSuccess(product: ShowOneModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(ShowOneFailure(errMessage: e.errModel.errorMessage));
    }
  }

  Future<void> updateItem(int id) async {
    try {
      emit(UpdateLoading());
      var imageFile = await uploadImageToAPI(productPic!);
      var formData = FormData.fromMap({
        ApiKey.title: updateTitle.text,
        ApiKey.pro_date: updateProDate.text,
        ApiKey.exp_date: updateExpDate.text,
        ApiKey.start_reminder: updateStartReminder.text,
        ApiKey.code: updateCode.text,
        ApiKey.description: updateDescription.text,
        ApiKey.type: updateCategory.text,
        ApiKey.quantity: updateQuantity.text,
        ApiKey.item_image: imageFile,
      });

      final response = await api.post(
        EndPoints.updatedata(id),
        data: formData,
      );

      // Update the notification
      updateNotificationForProduct(
        id: id.toString(),
        productName: updateTitle.text,
        startReminder: updateStartReminder.text,
        expDate: updateExpDate.text,
      );

      emit(UpdateSuccess(message: UpdateItemModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(UpdateFailure(errMessage: e.errModel.errorMessage));
    }
  }

  void updateNotificationForProduct({
    required String id,
    required String productName,
    required String startReminder,
    required String expDate,
  }) async {
    // Cancel the old notification
    await LocalNotificationService.cancelNotification(int.parse(id));

    // Schedule the new notification
    scheduleNotificationForProduct(
      id: int.parse(id),
      productName: productName,
      startReminder: startReminder,
      expDate: expDate,
    );

    // Update notification data
    NotificationModel updatedNotification = NotificationModel(
      id: int.parse(id),
      title: 'Product Expiry Reminder',
      body:
          'The product "$productName" will soon be about to expire on $expDate.',
      scheduledDate: DateFormat('yyyy-MM-dd')
          .format(DateFormat('yyyy-MM-dd').parse(startReminder)),
    );
    await saveNotificationData(updatedNotification);
  }

  Future<void> delete(int id) async {
    try {
      emit(DeleteLoading());

      await api.delete(EndPoints.delete(id));

      // Cancel the scheduled notification
      await LocalNotificationService.cancelNotification(id);

      // Remove the notification data
      await removeNotificationById(id);

      // Notify the NotificationsScreen about the deletion
      NotificationStream.instance.notify();

      emit(DeleteSuccess());
    } on ServerException catch (e) {
      emit(DeleteFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(DeleteFailure(errMessage: 'An unknown error occurred'));
    }
  }

  void scheduleNotificationForProduct({
    required int id,
    required String productName,
    required String startReminder,
    required String expDate,
  }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'scheduled_notification',
      'id_0',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    DateTime startReminderDate = DateFormat('yyyy-MM-dd').parse(startReminder);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(
            startReminderDate, tz.local)
        .add(const Duration(hours: 9)); // Schedule at 9 AM on the reminder date

    await LocalNotificationService.flutterLocalNotificationsPlugin
        .zonedSchedule(
      id, // Use the id here
      'Product Expiry Reminder',
      'The product "$productName" will soon be about to expire on $expDate.',
      scheduledDate,
      details,
      payload: 'zonedSchedule',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    log(scheduledDate.toString());

    // Save notification data
    NotificationModel notification = NotificationModel(
      id: id, // Use the id here
      title: 'Product Expiry Reminder',
      body:
          'The product "$productName" will soon be about to expire on $expDate.',
      scheduledDate: DateFormat('yyyy-MM-dd').format(startReminderDate),
    );
    await saveNotificationData(notification);
  }

  Future<void> saveNotificationData(NotificationModel notification) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    // Remove old notification with the same ID if exists
    notifications.removeWhere((notificationString) {
      final existingNotification =
          NotificationModel.fromMap(json.decode(notificationString));
      return existingNotification.id == notification.id;
    });

    notifications.add(json.encode(notification.toMap()));
    await prefs.setStringList('notifications', notifications);
  }

  Future<void> removeNotificationById(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationStrings =
        prefs.getStringList('notifications') ?? [];

    notificationStrings.removeWhere((notificationString) {
      final notification =
          NotificationModel.fromMap(json.decode(notificationString));
      return notification.id ==
          productId; // Directly compare with int productId
    });

    await prefs.setStringList('notifications', notificationStrings);
  }

  adminsignIn() async {
    try {
      emit(AdminSignInLoading());
      final response = await api.post(
        EndPoints.admin_login,
        isFormData: true,
        data: {
          ApiKey.email: adminSignInEmail.text,
          ApiKey.password: adminSignInPassword.text,
        },
      );
      admin = AdminLoginModel.fromJson(
          response); //جواه الماسيدج والتوكين اللي راجعين
      getIt<CacheHelper>()
          .saveData(key: ApiKey.api_token, value: admin!.api_token);
      //final decodedToken = JwtDecoder.decode(admin!.api_token);
      print(admin!.id);
      emit(AdminSignInSuccess());
    } on ServerException catch (e) {
      emit(AdminSignInFailure(errmessage: e.errModel.msg));
    } catch (e) {
      emit(AdminSignInFailure(errmessage: 'Invalid User Information'));
    }
  }

  Future<Map<String, dynamic>> fetchAdminDashboardData() async {
    final url = Uri.parse('http://mohamedsadek.c1.is/api/admin/index');
    final headers = {
      'auth_token': CacheHelper().getData(key: ApiKey.api_token).toString()
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }

  // Future<Map<String, dynamic>> fetchAdminDashboardData() async {
  //   try {
  //     final response = await api.get('admin/index', headers: {
  //       'auth-token': getIt<CacheHelper>().getData(key: ApiKey.api_token)
  //     });
  //     return response.data as Map<String,
  //         dynamic>;
  //   } catch (e) {
  //     throw Exception('Failed to fetch dashboard data: $e');
  //   }
  // }

  void adminlogOut() async {
    try {
      emit(AdminLogOutLoading());
      await api.post(EndPoints.admin_logout);
      emit(AdminLogOutSuccess());
    } on ServerException catch (e) {
      emit(AdminLogOutFailure(errmessage: e.errModel.errorMessage));
    }
  }

  Future<void> search() async {
    try {
      String searchText = searchController.text.trim();
      if (searchText.isEmpty) {
        emit(SearchFailure(
          errmessage: "Please write anything to search for",
        ));
        return;
      }
      emit(SearchLoading());
      final response = await api.post(
        EndPoints.search,
        isFormData: true,
        data: {
          ApiKey.search: searchController.text,
        },
      );
      final searchResult = SearchModel.fromJson(response);
      emit(SearchSuccess(
          data: searchResult)); // Pass the response data to the state
    } on DioException catch (exception) {
      final serverException = ServerException.fromDioException(exception);
      emit(SearchFailure(errmessage: serverException.errModel.message));
    } catch (e) {
      emit(SearchFailure(errmessage: 'No Results Found!'));
    }
  }

  void clearSearch() {
    searchController.clear();
    allData(); // Re-fetch all products when search is cleared
  }

  Future<void> exsearch() async {
    try {
      String searchText = exsearchController.text.trim();
      if (searchText.isEmpty) {
        emit(ExSearchFailure(
          errmessage: "Please write anything to search for",
        ));
        return;
      }
      emit(ExSearchLoading());
      final response = await api.post(
        EndPoints.searchexpire,
        isFormData: true,
        data: {
          ApiKey.search: exsearchController.text,
        },
      );
      final searchResult1 = ExSearchModel.fromJson(response);
      emit(ExSearchSuccess(
          data: searchResult1)); // Pass the response data to the state
    } on DioException catch (exception) {
      final serverException = ServerException.fromDioException(exception);
      emit(ExSearchFailure(errmessage: serverException.errModel.message));
    } catch (e) {
      emit(ExSearchFailure(errmessage: 'No Results Found!'));
    }
  }

  void clearExSearch() {
    exsearchController.clear();
    // emit(ExSearchSuccess(data: ExSearchModel(items: []))); // Emit empty search result
    expiredData(); // Re-fetch all products when search is cleared
  }

  Future<void> soonsearch() async {
    try {
      String searchText = soonsearchController.text.trim();
      if (searchText.isEmpty) {
        emit(SoonSearchFailure(
          errmessage: "Please write anything to search for",
        ));
        return;
      }
      emit(SoonSearchLoading());
      final response = await api.post(
        EndPoints.searchsoonexpire,
        isFormData: true,
        data: {
          ApiKey.search: soonsearchController.text,
        },
      );
      final searchResult2 = SoonSearchModel.fromJson(response);
      emit(SoonSearchSuccess(
          data: searchResult2)); // Pass the response data to the state
    } on DioException catch (exception) {
      final serverException = ServerException.fromDioException(exception);
      emit(SoonSearchFailure(errmessage: serverException.errModel.message));
    } catch (e) {
      emit(SoonSearchFailure(errmessage: 'No Results Found!'));
    }
  }

  void clearSoonSearch() {
    soonsearchController.clear();
    // emit(ExSearchSuccess(data: ExSearchModel(items: []))); // Emit empty search result
    soonExpiredData(); // Re-fetch all products when search is cleared
  }

  Future<void> userCount() async {
    try {
      emit(UserCountLoading());
      final response = await api.get(
        EndPoints.admin_countuser,
      );
      // count = UserCountModel.fromJson(response);
      emit(UserCountSuccess(count: UserCountModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(UserCountFailure(errmessage: e.errModel.errorMessage));
    }
  }

  void allusers() async {
    try {
      emit(AllUsersLoading());
      final response = await api.get(EndPoints.admin_getAllUsers);

      if (response is List) {
        List<AllUsersModel> usersList =
            response.map((x) => AllUsersModel.fromJson(x)).toList();
        emit(AllUsersSuccess(users: usersList));

        if (usersList.isNotEmpty) {
          dUser = usersList[0];
          await getIt<CacheHelper>().saveData(key: ApiKey.id, value: dUser!.id);
        }
      } else {
        emit(AllUsersFailure(errmessage: 'Unexpected response format'));
      }
    } on ServerException catch (e) {
      emit(AllUsersFailure(errmessage: e.errModel.errorMessage));
    }
  }

  void latestItems() async {
    try {
      emit(LatestItemsLoading());
      final response = await api.get(EndPoints.admin_latestItems);
      final List<dynamic> responseData = response as List<dynamic>;
      final List<LatestItemsModel> items =
          responseData.map((item) => LatestItemsModel.fromJson(item)).toList();
      emit(LatestItemsSuccess(items: items));

      if (items.isNotEmpty) {
        await getIt<CacheHelper>()
            .saveData(key: ApiKey.id, value: items.first.id);
      }
    } on ServerException catch (e) {
      emit(LatestItemsFailure(errmessage: e.errModel.errorMessage));
    }
  }

  void deleteItem(int id) async {
    try {
      emit(DeleteItemLoading());
      await api.delete(EndPoints.deleteItem(id));
      emit(DeleteItemSuccess());
      latestItems();
    } on ServerException catch (e) {
      emit(DeleteItemFailure(errMessage: e.errModel.errorMessage));
    }
  }

  void deleteUser(int id) async {
    try {
      emit(DeleteUserLoading());
      await api.delete(EndPoints.deleteUser(id));
      emit(DeleteUserSuccess());
      allusers();
    } on ServerException catch (e) {
      emit(DeleteUserFailure(errMessage: e.errModel.errorMessage));
    }
  }

  Future<void> calendersearch() async {
    try {
      String searchText = searchCalender.text.trim();
      if (searchText.isEmpty) {
        emit(SearchCalenderFailure(
          errmessage: "Please write anything to search for",
        ));
        return;
      }
      emit(SearchCalenderLoading());
      final response = await api.post(
        EndPoints.searchdate,
        isFormData: true,
        data: {
          ApiKey.search: searchCalender.text,
        },
      );
      final searchResult = SearchCalenderModel.fromJson(response);
      emit(SearchCalenderSuccess(
          data: searchResult)); // Pass the response data to the state
    } on DioException catch (exception) {
      final serverException = ServerException.fromDioException(exception);
      emit(SearchCalenderFailure(errmessage: serverException.errModel.message));
    } catch (e) {
      emit(SearchCalenderFailure(errmessage: 'No Results Found!'));
    }
  }

  void clearcalender() {
    searchCalender.clear();
    emit(UserInitial()); // Assuming UserInitial is the initial state
  }
}

class NotificationStream {
  static final NotificationStream _instance = NotificationStream._internal();
  final StreamController<void> _controller = StreamController.broadcast();

  factory NotificationStream() {
    return _instance;
  }

  NotificationStream._internal();

  Stream<void> get stream => _controller.stream;

  void notify() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }

  static NotificationStream get instance => _instance;
}
