import '../../domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final List<ProfileEntity> usersData;
  final String? error;
  final String? imageName;

  ProfileState({
    required this.isLoading,
    required this.usersData,
    this.error,
    this.imageName,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      usersData: [],
      error: null,
      imageName: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    List<ProfileEntity>? usersData,
    String? error,
    String? imageName,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      usersData: usersData ?? this.usersData,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
