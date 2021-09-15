import 'package:bag_of_words/models/definition.dart';
import 'package:equatable/equatable.dart';

enum AddWordStatus { NONE, ADDING, SUCCESS, FAILURE }

class AddWordState extends Equatable {
  final AddWordStatus status;
  final String? word;
  final Definition? definition;

  const AddWordState._({required this.status, this.word, this.definition});

  const AddWordState.none() : this._(status: AddWordStatus.NONE);

  AddWordState copyWith({
    AddWordStatus? status,
    String? word,
    Definition? definition,
  }) {
    return AddWordState._(
      status: status ?? this.status,
      word: word ?? this.word,
      definition: definition ?? this.definition,
    );
  }

  @override
  List<Object?> get props => [status, word, definition];
}
