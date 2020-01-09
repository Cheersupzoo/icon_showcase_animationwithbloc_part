import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IconlistEvent extends Equatable {
  IconlistEvent([List props = const[]]) : super(props);
}

class LoadDefaultIcon extends IconlistEvent{
  @override
  String toString() => 'LoadDefaultIcon';
}

class AddIcon extends IconlistEvent{
  @override
  String toString() => 'AddIcon';
}

class RemoveIcon extends IconlistEvent{
  final int removeIndex;

  RemoveIcon(this.removeIndex);

  @override
  String toString() => 'RemoveIcon';
}