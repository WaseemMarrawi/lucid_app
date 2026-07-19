import '../../../../common/helper/src/typedef.dart';
import '../../data/models/get_version_response.dart';


abstract class VersionRepositories{

  DataResponse<GetVersionResponse> getVersion(BodyMap params);

}