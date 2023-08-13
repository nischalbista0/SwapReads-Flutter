// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../core/failure/failure.dart';
// import '../../../home/data/data_source/home_local_data_source.dart';
// import '../../domain/entity/profile_entity.dart';

// final homeLocalRepoProvider = Provider<IProfileRepository>((ref) {
//   return ProfileLocalRepositoryImpl(
//     homeLocalDataSource: ref.read(homeLocalDataSourceProvider),
//   );
// });

// class ProfileLocalRepositoryImpl implements IProfileRepository {
//   final ProfileLocalDataSource homeLocalDataSource;

//   ProfileLocalRepositoryImpl({required this.homeLocalDataSource});
//   @override
//   Future<Either<Failure, List<ProfileEntity>>> getUserInfo() {
//     return homeLocalDataSource.getUserInfo();
//   }
// }
