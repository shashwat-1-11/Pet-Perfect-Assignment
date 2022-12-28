part of 'dummy_bloc.dart';

abstract class DummyEvent extends Equatable {
  const DummyEvent();

  @override
  List<Object> get props => [];
}

class GetDummyList extends DummyEvent {}