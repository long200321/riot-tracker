class Champion {
  final String id;
  final String key;
  final String name;
  final String title;
  final List<Skin>? skins;
  final String? lore;
  final List<String>? allyTips;
  final List<String>? enemyTips;
  final List<String>? tags;
  final Passive? passive;
  final List<Spell>? spells;

  const Champion({
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    this.skins,
    this.lore,
    this.allyTips,
    this.enemyTips,
    this.tags,
    this.passive,
    this.spells,
  });

  Champion copyWith({
    List<Skin>? skins,
    String? lore,
    List<String>? allyTips,
    List<String>? enemyTips,
    List<String>? tags,
    Passive? passive,
    List<Spell>? spells,
  }) {
    return Champion(
      id: id,
      key: key,
      name: name,
      title: title,
      skins: skins ?? this.skins,
      lore: lore ?? this.lore,
      allyTips: allyTips ?? this.allyTips,
      enemyTips: enemyTips ?? this.enemyTips,
      tags: tags ?? this.tags,
      passive: passive ?? this.passive,
      spells: spells ?? this.spells,
    );
  }
}

class Skin {
  final String id;
  final int num;
  final String name;

  const Skin({
    required this.id,
    required this.num,
    required this.name,
  });
}

class Spell {
  final String id;
  final String name;
  final String description;

  const Spell({
    required this.id,
    required this.name,
    required this.description,
  });
}

class Passive {
  final String name;
  final String description;
  final String image;

  const Passive({
    required this.name,
    required this.description,
    required this.image,
  });
}

class ListChampion {
  final List<Champion> listChampions;

  const ListChampion({
    required this.listChampions,
  });
}