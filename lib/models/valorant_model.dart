class ValorantCharacter {
  final String displayName;
  final String uuid;
  final String displayIconSmall;
  final String fullPortrait;
  final String description;
  final ValorantRole role;
  final bool isPlayableCharacter;
  final List<ValorantAbility> abilities;

  ValorantCharacter({
    required this.displayName,
    required this.uuid,
    required this.displayIconSmall,
    required this.fullPortrait,
    required this.description,
    required this.role,
    required this.abilities,
    required this.isPlayableCharacter,
  });

  factory ValorantCharacter.fromJson(Map<String, dynamic> json) {
    List<ValorantAbility> abilities = [];
    if (json['abilities'] != null) {
      for (var abilityJson in json['abilities']) {
        ValorantAbility ability = ValorantAbility.fromJson(abilityJson);
        abilities.add(ability);
      }
    }
    return ValorantCharacter(
      displayName: json['displayName'] ?? 'Unknown',
      uuid: json['uuid'] ?? 'No id',
      displayIconSmall: json['displayIconSmall'] ?? 'No displayIconSmall',
      description: json['description'] ?? 'No description',
      fullPortrait: json['fullPortrait'] ?? 'No fullPortrait',
      role: ValorantRole.fromJson(json['role'] ?? {}),
      abilities: abilities,
      isPlayableCharacter: json['isPlayableCharacter'],
    );
  }
}

class ValorantRole {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;
  final String assetPath;

  ValorantRole({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.assetPath,
  });

  factory ValorantRole.fromJson(Map<String, dynamic> json) {
    return ValorantRole(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      assetPath: json['assetPath'] ?? '',
    );
  }
}

class ValorantAbility {
  final String slot;
  final String displayName;
  final String description;
  final String displayIcon;

