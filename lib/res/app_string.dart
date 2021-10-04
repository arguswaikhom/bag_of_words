class AppString {
  // static const apiDomain = 'http://192.168.29.138:8000/';
  static const apiDomain = 'https://djangocheck-fd8d2.uc.r.appspot.com/';

  // static const apiDomain = 'http://127.0.0.1:8000/';
  static const apiDefinition = apiDomain + 'bow/def/';
  static const apiDefinitions = apiDomain + 'bow/defs/';
  static const apiDayStat = apiDomain + 'bow/stat/day/';

  static const keyStatus = 'status';
  static const statusEmpty = 'empty';

  static const actionLearn = 'learn';
  static const actionRecall = 'recall';

  static const appName = 'Bag of words';
  static const failedToSignIn = 'Sign in failed';
  static const failedToGetDefinition = 'Failed to get definition!!';
  static const failedToGetData = 'Failed to get data!!';
  static const addWordToDisplayHere = 'Add word to display here!!';
  static const onlyTheLatest10DefinitionsDisplays =
      'Only the latest 10 definitions displays';
  static const wordLearnedToday = 'words learned today';
  static const wordsLearnedYesterday = 'words learned yesterday';
  static const enterAWord = 'Enter a word to add.';
  static const searchSingleWordOnly = 'Search a single word only.';

  static const dayRevision = 'Day revision';
  static const learned = 'Learned';
  static const recalled = 'Recalled';
}
