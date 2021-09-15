import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class TextEntryWidget extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function onClickedAdd;

  const TextEntryWidget({
    Key? key,
    required this.onClickedAdd,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTextEntryWidget();
  }

  _getTextEntryWidget() {
    final addNewWordController = TextEditingController();

    return Container(
      padding: padding,
      margin: margin,
      height: 64.0,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.blue[50],
        color: AppColor.wordWidgetBg,
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: TextStyle(color: AppColor.wordHintColor),
              controller: addNewWordController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a new word',
                  hintStyle: TextStyle(color: AppColor.wordHintColor)),
            ),
          ),
          TextButton(
            child: Text('ADD'),
            onPressed: () => onClickedAdd(addNewWordController.text),
          ),
        ],
      ),
    );
  }
}
