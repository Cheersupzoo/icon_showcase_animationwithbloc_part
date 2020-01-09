import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './iconlist.dart';
import 'package:icon_showcase_animationwithbloc_part/icon_data.dart'
    as iconData;
import 'dart:math';

class IconlistBloc extends Bloc<IconlistEvent, IconlistState> {
  @override
  IconlistState get initialState => IconListLoading();

  @override
  Stream<IconlistState> mapEventToState(
    IconlistEvent event,
  ) async* {
    if (event is AddIcon) {
      yield* _mapAddIconToState();
    } else if (event is RemoveIcon) {
      yield* _mapRemoveIconToState(event);
    } else if (event is LoadDefaultIcon) {
      yield* _mapLoadDefaultIconToState();
    }
  }

  Stream<IconlistState> _mapAddIconToState() async* {
    if (currentState is IconListLoaded) {
      final newlist = iconData.newIconList();
      final newIcon = newlist[Random().nextInt((newlist.length - 1))];
      final List<iconData.IconModel> updatedIconList =
          List.from((currentState as IconListLoaded).iconList);
      updatedIconList.add(newIcon);

      yield IconListLoaded(updatedIconList);
    }
  }

  Stream<IconlistState> _mapRemoveIconToState(RemoveIcon event) async* {
    if ((currentState as IconListLoaded).iconList.length != 0) {
      final List<iconData.IconModel> updatedIconList =
          List.from((currentState as IconListLoaded).iconList);
      updatedIconList.removeAt(event.removeIndex);
      yield IconListLoaded(updatedIconList);
    }
  }

  Stream<IconlistState> _mapLoadDefaultIconToState() async* {
    final iconList = iconData.iconList;
    yield IconListLoaded(iconList);
  }
}
