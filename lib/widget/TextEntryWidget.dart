import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class TextEntryWidget extends StatelessWidget {
  final Function onClickedAdd;

  const TextEntryWidget({required this.onClickedAdd, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTextEntryWidget();
  }

  _getTextEntryWidget() {
    final addNewWordController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(16.0),
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
