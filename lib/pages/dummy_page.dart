import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_assignment/blocs/dummy_bloc/dummy_bloc.dart';
import 'package:pet_perfect_assignment/models/dummy_model.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  final DummyBloc _newsBloc = DummyBloc();

  @override
  void initState() {
    _newsBloc.add(GetDummyList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dummies List')),
      body: _buildListDummy(),
    );
  }

  Widget _buildListDummy() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<DummyBloc, DummyState>(
          listener: (context, state) {
            if (state is DummyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DummyBloc, DummyState>(
            builder: (context, state) {
              if (state is DummyInitial) {
                return _buildLoading();
              } else if (state is DummyLoading) {
                return _buildLoading();
              } else if (state is DummyLoaded) {
                return _buildCard(context, state.dummyModel);
              } else if (state is DummyError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, DummyModel model) {
    return ListView.builder(
      itemCount: model.dummies!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("ID: ${model.dummies![index].id}"),
                  Text(
                      "User id: ${model.dummies![index].userId}"),
                  Text("Title: ${model.dummies![index].title}"),
                  Text(
                      "Body: ${model.dummies![index].body}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}