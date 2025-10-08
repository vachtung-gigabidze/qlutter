///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsMainRu main = _TranslationsMainRu._(_root);
	@override late final _TranslationsLevelsRu levels = _TranslationsLevelsRu._(_root);
	@override late final _TranslationsSessionRu session = _TranslationsSessionRu._(_root);
	@override late final _TranslationsWinRu win = _TranslationsWinRu._(_root);
	@override late final _TranslationsInfoRu info = _TranslationsInfoRu._(_root);
	@override late final _TranslationsSettingRu setting = _TranslationsSettingRu._(_root);
}

// Path: main
class _TranslationsMainRu implements TranslationsMainEn {
	_TranslationsMainRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get play => 'Уровни';
	@override String get setting => 'Настройки';
}

// Path: levels
class _TranslationsLevelsRu implements TranslationsLevelsEn {
	_TranslationsLevelsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Выбор уровня';
	@override String get tutorial => 'Обучение';
	@override String get back => 'Назад';
}

// Path: session
class _TranslationsSessionRu implements TranslationsSessionEn {
	_TranslationsSessionRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Уровень';
	@override String get back => 'Назад';
	@override late final _TranslationsSessionTutorialRu tutorial = _TranslationsSessionTutorialRu._(_root);
}

// Path: win
class _TranslationsWinRu implements TranslationsWinEn {
	_TranslationsWinRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Победа!';
	@override String get time => 'Время';
	@override String get step => 'Ход';
	@override String get next => 'Следующий';
	@override String get back => 'Уровни';
}

// Path: info
class _TranslationsInfoRu implements TranslationsInfoEn {
	_TranslationsInfoRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get back => 'Закрыть';
	@override String get text => 'Цель закатить все цветные шарики на игровом поле в лунки того же цвета. Шарики двигаются только по прямой до первого препятствия.';
}

// Path: setting
class _TranslationsSettingRu implements TranslationsSettingEn {
	_TranslationsSettingRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки';
	@override String get theme => 'Тема';
	@override String get reset => 'Сброс прогресса';
	@override late final _TranslationsSettingLanguageRu language = _TranslationsSettingLanguageRu._(_root);
	@override String get back => 'Назад';
}

// Path: session.tutorial
class _TranslationsSessionTutorialRu implements TranslationsSessionTutorialEn {
	_TranslationsSessionTutorialRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Обучение';
	@override List<String> get steps => [
		'Шаг 1: Нажмите на шар.',
		'Шаг 2: Нажмите на стрелочку.',
		'Шаг 3: Повторить шаги 1 и 2.',
	];
}

// Path: setting.language
class _TranslationsSettingLanguageRu implements TranslationsSettingLanguageEn {
	_TranslationsSettingLanguageRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Язык';
	@override late final _TranslationsSettingLanguageLanguagesRu languages = _TranslationsSettingLanguageLanguagesRu._(_root);
}

// Path: setting.language.languages
class _TranslationsSettingLanguageLanguagesRu implements TranslationsSettingLanguageLanguagesEn {
	_TranslationsSettingLanguageLanguagesRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get ru => 'Русский';
	@override String get en => 'Английский';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
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