  ValorantAbility({
    required this.slot,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });
  factory ValorantAbility.fromJson(Map<String, dynamic> json) {
    return ValorantAbility(
      slot: json['slot'] ?? '',
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}

class ValorantMap {
  final String uuid;
  final String displayName;
  final String tacticalDescription;
  final String displayIcon;
  final String listViewIcon;
  final String listViewIconTall;
  final String mapUrl;

  ValorantMap({
    required this.uuid,
    required this.displayName,
    required this.tacticalDescription,
    required this.displayIcon,
    required this.listViewIcon,
    required this.listViewIconTall,
    required this.mapUrl,
  });

  factory ValorantMap.fromJson(Map<String, dynamic> json) {
    return ValorantMap(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      tacticalDescription: json['tacticalDescription '] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      listViewIcon: json['listViewIcon'] ?? '',
      listViewIconTall: json['listViewIconTall'] ?? '',
      mapUrl: json['mapUrl'] ?? '',
    );
  }
}

class ValorantWeapon {
  final String displayName;
  final String category;
  final String displayIcon;
  final List<ValorantWeaponSkin> skins;
  late final String cleanedCategory;
  final WeaponStats weaponStats;

  ValorantWeapon({
    required this.displayName,
    required this.category,
    required this.displayIcon,
    required this.skins,
    required this.weaponStats,
  }) {
    cleanedCategory = category.replaceFirst("EEquippableCategory::", "");
  }
  factory ValorantWeapon.fromJson(Map<String, dynamic> json) {
    return ValorantWeapon(
      displayName: json['displayName'] ?? '',
      category: json['category'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      skins: (json['skins'] as List<dynamic>?)
              ?.map((skinJson) => ValorantWeaponSkin.fromJson(skinJson))
              .toList() ??
          [],
      weaponStats: WeaponStats.fromJson(json['weaponStats']),
    );
  }
}

class ValorantWeaponSkin {
  final String uuid;
  final String displayName;
  final String themeUuid;
  final String contentTierUuid;
  final String displayIcon;

  ValorantWeaponSkin({
    required this.uuid,
    required this.displayName,
    required this.themeUuid,
    required this.contentTierUuid,
    required this.displayIcon,
  });

  factory ValorantWeaponSkin.fromJson(Map<String, dynamic> json) {
    return ValorantWeaponSkin(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      themeUuid: json['themeUuid'] ?? '',
      contentTierUuid: json['contentTierUuid'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}

class WeaponStats {
  final String? fireRate;
  final String? magazineSize;
  final String? runSpeedMultiplier;
  final String? equipTimeSeconds;
  final String? reloadTimeSeconds;
  final String? firstBulletAccuracy;
  final String? shotgunPelletCount;
  final String? wallPenetration;
  final String? feature;
  final String? fireMode;
  final String? altFireType;
  final AdsStats? adsStats;
  final AltShotgunStats? altShotgunStats;
  final AirBurstStats? airBurstStats;
  final List<DamageRange> damageRanges;

  WeaponStats({
    required this.fireRate,
    required this.magazineSize,
    required this.runSpeedMultiplier,
    required this.equipTimeSeconds,
    required this.reloadTimeSeconds,
    required this.firstBulletAccuracy,
    required this.shotgunPelletCount,
    required this.wallPenetration,
    required this.feature,
    required this.fireMode,
    required this.altFireType,
    required this.adsStats,
    required this.altShotgunStats,
    required this.airBurstStats,
    required this.damageRanges,
  });

  factory WeaponStats.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return WeaponStats(
        fireRate: null,
        magazineSize: null,
        runSpeedMultiplier: null,
        equipTimeSeconds: null,
        reloadTimeSeconds: null,
        firstBulletAccuracy: null,
        shotgunPelletCount: null,
        wallPenetration: '',
        feature: '',
        fireMode: '',
        altFireType: '',
        adsStats: null,
        altShotgunStats: null,
        airBurstStats: null,
        damageRanges: [],
      );
    }
    return WeaponStats(
      fireRate: (json['fireRate'] as num?)?.toString(),
      magazineSize: json['magazineSize']?.toString(),
      runSpeedMultiplier: (json['runSpeedMultiplier'] as num?)?.toString(),
      equipTimeSeconds: (json['equipTimeSeconds'] as num?)?.toString(),
      reloadTimeSeconds: (json['reloadTimeSeconds'] as num?)?.toString(),
      firstBulletAccuracy: (json['firstBulletAccuracy'] as num?)?.toString(),
      shotgunPelletCount: json['shotgunPelletCount']?.toString(),
      wallPenetration: json['wallPenetration'] ?? '',
      feature: json['feature'] ?? '',
      fireMode: json['fireMode'] ?? '',
      altFireType: json['altFireType'] ?? '',
      adsStats:
          json['adsStats'] != null ? AdsStats.fromJson(json['adsStats']) : null,
      altShotgunStats: json['altShotgunStats'] != null
          ? AltShotgunStats.fromJson(json['altShotgunStats'])
          : null,
      airBurstStats: json['airBurstStats'] != null
          ? AirBurstStats.fromJson(json['airBurstStats'])
          : null,
      damageRanges: (json['damageRanges'] as List<dynamic>?)
              ?.map((rangeJson) => DamageRange.fromJson(rangeJson))
              .toList() ??
          [],
    );
  }
}

class DamageRange {
  final String rangeStartMeters;
  final String rangeEndMeters;
  final String headDamage;
  final String bodyDamage;
  final String legDamage;

  DamageRange({
    required this.rangeStartMeters,
    required this.rangeEndMeters,
    required this.headDamage,
    required this.bodyDamage,
    required this.legDamage,
  });

  factory DamageRange.fromJson(Map<String, dynamic> json) {
    return DamageRange(
      rangeStartMeters: (json['rangeStartMeters'] ?? 0.0).toString(),
      rangeEndMeters: (json['rangeEndMeters'] ?? 0.0).toString(),
      headDamage: (json['headDamage'] ?? 0.0).toString(),
      bodyDamage: (json['bodyDamage'] ?? 0.0).toString(),
      legDamage: (json['legDamage'] ?? 0.0).toString(),
    );
  }
}

class AdsStats {
  final String zoomMultiplier;
  final String fireRate;
  final String runSpeedMultiplier;
  final String burstCount;
  final String firstBulletAccuracy;

  AdsStats({
    required this.zoomMultiplier,
    required this.fireRate,
    required this.runSpeedMultiplier,
    required this.burstCount,
    required this.firstBulletAccuracy,
  });

  factory AdsStats.fromJson(Map<String, dynamic> json) {
    return AdsStats(
      zoomMultiplier: (json['zoomMultiplier'] ?? 0.0).toString(),
      fireRate: (json['fireRate'] ?? 0.0).toString(),
      runSpeedMultiplier: (json['runSpeedMultiplier'] ?? 0.0).toString(),
      burstCount: (json['burstCount'] ?? 0).toString(),
      firstBulletAccuracy: (json['firstBulletAccuracy'] ?? 0.0).toString(),
    );
  }
}

class AltShotgunStats {
  final String shotgunPelletCount;
  final String burstRate;

  AltShotgunStats({
    required this.shotgunPelletCount,
    required this.burstRate,
  });

  factory AltShotgunStats.fromJson(Map<String, dynamic> json) {
    return AltShotgunStats(
      shotgunPelletCount: (json['shotgunPelletCount'] ?? 0).toString(),
      burstRate: (json['burstRate'] ?? 0.0).toString(),
    );
  }
}

class AirBurstStats {
  final String shotgunPelletCount;
  final String burstDistance;

  AirBurstStats({
    required this.shotgunPelletCount,
    required this.burstDistance,
  });

  factory AirBurstStats.fromJson(Map<String, dynamic> json) {
    return AirBurstStats(
      shotgunPelletCount: (json['shotgunPelletCount'] ?? 0).toString(),
      burstDistance: (json['burstDistance'] ?? 0.0).toString(),
    );
  }
}

class CompetitiveTiers {
  final List<Tier> tiers;

  CompetitiveTiers({required this.tiers});

  factory CompetitiveTiers.fromJson(Map<String, dynamic> json) {
    var tiersList = json['tiers'] as List;
    List<Tier> tiers = tiersList.map((i) => Tier.fromJson(i)).toList();
    return CompetitiveTiers(tiers: tiers);
  }
}

class Tier {
  final String tierName;
  final String smallIcon;
  final String largeIcon;

  Tier(
      {required this.tierName,
      required this.smallIcon,
      required this.largeIcon});

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(
      tierName: json['tierName'] ?? '',
      smallIcon: json['smallIcon'] ?? '',
      largeIcon: json['largeIcon'] ?? '',
    );
  }
}
