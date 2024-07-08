// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:reminder_app/cache/cache_helper.dart';
// import 'package:reminder_app/core/api/api_consumer.dart';
// import 'package:reminder_app/core/api/end_points.dart';
// import 'package:reminder_app/core/errors/exceptions.dart';
// import 'package:reminder_app/cubit/user_state.dart';
// import 'package:reminder_app/models/latest_items_model.dart';
// import 'package:reminder_app/service/service_Locator.dart';

// class ItemCubit extends Cubit<UserState> {
//   ItemCubit(this.api) : super(UserInitial());
//   final ApiConsumer api;

//   Future<void> latestItems() async {
//   try {
//     emit(LatestItemsLoading());
    
//     // Assuming the response is a JSON string
//     final response = await api.get(EndPoints.admin_latestItems);
    
//     // Ensure response is a List
//     final List<dynamic> responseData = response as List<dynamic>;
    
//     // Map the response to LatestItemsModel
//     final List<LatestItemsModel> items = responseData
//         .map((item) => LatestItemsModel.fromJson(item))
//         .toList();
    
//     emit(LatestItemsSuccess(items: items));
    
//     // Save the first item's id, if needed
//     if (items.isNotEmpty) {
//       await getIt<CacheHelper>().saveData(key: ApiKey.id, value: items.first.id);
//     }
//   } on ServerException catch (e) {
//     emit(LatestItemsFailure(errmessage: e.errModel.errorMessage));
//   }
// }
// }


