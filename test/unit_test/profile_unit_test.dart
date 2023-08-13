import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/core/failure/failure.dart';
import 'package:swapreads/features/user_profile/domain/entity/profile_entity.dart';
import 'package:swapreads/features/user_profile/domain/use_case/profile_use_case.dart';
import 'package:swapreads/features/user_profile/presentation/viewmodel/profile_view_model.dart';

import '../../test_data/profile_entity_test.dart';
import 'home_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late ProfileUseCase mockProfileUseCase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUseCase = MockProfileUseCase();
    profileEntity = await getProfileTest();
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        profileViewModelProvider.overrideWith(
          (ref) => ProfileViewModel(mockProfileUseCase),
        )
      ],
    );
  });

  test('check profile initial state', () async {
    await container.read(profileViewModelProvider.notifier).getUserInfo();

    final profileState = container.read(profileViewModelProvider);
    expect(profileState.isLoading, false);
    expect(profileState.usersData, isEmpty);
  });

  test('should get profile', () async {
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) => Future.value(Right(profileEntity)));

    await container.read(profileViewModelProvider.notifier).getUserInfo();

    final profileState = container.read(profileViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.usersData.length, 1);
  });

  tearDownAll(() {
    container.dispose();
  });

  test('should not get profile', () async {
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container.read(profileViewModelProvider.notifier).getUserInfo();

    final profileState = container.read(profileViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.error, 'Invalid');
    //to fail the test keep isNull instead of isNotNull
  });

  tearDownAll(() {
    container.dispose();
  });
}
