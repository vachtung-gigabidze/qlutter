![plot](./images/logo.png)

## Логическая игра, цель которой закатить все цветные шарики на игровом поле в лунки того же цвета. Шарики двигаются только по прямой и только до первого препятствия, которым может быть либо неподвижный блок, либо другой шарик.

![plot](./images/Main.png)

![plot](./images/Screen1.png)

![plot](./images/Screen2.png)

# Курсовой проект

# Цель:
## Результатом проекта является мобильное приложение с минимально необходимой функциональностью с тестами.
## Создание курсового проекта поможет вам в развитии навыка самостоятельной разработки проекта как со стороны визуального представления, так и реализации бизнес-логики, управления состоянием, автоматических тестов и подготовки к публикации

# Описание/Пошаговая инструкция выполнения домашнего задания:
## Выбрать тему для курсового проекта
## Указать тему через кнопку "Предложить тему"
## Продумать и описать функциональность приложения (должно быть не менее 3 экранов, подключение к сетевому API, можно использовать публичный, локальное хранение, анимации переходов). Также в приложении должно быть предусмотрено взаимодействие с платформенным кодом (например, для определения режима энергосбережения)
## Разработать необходимые виджеты (с использованием тестовых данных)
## Реализовать бизнес-логику (контроллеры, объекты хранения состояния или иные, связанные с выбранным подходом к управлению состоянием)
## Создать тесты для бизнес-логики и виджетов
## Выполнить сборку aab-артефакта и отправить его в проект (в личном кабинете, в чате этого домашнего задания), а также отправить ссылку на github

# Критерии оценки:
## сервис для работы с внешним АПИ - минимум три функциональных экрана - 2 балла
## UI c использованием FutureBuilder, StreamBuilder, Scrollable, Sliver - 1 балл
## UI с использованием анимаций - 1 балл
## должен быть использован Isolate для выполнения длительных операций - 1 балл
## функциональность работы с native platform - 1 балл
## проект должен быть реализован на базе одного из рассмотренных state движков - redux, bloc, mobx - 1 балл
## код бизнес сервис должен быть покрыт юнит тестами (минимально 10 юнит тестов с подробным покрытием логики каких-либо методов и использованием моков, тестов emitting событий, тестов на часть state management) - 1 балла
## код виджетов должен быть покрыт widget тестами (минимально 5 виджетов для демонстрации понимания процесса) - 1 балл
## оформление кода выполнено в соответствии с требованиями Dart - 1 балл


flutter packages pub run build_runner build --delete-conflicting-outputs