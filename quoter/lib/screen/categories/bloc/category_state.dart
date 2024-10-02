part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial({required List<CategoryOfQuote> categories}) = _Initial;
}
