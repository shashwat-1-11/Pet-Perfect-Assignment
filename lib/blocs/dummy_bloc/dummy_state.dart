part of 'dummy_bloc.dart';

abstract class DummyState extends Equatable {
  const DummyState();

  @override
  List<Object?> get props => [];
}

class DummyInitial extends DummyState {}

class DummyLoading extends DummyState {}

class DummyLoaded extends DummyState {
  final DummyModel dummyModel;
  const DummyLoaded(this.dummyModel);
}

class DummyError extends DummyState {
  final String? message;
  const DummyError(this.message);
}