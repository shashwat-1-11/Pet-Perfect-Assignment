import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_assignment/models/gif_model.dart';
import 'package:pet_perfect_assignment/resources/api_repository.dart';

part 'gif_event.dart';
part 'gif_state.dart';

class  GIFBloc extends Bloc<GIFEvent, GIFState> {
  GIFBloc() : super(GIFInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetGIF>((event, emit) async {
      try {
        emit(GIFLoading());
        final mList = await _apiRepository.fetchGIF();
        emit(GIFLoaded(mList));
        if (mList.error != null) {
          emit(GIFError(mList.error));
        }
      } on NetworkError {
        emit(GIFError("Failed to fetch data. is your device online?"));
      }
    });
  }
}