import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../views/sort_bottom_sheet.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final String searchQuery;
  final SortOption sortOption;

  const UserLoaded(
    this.users, {
    this.searchQuery = '',
    this.sortOption = SortOption.all,
  });

  UserLoaded copyWith({
    List<UserModel>? users,
    String? searchQuery,
    SortOption? sortOption,
  }) {
    return UserLoaded(
      users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  List<UserModel> get filteredAndSortedUsers {
    List<UserModel> filtered = List.from(users);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((user) {
        return user.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply sorting
    switch (sortOption) {
      case SortOption.ageElder:
        filtered.sort((a, b) => b.age.compareTo(a.age));
        break;
      case SortOption.ageYounger:
        filtered.sort((a, b) => a.age.compareTo(b.age));
        break;
      case SortOption.all:
        break;
    }

    return filtered;
  }

  @override
  List<Object?> get props => [users, searchQuery, sortOption];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
