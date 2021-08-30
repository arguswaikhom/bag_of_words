import 'package:bag_of_words/model/Definition.dart';
import 'package:bag_of_words/model/Sense.dart';
import 'package:bag_of_words/res/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DefinitionWidget extends StatelessWidget {
  final Definition definition;
  final margin;
  final padding;
  final showWord;

  const DefinitionWidget({
    required this.definition,
    this.showWord: true,
    this.margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getDefinitionWidget();
  }

  Widget _getDefinitionWidget() {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColor.wordWidgetBg,
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          this.showWord
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    definition.word!,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.wordColor),
                  ),
                )
              : Container(),
          _getPhoneticWidgets(),
          _getSenseWidgets(),
        ],
      ),
    );
  }

  _getPhoneticWidgets() {
    if (definition.phonetics?.length == 0) {
      return Container();
    }

    return Container(
      height: 32,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: AppColor.wordWidgetBg),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: definition.phonetics!.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColor.wordAudioBg,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    definition.phonetics![index].phonetic!,
                    style: TextStyle(color: AppColor.wordPhoneticColor),
                  ),
                  Icon(
                    Icons.volume_up_rounded,
                    // color: Colors.blue,
                    color: AppColor.wordAudioIconColor,
                  ),
                ],
              ),
            ),
            onTap: () async {
              final player = AudioPlayer();
              await player.setUrl(definition.phonetics![index].audio!);
              player.play();
            },
          );
        },
      ),
    );
  }

  _getSenseWidgets() {
    if (definition.senses?.length == 0) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: definition.senses!.length > 2 ? 2 : definition.senses!.length,
      itemBuilder: (context, index) {
        Sense sense = definition.senses![index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            // color: Colors.blue[100],
            color: AppColor.wordDefBg,
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.0,
              ),
            ),
            shape: BoxShape.rectangle,
          ),
          // padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text(
                  sense.definition!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.wordDefColor),
                ),
              ),
              _getExamples(sense.examples!)
            ],
          ),
        );
      },
    );
  }

  _getExamples(List<String> examples) {
    if (examples.length == 0) {
      return Container();
    }

    String exampleString = '';
    for (var i = 0; i < 3 && i < examples.length; i++) {
      exampleString += '- ' + examples[i].trim() + '\n';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.blue[200],
        color: AppColor.wordEgBg,
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
        shape: BoxShape.rectangle,
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        exampleString.trim(),
        style: TextStyle(color: AppColor.wordEgColor),
      ),
    );
  }
}
