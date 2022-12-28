part of 'gif_bloc.dart';

abstract class GIFEvent extends Equatable {
  const GIFEvent();

  @override
  List<Object> get props => [];
}

class GetGIF extends GIFEvent {}