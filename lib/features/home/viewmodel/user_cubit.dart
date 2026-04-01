import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../views/sort_bottom_sheet.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  static const String _boxName = 'users';
  Box<UserModel>? _userBox;

  UserCubit() : super(UserInitial());

  Future<void> initializeHive() async {
    try {
      emit(UserLoading());
      _userBox = await Hive.openBox<UserModel>(_boxName);
      loadUsers();
    } catch (e) {
      emit(UserError('Failed to initialize database: $e'));
    }
  }

  void loadUsers() {
    try {
      if (_userBox == null) {
        emit(const UserError('Database not initialized'));
        return;
      }
      final users = _userBox!.values.toList();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to load users: $e'));
    }
  }

  void updateSearchQuery(String query) {
    final currentState = state;
    if (currentState is UserLoaded) {
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void updateSortOption(SortOption option) {
    final currentState = state;
    if (currentState is UserLoaded) {
      emit(currentState.copyWith(sortOption: option));
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      if (_userBox == null) {
        emit(const UserError('Database not initialized'));
        return;
      }
      await _userBox!.add(user);
      loadUsers();
    } catch (e) {
      emit(UserError('Failed to add user: $e'));
    }
  }

  Future<void> updateUser(int index, UserModel user) async {
    try {
      if (_userBox == null) {
        emit(const UserError('Database not initialized'));
        return;
      }
      await _userBox!.putAt(index, user);
      loadUsers();
    } catch (e) {
      emit(UserError('Failed to update user: $e'));
    }
  }

  Future<void> deleteUser(int index) async {
    try {
      if (_userBox == null) {
        emit(const UserError('Database not initialized'));
        return;
      }
      await _userBox!.deleteAt(index);
      loadUsers();
    } catch (e) {
      emit(UserError('Failed to delete user: $e'));
    }
  }

  @override
  Future<void> close() {
    _userBox?.close();
    return super.close();
  }
}
