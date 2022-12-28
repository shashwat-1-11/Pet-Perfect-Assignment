import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_assignment/models/dummy_model.dart';
import 'package:pet_perfect_assignment/resources/api_repository.dart';

part 'dummy_event.dart';
part 'dummy_state.dart';

class  DummyBloc extends Bloc<DummyEvent, DummyState> {
   DummyBloc() : super(DummyInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDummyList>((event, emit) async {
      try {
        emit(DummyLoading());
        final mList = await _apiRepository.fetchDummyList();
        emit( DummyLoaded(mList));
        if (mList.error != null) {
          emit( DummyError(mList.error));
        }
      } on NetworkError {
        emit( DummyError("Failed to fetch data. is your device online?"));
      }
    });
  }
}