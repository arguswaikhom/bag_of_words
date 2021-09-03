import 'package:bag_of_words/controller/AppBottomSheet.dart';
import 'package:bag_of_words/controller/HomePageController.dart';
import 'package:bag_of_words/model/DayStat.dart';
import 'package:bag_of_words/model/Definition.dart';
import 'package:bag_of_words/model/DefinitionsResponse.dart';
import 'package:bag_of_words/page/DayRecallPage.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/MessageUtils.dart';
import 'package:bag_of_words/widget/DayStatEntry.dart';
import 'package:bag_of_words/widget/DefinitionWidget.dart';
import 'package:bag_of_words/widget/HomePageActions.dart';
import 'package:bag_of_words/widget/TextEntryWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _controller = HomePageController.getInstance();

  // [0] -> today's day stat
  // [1] -> yesterday's day stat
  // [2] -> definitions
  List<dynamic> _dataset = <dynamic>[null, null, null];

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBg,
      appBar: AppBar(
        title: Text(AppString.appName),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              AppBottomSheet(
                context: context,
                child: HomePageActions(),
              ).show();
            },
          ),
        ],
      ),
      body: _getBodyWidget(),
    );
  }

  _getBodyWidget() {
    return Stack(
      children: [
        _getContentWidget(),
        Container(
          alignment: Alignment.bottomCenter,
          child: TextEntryWidget(onClickedAdd: _onPressedAddWord),
        )
      ],
    );
  }

  _onPressedAddWord(final String word) async {
    final MessageUtils msgUtils = MessageUtils(context);
    if (word.trim().isEmpty) {
      // msgUtils.showSLightCenterToast(AppString.enterAWord);
      return;
    }

    final wordCount = word.split(" ").length;
    if (wordCount > 1) {
      // msgUtils.showSLightCenterToast(AppString.searchSingleWordOnly);
      return;
    }

    final def = await _controller.fetchDefinition(word, true);
    if (def == null) {
      // msgUtils.showSLightCenterToast(AppString.failedToGetDefinition);
      return;
    }

    if (_dataset[2] == null) _dataset[2] = DefinitionsResponse();
    _dataset[2].defs.insert(0, def);
    setState(() {});
  }

  _fetchData() async {
    final responses = await Future.wait([
      _controller.fetchTodaysStat(),
      _dataset[1] == null
          ? _controller.fetchYesterdaysStat()
          : Future(() => _dataset[1]),
      _dataset[2] == null
          ? _controller.fetchLearnedDefinitions()
          : Future(() => _dataset[2]),
    ]);
    _dataset = responses;
    return _dataset;
  }

  _displayContentError(final String msg) {
    return Expanded(
      child: Center(
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 16,
            color: AppColor.wordDefColor,
          ),
        ),
      ),
    );
  }

  _getContentWidget() {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            _dataset[2] == null) {
          return Column(
            children: [
              _getRevisionWidgets(),
              Expanded(child: Center(child: CircularProgressIndicator()))
            ],
          );
        }

        if (_dataset[2] == null || _dataset[2].defs == null) {
          return Column(
            children: [
              _getRevisionWidgets(),
              _displayContentError(AppString.failedToGetData)
            ],
          );
        }

        final List<Definition> definitions = _dataset[2].defs;
        if (definitions.length == 0) {
          return Column(
            children: [
              _getRevisionWidgets(),
              _displayContentError(AppString.addWordToDisplayHere)
            ],
          );
        }

        return Container(
          margin: EdgeInsets.only(bottom: 80),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: definitions.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) return _getRevisionWidgets();

              if (index <= definitions.length) {
                return DefinitionWidget(
                  definition: definitions[index - 1],
                );
              }

              return Center(
                child: Padding(
                  child: Text(
                    AppString.onlyTheLatest10DefinitionsDisplays,
                    style: TextStyle(color: AppColor.wordColor),
                  ),
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _getRevisionWidgets() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          DayStatEntry(
            count: _dataset[0] == null
                ? null
                : _controller.dualNum(_dataset[0].total),
            label: AppString.wordLearnedToday,
            onTap: () => _navDayRecallPage(_dataset[0]),
          ),
          SizedBox(height: 16),
          DayStatEntry(
            count: _dataset[1] == null
                ? null
                : _controller.dualNum(_dataset[1].total),
            label: AppString.wordsLearnedYesterday,
            onTap: () => _navDayRecallPage(_dataset[1]),
          ),
        ],
      ),
    );
  }

  _navDayRecallPage(final DayStat? dayStat) {
    if (dayStat == null || dayStat.total == 0) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayRecallPage(
          dayStat: dayStat,
        ),
      ),
    );
  }
}
