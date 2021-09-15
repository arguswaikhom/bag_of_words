import 'package:bag_of_words/bloc/home/addword/add_word_event.dart';
import 'package:bag_of_words/bloc/home/addword/add_work_state.dart';
import 'package:bag_of_words/bloc/home/learned_defs_bloc.dart';
import 'package:bag_of_words/bloc/home/learned_defs_event.dart';
import 'package:bag_of_words/data/repos/day_revision_repo.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWordBloc extends Bloc<AddWordEvent, AddWordState> {
  final DayRevisionRepo repo;
  final LearnedDefsBloc learnedDefsBloc;

  AddWordBloc(this.repo, this.learnedDefsBloc) : super(AddWordState.none());

  @override
  Stream<AddWordState> mapEventToState(AddWordEvent event) async* {
    if (event is AddWordAddEvent) {
      yield state.copyWith(status: AddWordStatus.ADDING);

      try {
        Definition definition = await repo.fetchDefinition(event.word, true);

        /// Initiate an event to add the newly added definition to the
        /// list of user learned definition
        learnedDefsBloc.add(LearnedDefsAddSingleDefEvent(definition));

        yield state.copyWith(
          status: AddWordStatus.SUCCESS,
          word: event.word,
          definition: definition,
        );
      } on Exception {
        yield state.copyWith(status: AddWordStatus.FAILURE, word: event.word);
      }
    }
  }
}
