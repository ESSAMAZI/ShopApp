import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  GetSearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHeplper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {
      emit(SearchSuccessState());
      model = GetSearchModel.fromJson(value.data);
    }).catchError((onError) {
      emit(SearchErrorState(onError));
    });
  }
}
