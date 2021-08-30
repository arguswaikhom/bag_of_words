import 'package:bag_of_words/controller/HomePageController.dart';
import 'package:bag_of_words/model/DayStat.dart';
import 'package:bag_of_words/model/DayStatWord.dart';
import 'package:bag_of_words/model/Definition.dart';
import 'package:bag_of_words/res/AppColor.dart';
import 'package:bag_of_words/res/AppString.dart';
import 'package:bag_of_words/utils/MessageUtils.dart';
import 'package:bag_of_words/widget/CircleWidget.dart';
import 'package:bag_of_words/widget/DefinitionWidget.dart';
import 'package:flutter/material.dart';

class DayRecallPage extends StatefulWidget {
  final DayStat dayStat;

  const DayRecallPage({
    Key? key,
    required this.dayStat,
  }) : super(key: key);

  @override
  _DayRecallPageState createState() => _DayRecallPageState(this.dayStat);
}

class _DayRecallPageState extends State<DayRecallPage> {
  final DayStat dayStat;

  _DayRecallPageState(this.dayStat);

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
    final words = this.dayStat.words;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: words!.length + 1,
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
                    color: wordObj.action == AppString.actionLearn
                        ? AppColor.learned
                        : AppColor.recalled,
                    diameter: 24),
                SizedBox(
                  width: 12,
                ),
                Text(
                  wordObj.word!,
                  style: TextStyle(fontSize: 16, color: AppColor.wordDefColor),
                ),
                Expanded(child: Container()),
                Visibility(
                  visible: wordObj.isProgressing,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: CircularProgressIndicator(),
                    height: 20,
                    width: 20,
                  ),
                ),
                Icon(
                  wordObj.isVisible
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.wordHintColor,
                ),
              ],
            ),
            onTap: () async {
              if (wordObj.def == null) {
                setState(() {
                  wordObj.isProgressing = !wordObj.isProgressing;
                });

                final Definition def = await HomePageController.getInstance()
                    .fetchDefinition(wordObj.word, false);
                setState(() {
                  wordObj.isProgressing = !wordObj.isProgressing;
                });
                if (def == null) {
                  // MessageUtils(context).showSToast(AppString.failedToGetDefinition);
                  return;
                }

                setState(() {
                  wordObj.isVisible = !wordObj.isVisible;
                  wordObj.def = def;
                });
              } else {
                wordObj.isVisible = !wordObj.isVisible;
                setState(() {});
              }
            },
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: wordObj.isVisible
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
