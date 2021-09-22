import 'package:bag_of_words/models/definition.dart';

class AppMockData {
  static String rowDefinition =
      '{"word": "mine","source_url": "https://www.oxfordlearnersdictionaries.com/definition/english/mine","origin": "Word Originpronoun Old English mīn, of Germanic origin; related to me (pronoun) and to Dutch mijn and German mein.","phonetics":[{"phonetic": "/maɪn/","audio": "https://www.oxfordlearnersdictionaries.com/media/english/uk_pron/m/min/mine_/mine__gb_1.mp3"},{"phonetic": "/maɪn/","audio": "https://www.oxfordlearnersdictionaries.com/media/english/us_pron/m/min/mine_/mine__us_1.mp3"}],"senses":[{"definition": "of or belonging to the person writing or speaking","examples": ["That\'s mine."," of mine He\'s a friend of mine (= one of my friends).","She wanted one like mine (= like I have)."]},{"definition": "my home","examples":["Let\'s go back to mine after the show."]}]}';
  static Definition definition = Definition.fromJson(rowDefinition)!;

  static Map<String, dynamic> dayLearned = {
    "status": "SUCCESS",
    "stat": {
      "words": [
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "hello",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/hello",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "ecstasy",
          "action": "RECALL",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/ecstasy",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "flounce",
          "action": "RECALL",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/flounce",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "disdain",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/disdain",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "appendicitis",
          "action": "RECALL",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/appendicitis",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "pivot",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/pivot",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "chiffon",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/chiffon",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "attired",
          "action": "RECALL",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/attired",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "ectoplasm",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/ectoplasm",
        },
        {
          "definition": null,
          "isVisible": false,
          "isProgressing": false,
          "word": "lather",
          "action": "LEARN",
          "url":
              "https://www.oxfordlearnersdictionaries.com/definition/english/lather",
        },
      ],
      "total": 10,
      "learn": 6,
      "recall": 4
    },
  };
}
