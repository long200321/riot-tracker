class ChampionResponse {
  final String id;
  final String key;
  final String name;
  final String title;

  final String? lore;
  final List<String>? allyTips;
  final List<String>? enemyTips;
  final List<String>? tags;

  final List<SkinResponse>? skins;
  final List<SpellResponse>? spells;
  final PassiveResponse? passive;

  ChampionResponse({
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    this.lore,
    this.allyTips,
    this.enemyTips,
    this.tags,
    this.skins,
    this.spells,
    this.passive,
  });

  factory ChampionResponse.fromJson(Map<String, dynamic> json) {
    return ChampionResponse(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      title: json['title'],

      lore: json['lore'],
      allyTips: List<String>.from(json['allytips'] ?? []),
      enemyTips: List<String>.from(json['enemytips'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),

      skins: (json['skins'] as List?)
          ?.where((e) => e['parentSkin'] == null)
          .map((e) => SkinResponse.fromJson(e))
          .toList(),

      spells: (json['spells'] as List?)
          ?.map((e) => SpellResponse.fromJson(e))
          .toList(),

      passive: json['passive'] != null
          ? PassiveResponse.fromJson(json['passive'])
          : null,
    );
  }
}

class ListChampionResponse {
  final List<ChampionResponse> listChampions;

  ListChampionResponse({required this.listChampions});

  factory ListChampionResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final champions = data.values
        .map((e) => ChampionResponse.fromJson(e))
        .toList();

    return ListChampionResponse(listChampions: champions);
  }
}

class SkinResponse {
  final String id;
  final int num;
  final String name;

  SkinResponse({
    required this.id,
    required this.num,
    required this.name,
  });

  factory SkinResponse.fromJson(Map<String, dynamic> json) {
    return SkinResponse(
      id: json['id'],
      num: json['num'],
      name: json['name'],
    );
  }
}

class SpellResponse {
  final String id;
  final String name;
  final String description;
  final String? cooldown;
  final String? cost;
  final String? range;

  SpellResponse({
    required this.id,
    required this.name,
    required this.description,
    this.cooldown,
    this.cost,
    this.range,
  });

  factory SpellResponse.fromJson(Map<String, dynamic> json) {
    return SpellResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      cooldown: json['cooldownBurn'],
      cost: json['costBurn'],
      range: json['rangeBurn'],
    );
  }
}

class PassiveResponse {
  final String name;
  final String description;
  final String image;

  PassiveResponse({
    required this.name,
    required this.description,
    required this.image,
  });

  factory PassiveResponse.fromJson(Map<String, dynamic> json) {
    return PassiveResponse(
      name: json['name'],
      description: json['description'],
      image: json['image']?['full'] ?? "",
    );
  }
}