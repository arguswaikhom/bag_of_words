import 'package:bag_of_words/data/repos/day_revision_repo.dart';
import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/models/day_stat_word.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/enums/action_word_action.dart';
import 'package:bag_of_words/views/widgets/circle_widget.dart';
import 'package:bag_of_words/views/widgets/definition_widget.dart';
import 'package:flutter/material.dart';

class DayRecallPage extends StatefulWidget {
  final DayStat dayStat;
  final DayRevisionRepo dayRevisionRepo;

  const DayRecallPage({
    Key? key,
    required this.dayStat,
    required this.dayRevisionRepo,
  }) : super(key: key);

  @override
  _DayRecallPageState createState() => _DayRecallPageState();
}

class _DayRecallPageState extends State<DayRecallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBg,
      appBar: AppBar(
        title: Text(AppString.dayRevision),
        elevation: 0,
      ),
      body: _getPageContent(),
    );
  }

  Widget _getPageContent() {
    final words = widget.dayStat.words;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: words.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return _getListViewHeader();
        return _getWordWidget(words[index - 1]);
      },
    );
  }

  _getListViewHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleWidget(
              margin: EdgeInsets.symmetric(horizontal: 8),
              color: AppColor.learned,
              diameter: 20,
            ),
            Text(
              AppString.learned,
              style: TextStyle(color: AppColor.wordDefColor),
            ),
            SizedBox(
              width: 16,
            ),
            CircleWidget(
              margin: EdgeInsets.symmetric(horizontal: 8),
              color: AppColor.recalled,
              diameter: 20,
            ),
            Text(
              AppString.recalled,
              style: TextStyle(color: AppColor.wordDefColor),
            ),
          ],
        ),
      ),
    );
  }

  _getWordWidget(final DayStatWord wordObj) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.wordWidgetBg,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          InkWell(
            child: Row(
              children: [
                CircleWidget(
                    color: wordObj.word.action ==
                            ActionWordActionX.createFromAnyString(
                                AppString.actionLearn)
                        ? AppColor.learned
                        : AppColor.recalled,
                    diameter: 24),
                SizedBox(
                  width: 12,
                ),
                Text(
                  wordObj.word.word,
                  style: TextStyle(fontSize: 16, color: AppColor.wordDefColor),
                ),
                Expanded(child: Container()),
                Visibility(
                  visible: wordObj.isDefFetching,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: CircularProgressIndicator(),
                    height: 20,
                    width: 20,
                  ),
                ),
                Icon(
                  wordObj.isDefVisible
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.wordHintColor,
                ),
              ],
            ),
            onTap: () async {
              if (wordObj.def == null) {
                setState(() {
                  wordObj.isDefFetching = !wordObj.isDefFetching;
                });

                try {
                  final Definition def = await widget.dayRevisionRepo
                      .fetchDefinition(wordObj.word.word, false);

                  setState(() {
                    wordObj.isDefVisible = !wordObj.isDefVisible;
                    wordObj.def = def;
                  });
                } on Exception {
                  // MessageUtils(context).showSToast(AppString.failedToGetDefinition);
                  return;
                }

                setState(() {
                  wordObj.isDefFetching = !wordObj.isDefFetching;
                });
              } else {
                wordObj.isDefVisible = !wordObj.isDefVisible;
                setState(() {});
              }
            },
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: wordObj.isDefVisible
                ? Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        height: 2,
                        color: AppColor.wordHintColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefinitionWidget(
                        definition: wordObj.def!,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        showWord: false,
                      )
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
