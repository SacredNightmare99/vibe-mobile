import 'package:flutter_bloc/flutter_bloc.dart';

part 'vibes_event.dart';
part 'vibes_state.dart';

class VibesBloc extends Bloc<VibesEvent, VibesState> {
  VibesBloc() : super(VibesInitial()) {
    on<LoadVibeHistory>(_onLoadVibeHistory);
  }

  Future<void> _onLoadVibeHistory(
    LoadVibeHistory event,
    Emitter<VibesState> emit,
  ) async {
    // TODO: parse .vibes/log.json
    emit(VibesLoaded([]));
  }
}
