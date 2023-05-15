/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 50 (25 per locale)
///
/// Built on 2023-05-15 at 06:54 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	ru(languageCode: 'ru', build: _StringsRu.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsMainEn main = _StringsMainEn._(_root);
	late final _StringsLevelsEn levels = _StringsLevelsEn._(_root);
	late final _StringsSessionEn session = _StringsSessionEn._(_root);
	late final _StringsWinEn win = _StringsWinEn._(_root);
	late final _StringsInfoEn info = _StringsInfoEn._(_root);
	late final _StringsSettingEn setting = _StringsSettingEn._(_root);
}

// Path: main
class _StringsMainEn {
	_StringsMainEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get play => 'Play';
	String get setting => 'Settings';
}

// Path: levels
class _StringsLevelsEn {
	_StringsLevelsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Levels';
	String get tutorial => 'Tutorial';
	String get back => 'Back';
}

// Path: session
class _StringsSessionEn {
	_StringsSessionEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Level';
	String get back => 'Back';
	late final _StringsSessionTutorialEn tutorial = _StringsSessionTutorialEn._(_root);
}

// Path: win
class _StringsWinEn {
	_StringsWinEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Win!';
	String get time => 'Time';
	String get step => 'Step';
	String get next => 'Next';
	String get back => 'Levels';
}

// Path: info
class _StringsInfoEn {
	_StringsInfoEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get back => 'Close';
	String get text => 'The goal is to roll all the colored balls on the playing field into holes of the same color. The balls move only in a straight line to the first obstacle.';
}

// Path: setting
class _StringsSettingEn {
	_StringsSettingEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	String get theme => 'Theme';
	String get reset => 'Reset progress';
	late final _StringsSettingLanguageEn language = _StringsSettingLanguageEn._(_root);
	String get back => 'Back';
}

// Path: session.tutorial
class _StringsSessionTutorialEn {
	_StringsSessionTutorialEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Tutorial';
	List<String> get steps => [
		'Step 1: Press on the ball.',
		'Step 2: Press on the arrow.',
		'Step 3: Repeat steps 1 and 2.',
	];
}

// Path: setting.language
class _StringsSettingLanguageEn {
	_StringsSettingLanguageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Language';
	late final _StringsSettingLanguageLanguagesEn languages = _StringsSettingLanguageLanguagesEn._(_root);
}

// Path: setting.language.languages
class _StringsSettingLanguageLanguagesEn {
	_StringsSettingLanguageLanguagesEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get ru => 'Russian';
	String get en => 'English';
}

// Path: <root>
class _StringsRu implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsRu.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsRu _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsMainRu main = _StringsMainRu._(_root);
	@override late final _StringsLevelsRu levels = _StringsLevelsRu._(_root);
	@override late final _StringsSessionRu session = _StringsSessionRu._(_root);
	@override late final _StringsWinRu win = _StringsWinRu._(_root);
	@override late final _StringsInfoRu info = _StringsInfoRu._(_root);
	@override late final _StringsSettingRu setting = _StringsSettingRu._(_root);
}

// Path: main
class _StringsMainRu implements _StringsMainEn {
	_StringsMainRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get play => 'Уровни';
	@override String get setting => 'Настройки';
}

// Path: levels
class _StringsLevelsRu implements _StringsLevelsEn {
	_StringsLevelsRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Выбор уровня';
	@override String get tutorial => 'Обучение';
	@override String get back => 'Назад';
}

// Path: session
class _StringsSessionRu implements _StringsSessionEn {
	_StringsSessionRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Уровень';
	@override String get back => 'Назад';
	@override late final _StringsSessionTutorialRu tutorial = _StringsSessionTutorialRu._(_root);
}

// Path: win
class _StringsWinRu implements _StringsWinEn {
	_StringsWinRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Победа!';
	@override String get time => 'Время';
	@override String get step => 'Ход';
	@override String get next => 'Следующий';
	@override String get back => 'Уровни';
}

// Path: info
class _StringsInfoRu implements _StringsInfoEn {
	_StringsInfoRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get back => 'Закрыть';
	@override String get text => 'Цель закатить все цветные шарики на игровом поле в лунки того же цвета. Шарики двигаются только по прямой до первого препятствия.';
}

// Path: setting
class _StringsSettingRu implements _StringsSettingEn {
	_StringsSettingRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки';
	@override String get theme => 'Тема';
	@override String get reset => 'Сброс прогресса';
	@override late final _StringsSettingLanguageRu language = _StringsSettingLanguageRu._(_root);
	@override String get back => 'Назад';
}

// Path: session.tutorial
class _StringsSessionTutorialRu implements _StringsSessionTutorialEn {
	_StringsSessionTutorialRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Обучение';
	@override List<String> get steps => [
		'Шаг 1: Нажмите на шар.',
		'Шаг 2: Нажмите на стрелочку.',
		'Шаг 3: Повторить шаги 1 и 2.',
	];
}

// Path: setting.language
class _StringsSettingLanguageRu implements _StringsSettingLanguageEn {
	_StringsSettingLanguageRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Язык';
	@override late final _StringsSettingLanguageLanguagesRu languages = _StringsSettingLanguageLanguagesRu._(_root);
}

// Path: setting.language.languages
class _StringsSettingLanguageLanguagesRu implements _StringsSettingLanguageLanguagesEn {
	_StringsSettingLanguageLanguagesRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get ru => 'Русский';
	@override String get en => 'Английский';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
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

extension on _StringsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'main.play': return 'Уровни';
			case 'main.setting': return 'Настройки';
			case 'levels.title': return 'Выбор уровня';
			case 'levels.tutorial': return 'Обучение';
			case 'levels.back': return 'Назад';
			case 'session.title': return 'Уровень';
			case 'session.back': return 'Назад';
			case 'session.tutorial.title': return 'Обучение';
			case 'session.tutorial.steps.0': return 'Шаг 1: Нажмите на шар.';
			case 'session.tutorial.steps.1': return 'Шаг 2: Нажмите на стрелочку.';
			case 'session.tutorial.steps.2': return 'Шаг 3: Повторить шаги 1 и 2.';
			case 'win.title': return 'Победа!';
			case 'win.time': return 'Время';
			case 'win.step': return 'Ход';
			case 'win.next': return 'Следующий';
			case 'win.back': return 'Уровни';
			case 'info.back': return 'Закрыть';
			case 'info.text': return 'Цель закатить все цветные шарики на игровом поле в лунки того же цвета. Шарики двигаются только по прямой до первого препятствия.';
			case 'setting.title': return 'Настройки';
			case 'setting.theme': return 'Тема';
			case 'setting.reset': return 'Сброс прогресса';
			case 'setting.language.title': return 'Язык';
			case 'setting.language.languages.ru': return 'Русский';
			case 'setting.language.languages.en': return 'Английский';
			case 'setting.back': return 'Назад';
			default: return null;
		}
	}
}
