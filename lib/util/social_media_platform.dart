enum SocialMediaPlatform {
  facebook,
  twitter,
  twitch,
  instagram,
  snapchat,
  youtube,
  tiktok,
  googleMaps,
  pintrest,
}

extension sm2e on String {
  SocialMediaPlatform toFruit() {
    return SocialMediaPlatform.values.firstWhere(
      (e) =>
          e.toString().toLowerCase() ==
          'socialmediaplatform.$this'.toLowerCase(),
      orElse: () => null,
    ); //return null if not found
  }
}
