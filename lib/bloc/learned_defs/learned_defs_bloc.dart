import 'package:bag_of_words/bloc/learned_defs/learned_defs_event.dart';
import 'package:bag_of_words/bloc/learned_defs/learned_defs_state.dart';
import 'package:bag_of_words/data/repos/defs_repo.dart';
import 'package:bag_of_words/data/response/defs_response.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/utils/exceptions/empty_res_exception.dart';
import 'package:bag_of_words/utils/exceptions/failed_res_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnedDefsBloc extends Bloc<LearnedDefsEvent, LearnedDefsState> {
  final DefsRepo defsRepo;

  LearnedDefsBloc(this.defsRepo) : super(const LearnedDefsState.initial());

  @override
  Stream<LearnedDefsState> mapEventToState(LearnedDefsEvent event) async* {
    if (event is LearnedDefsFetchEvent) {
      try {
        DefsResponse res = await defsRepo.fetchLearnedDefs(url: state.nextURL);
        List<Definition> defs = state.defs + res.defs;
        yield state.copyWith(
          status: LearnedDefsStatus.SUCCESS,
          defs: defs,
          nextURL: res.nextUrl,
        );
      } on EmptyResException {
        yield state.copyWith(status: LearnedDefsStatus.EMPTY);
      } on FailedResException {
        yield state.copyWith(status: LearnedDefsStatus.FAILURE);
      }
    } else if (event is LearnedDefsAddSingleDefEvent) {
      /// If the new definition added is already in the list,
      /// remove the definition from the list first and
      /// add it to the top of the list
      List<Definition> updatedDefs = state.defs.where((element) {
        return element.word != event.definition.word;
      }).toList();

      updatedDefs.insert(0, event.definition);

      yield state.copyWith(
        status: LearnedDefsStatus.SUCCESS,
        defs: updatedDefs,
      );
    }
  }
}
