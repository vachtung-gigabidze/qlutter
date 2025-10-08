///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsMainEn main = TranslationsMainEn._(_root);
	late final TranslationsLevelsEn levels = TranslationsLevelsEn._(_root);
	late final TranslationsSessionEn session = TranslationsSessionEn._(_root);
	late final TranslationsWinEn win = TranslationsWinEn._(_root);
	late final TranslationsInfoEn info = TranslationsInfoEn._(_root);
	late final TranslationsSettingEn setting = TranslationsSettingEn._(_root);
}

// Path: main
class TranslationsMainEn {
	TranslationsMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get play => 'Play';
	String get setting => 'Settings';
}

// Path: levels
class TranslationsLevelsEn {
	TranslationsLevelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Levels';
	String get tutorial => 'Tutorial';
	String get back => 'Back';
}

// Path: session
class TranslationsSessionEn {
	TranslationsSessionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Level';
	String get back => 'Back';
	late final TranslationsSessionTutorialEn tutorial = TranslationsSessionTutorialEn._(_root);
}

// Path: win
class TranslationsWinEn {
	TranslationsWinEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Win!';
	String get time => 'Time';
	String get step => 'Step';
	String get next => 'Next';
	String get back => 'Levels';
}

// Path: info
class TranslationsInfoEn {
	TranslationsInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get back => 'Close';
	String get text => 'The goal is to roll all the colored balls on the playing field into holes of the same color. The balls move only in a straight line to the first obstacle.';
}

// Path: setting
class TranslationsSettingEn {
	TranslationsSettingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	String get theme => 'Theme';
	String get reset => 'Reset progress';
	late final TranslationsSettingLanguageEn language = TranslationsSettingLanguageEn._(_root);
	String get back => 'Back';
}

// Path: session.tutorial
class TranslationsSessionTutorialEn {
	TranslationsSessionTutorialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tutorial';
	List<String> get steps => [
		'Step 1: Press on the ball.',
		'Step 2: Press on the arrow.',
		'Step 3: Repeat steps 1 and 2.',
	];
}

// Path: setting.language
class TranslationsSettingLanguageEn {
	TranslationsSettingLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Language';
	late final TranslationsSettingLanguageLanguagesEn languages = TranslationsSettingLanguageLanguagesEn._(_root);
}

// Path: setting.language.languages
class TranslationsSettingLanguageLanguagesEn {
	TranslationsSettingLanguageLanguagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ru => 'Russian';
	String get en => 'English';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'main.play': return 'Play';
			case 'main.setting': return 'Settings';
			case 'levels.title': return 'Levels';
			case 'levels.tutorial': return 'Tutorial';
			case 'levels.back': return 'Back';
			case 'session.title': return 'Level';
			case 'session.back': return 'Back';
			case 'session.tutorial.title': return 'Tutorial';
			case 'session.tutorial.steps.0': return 'Step 1: Press on the ball.';
			case 'session.tutorial.steps.1': return 'Step 2: Press on the arrow.';
			case 'session.tutorial.steps.2': return 'Step 3: Repeat steps 1 and 2.';
			case 'win.title': return 'Win!';
			case 'win.time': return 'Time';
			case 'win.step': return 'Step';
			case 'win.next': return 'Next';
			case 'win.back': return 'Levels';
			case 'info.back': return 'Close';
			case 'info.text': return 'The goal is to roll all the colored balls on the playing field into holes of the same color. The balls move only in a straight line to the first obstacle.';
			case 'setting.title': return 'Settings';
			case 'setting.theme': return 'Theme';
			case 'setting.reset': return 'Reset progress';
			case 'setting.language.title': return 'Language';
			case 'setting.language.languages.ru': return 'Russian';
			case 'setting.language.languages.en': return 'English';
			case 'setting.back': return 'Back';
			default: return null;
		}
	}
}

