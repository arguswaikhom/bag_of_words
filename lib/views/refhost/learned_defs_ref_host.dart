import 'package:bag_of_words/bloc/home/learned_defs_state.dart';
import 'package:bag_of_words/views/reps/learneddefs/learned_defs_initial_empty_response.dart';
import 'package:bag_of_words/views/reps/learneddefs/learned_defs_initial_failure_response.dart';
import 'package:bag_of_words/views/reps/learneddefs/learned_defs_initial_loading.dart';
import 'package:bag_of_words/views/reps/learneddefs/learned_defs_list.dart';
import 'package:flutter/material.dart';

class LearnedDefsRefHost extends StatelessWidget {
  final LearnedDefsState state;
  const LearnedDefsRefHost({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case LearnedDefsStatus.INITIAL:
        return LearnedDefsInitialLoading();
      case LearnedDefsStatus.EMPTY:
        return LearnedDefsInitialEmptyResponse();
      case LearnedDefsStatus.FAILURE:
        return LearnedDefsInitialFailure();
      case LearnedDefsStatus.SUCCESS:
        return LearnedDefsList(defs: state.defs);
    }
  }
}
