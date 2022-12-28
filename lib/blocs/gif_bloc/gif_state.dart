part of 'gif_bloc.dart';

abstract class GIFState extends Equatable {
  const GIFState();

  @override
  List<Object?> get props => [];
}

class GIFInitial extends GIFState {}

class GIFLoading extends GIFState {}

class GIFLoaded extends GIFState {
  final GIFModel gifModel;
  const GIFLoaded(this.gifModel);
}

class GIFError extends GIFState {
  final String? message;
  const GIFError(this.message);
}