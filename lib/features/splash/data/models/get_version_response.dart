
GetVersionResponse getVersionResponseFromJson( str) => GetVersionResponse.fromJson(str);


class GetVersionResponse {
  final String? platform;
  final String? currentVersion;
  final String? latestVersion;
  final String? minimumVersion;
  final bool? updateRequired;
  final bool? updateAvailable;
  final String? storeUrl;
  final String? releaseNotes;

  GetVersionResponse({
    this.platform,
    this.currentVersion,
    this.latestVersion,
    this.minimumVersion,
    this.updateRequired,
    this.updateAvailable,
    this.storeUrl,
    this.releaseNotes,
  });

  GetVersionResponse copyWith({
    String? platform,
    String? currentVersion,
    String? latestVersion,
    String? minimumVersion,
    bool? updateRequired,
    bool? updateAvailable,
    String? storeUrl,
    String? releaseNotes,
  }) =>
      GetVersionResponse(
        platform: platform ?? this.platform,
        currentVersion: currentVersion ?? this.currentVersion,
        latestVersion: latestVersion ?? this.latestVersion,
        minimumVersion: minimumVersion ?? this.minimumVersion,
        updateRequired: updateRequired ?? this.updateRequired,
        updateAvailable: updateAvailable ?? this.updateAvailable,
        storeUrl: storeUrl ?? this.storeUrl,
        releaseNotes: releaseNotes ?? this.releaseNotes,
      );

  factory GetVersionResponse.fromJson(Map<String, dynamic> json) => GetVersionResponse(
    platform: json["platform"],
    currentVersion: json["currentVersion"],
    latestVersion: json["latestVersion"],
    minimumVersion: json["minimumVersion"],
    updateRequired: json["updateRequired"],
    updateAvailable: json["updateAvailable"],
    storeUrl: json["storeUrl"],
    releaseNotes: json["releaseNotes"],
  );

  Map<String, dynamic> toJson() => {
    "platform": platform,
    "currentVersion": currentVersion,
    "latestVersion": latestVersion,
    "minimumVersion": minimumVersion,
    "updateRequired": updateRequired,
    "updateAvailable": updateAvailable,
    "storeUrl": storeUrl,
    "releaseNotes": releaseNotes,
  };
}
