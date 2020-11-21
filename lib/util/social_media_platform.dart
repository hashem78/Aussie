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
  primeVideo,
  netflix,
  hulu,
  youtubeTV,
}

extension sm2e on String {
  SocialMediaPlatform toSocialMediaPlatform() {
    return SocialMediaPlatform.values.firstWhere(
      (e) =>
          e.toString().toLowerCase() ==
          'socialmediaplatform.$this'.toLowerCase(),
      orElse: () => null,
    ); //return null if not found
  }
}
