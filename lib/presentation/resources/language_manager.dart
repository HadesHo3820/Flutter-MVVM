enum LanguageType { english, vietnamese }

const String vietnamese = "vi";
const String english = "en";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.vietnamese:
        return vietnamese;
    }
  }
}
