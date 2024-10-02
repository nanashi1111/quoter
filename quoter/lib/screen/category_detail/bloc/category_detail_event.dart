part of 'category_detail_bloc.dart';

@freezed
class CategoryDetailEvent with _$CategoryDetailEvent {
  const factory CategoryDetailEvent.started({required CategoryOfQuote category}) = _Started;
}
