import 'package:equatable/equatable.dart';

abstract class DayRevisionSummaryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DayRevisionSummaryFetchEvent extends DayRevisionSummaryEvent {}
