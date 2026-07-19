import 'package:dio/dio.dart';

import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/use_case/use_case.dart';
import '../../data/models/get_version_response.dart';
import '../repositories/version_repositories.dart';

@lazySingleton
class GetVersionUseCase
    implements UseCase<GetVersionResponse, GetVersionParams> {
  final VersionRepositories _authRepositories;

  GetVersionUseCase({required VersionRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<GetVersionResponse> call(GetVersionParams params) async =>
      await _authRepositories.getVersion(params.getBody());
}

class GetVersionParams with Params {
  final String platform;
  final String currentVersion;

  GetVersionParams({required this.platform, required this.currentVersion});

  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {"platform": platform, "version": currentVersion}
      ..removeWhere((key, value) => value == null);
  }


  // @override
  // QueryParams getParams() {
  //   // TODO: implement getParams
  //   return {"platform": platform, "current_version": currentVersion}
  //     ..removeWhere((key, value) => value == null);
  // }
}
