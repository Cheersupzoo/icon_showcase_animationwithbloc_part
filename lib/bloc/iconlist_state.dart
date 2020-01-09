import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icon_showcase_animationwithbloc_part/icon_data.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IconlistState extends Equatable {
  IconlistState([List props = const []]) : super(props);
}

class IconListLoaded extends IconlistState {
  final List<IconModel> iconList;
  IconListLoaded( [this.iconList ]) : super([iconList]);

  @override
  String toString() {
    return 'IconListLoaded { iconList : $iconList}';
  }
}

class IconListLoading extends IconlistState {

  @override
  String toString() {
    return 'IconListLoading';
  }
}
