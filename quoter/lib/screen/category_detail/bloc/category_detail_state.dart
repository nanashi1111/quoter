part of 'category_detail_bloc.dart';

@freezed
class CategoryDetailState with _$CategoryDetailState {
  const factory CategoryDetailState.initial({required List<String> quotes, required List<String> imagePath}) = _Initial;
}
