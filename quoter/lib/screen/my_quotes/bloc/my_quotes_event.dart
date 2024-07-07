part of 'my_quotes_bloc.dart';

@freezed
class MyQuotesEvent with _$MyQuotesEvent {
  const factory MyQuotesEvent.started() = _Started;
}
