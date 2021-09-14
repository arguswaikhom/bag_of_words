import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/views/widgets/definition_widget.dart';
import 'package:flutter/material.dart';

class LearnedDefsList extends StatelessWidget {
  final List<Definition> defs;
  const LearnedDefsList({Key? key, required this.defs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: defs.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: DefinitionWidget(
            margin: EdgeInsets.zero,
            definition: defs[index],
          ),
        );
      },
    );
  }
}
