enum ActionWordAction { LEARN, RECALL }

extension ActionWordActionX on ActionWordAction {
  static ActionWordAction createFromAnyString(String string) {
    return ActionWordAction.values.firstWhere((e) {
      final action = '${(ActionWordAction).toString()}.${string.toUpperCase()}';
      return e.toString() == action;
    });
  }
}
