part of 'vibes_bloc.dart';

abstract class VibesState {}

class VibesInitial extends VibesState {}

class VibesLoaded extends VibesState {
  final List<dynamic> vibes; // TOOD: replace with model
  VibesLoaded(this.vibes);
}
