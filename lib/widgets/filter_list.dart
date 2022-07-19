import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/tag/tag.dart';
import '../screens/home/bloc/home_bloc.dart';
import '../screens/home/bloc/home_provider.dart';

class FilterListWidget extends StatefulWidget {
  final List<Tag> tags;
  const FilterListWidget({Key? key, required this.tags}) : super(key: key);

  @override
  State<FilterListWidget> createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
  late HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = HomeProvider.of(context);
    return ListView.builder(
      itemCount: widget.tags.length,
      itemBuilder: ((context, index) {
        return ListTile(
          onTap: () {
            bloc.filterTasks(widget.tags[index].title);
          },
          title: Text(widget.tags[index].title),
        );
      }),
    );
  }
}
