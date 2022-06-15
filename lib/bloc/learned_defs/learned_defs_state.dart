import 'package:equatable/equatable.dart';

import 'package:bag_of_words/models/definition.dart';

enum LearnedDefsStatus { INITIAL, SUCCESS, EMPTY, FAILURE }

class LearnedDefsState extends Equatable {
  final LearnedDefsStatus status;
  final List<Definition> defs;
  final String? nextURL;

  const LearnedDefsState._({
    this.status = LearnedDefsStatus.INITIAL,
    this.defs = const [],
    this.nextURL,
  });

  const LearnedDefsState.initial() : this._();

  LearnedDefsState copyWith({
    LearnedDefsStatus? status,
    List<Definition>? defs,
    String? nextURL,
  }) {
    return LearnedDefsState._(
      status: status ?? this.status,
      defs: defs ?? this.defs,
      nextURL: nextURL ?? nextURL,
    );
  }

  @override
  List<Object?> get props => [status, defs, nextURL];
}
