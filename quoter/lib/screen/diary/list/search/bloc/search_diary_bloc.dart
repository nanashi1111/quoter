import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/repositories/diary_repository.dart';

part 'search_diary_event.dart';
part 'search_diary_state.dart';
part 'search_diary_bloc.freezed.dart';

class SearchDiaryBloc extends Bloc<SearchDiaryEvent, SearchDiaryState> {

  final DiaryRepository diaryRepository = getIt.get<DiaryRepository>();

  SearchDiaryBloc() : super(const SearchDiaryState.initial(diaries: [])) {
    on<_Search>((event, emit) async {
      List<Diary> diaries = await diaryRepository.searchDiaries(event.query);
      emit(SearchDiaryState.initial(diaries: diaries));
    });
  }
}
