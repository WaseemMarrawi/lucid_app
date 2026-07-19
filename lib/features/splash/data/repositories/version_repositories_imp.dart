import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import '../../domain/repositories/version_repositories.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/version_remote_data.dart';
import '../models/get_version_response.dart';

@LazySingleton(as: VersionRepositories)
class VersionRepositoriesImp
    with HandlingException
    implements VersionRepositories {
  final VersionRemoteData _remoteData;

  VersionRepositoriesImp({required VersionRemoteData remoteData})
    : _remoteData = remoteData;

  @override
  DataResponse<GetVersionResponse> getVersion(BodyMap params) async =>
      await wrapHandlingException(
        tryCall: () => _remoteData.getVersion(params),
      );
}
