// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$usersListAtom =
      Atom(name: 'HomeControllerBase.usersList', context: context);

  @override
  List<UserModel> get usersList {
    _$usersListAtom.reportRead();
    return super.usersList;
  }

  @override
  set usersList(List<UserModel> value) {
    _$usersListAtom.reportWrite(value, super.usersList, () {
      super.usersList = value;
    });
  }

  late final _$tasksListAtom =
      Atom(name: 'HomeControllerBase.tasksList', context: context);

  @override
  List<TaskModel> get tasksList {
    _$tasksListAtom.reportRead();
    return super.tasksList;
  }

  @override
  set tasksList(List<TaskModel> value) {
    _$tasksListAtom.reportWrite(value, super.tasksList, () {
      super.tasksList = value;
    });
  }

  late final _$olderUserAtom =
      Atom(name: 'HomeControllerBase.olderUser', context: context);

  @override
  String get olderUser {
    _$olderUserAtom.reportRead();
    return super.olderUser;
  }

  @override
  set olderUser(String value) {
    _$olderUserAtom.reportWrite(value, super.olderUser, () {
      super.olderUser = value;
    });
  }

  late final _$avgUserAtom =
      Atom(name: 'HomeControllerBase.avgUser', context: context);

  @override
  String get avgUser {
    _$avgUserAtom.reportRead();
    return super.avgUser;
  }

  @override
  set avgUser(String value) {
    _$avgUserAtom.reportWrite(value, super.avgUser, () {
      super.avgUser = value;
    });
  }

  late final _$newestUserAtom =
      Atom(name: 'HomeControllerBase.newestUser', context: context);

  @override
  Observable<String> get newestUser {
    _$newestUserAtom.reportRead();
    return super.newestUser;
  }

  @override
  set newestUser(Observable<String> value) {
    _$newestUserAtom.reportWrite(value, super.newestUser, () {
      super.newestUser = value;
    });
  }

  late final _$getUsersAsyncAction =
      AsyncAction('HomeControllerBase.getUsers', context: context);

  @override
  Future getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  late final _$insertUsersAsyncAction =
      AsyncAction('HomeControllerBase.insertUsers', context: context);

  @override
  Future insertUsers(UserModel user) {
    return _$insertUsersAsyncAction.run(() => super.insertUsers(user));
  }

  late final _$updateUsersAsyncAction =
      AsyncAction('HomeControllerBase.updateUsers', context: context);

  @override
  Future updateUsers(UserModel user) {
    return _$updateUsersAsyncAction.run(() => super.updateUsers(user));
  }

  late final _$deleteUsersAsyncAction =
      AsyncAction('HomeControllerBase.deleteUsers', context: context);

  @override
  Future deleteUsers(UserModel user) {
    return _$deleteUsersAsyncAction.run(() => super.deleteUsers(user));
  }

  late final _$getTasksAsyncAction =
      AsyncAction('HomeControllerBase.getTasks', context: context);

  @override
  Future getTasks() {
    return _$getTasksAsyncAction.run(() => super.getTasks());
  }

  late final _$insertTasksAsyncAction =
      AsyncAction('HomeControllerBase.insertTasks', context: context);

  @override
  Future insertTasks(TaskModel task) {
    return _$insertTasksAsyncAction.run(() => super.insertTasks(task));
  }

  late final _$updateTasksAsyncAction =
      AsyncAction('HomeControllerBase.updateTasks', context: context);

  @override
  Future updateTasks(TaskModel task) {
    return _$updateTasksAsyncAction.run(() => super.updateTasks(task));
  }

  late final _$deleteTasksAsyncAction =
      AsyncAction('HomeControllerBase.deleteTasks', context: context);

  @override
  Future deleteTasks(TaskModel task) {
    return _$deleteTasksAsyncAction.run(() => super.deleteTasks(task));
  }

  late final _$getOlderUserAsyncAction =
      AsyncAction('HomeControllerBase.getOlderUser', context: context);

  @override
  Future getOlderUser() {
    return _$getOlderUserAsyncAction.run(() => super.getOlderUser());
  }

  late final _$getAvgUserAsyncAction =
      AsyncAction('HomeControllerBase.getAvgUser', context: context);

  @override
  Future getAvgUser() {
    return _$getAvgUserAsyncAction.run(() => super.getAvgUser());
  }

  late final _$getNewestUserAsyncAction =
      AsyncAction('HomeControllerBase.getNewestUser', context: context);

  @override
  Future getNewestUser() {
    return _$getNewestUserAsyncAction.run(() => super.getNewestUser());
  }

  @override
  String toString() {
    return '''
usersList: ${usersList},
tasksList: ${tasksList},
olderUser: ${olderUser},
avgUser: ${avgUser},
newestUser: ${newestUser}
    ''';
  }
}
