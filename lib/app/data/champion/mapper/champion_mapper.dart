import '../../../domain/champion/entities/champion.dart';
import '../response/list_champion_response.dart';

extension ChampionMapper on ChampionResponse {
  Champion toEntity() {
    return Champion(
      id: id,
      key: key,
      name: name,
      title: title,
      lore: lore,
      allyTips: allyTips,
      enemyTips: enemyTips,
      tags: tags,
      spells: spells
          ?.map((e) => Spell(
        id: e.id,
        name: e.name,
        description: e.description,
      ))
          .toList(),

      skins: skins
          ?.map((e) => Skin(
        id: e.id,
        num: e.num,
        name: e.name,
      ))
          .toList(),

      passive: passive != null
          ? Passive(
        name: passive!.name,
        description: passive!.description,
        image: passive!.image,
      )
          : null,
    );
  }
}

extension ListChampionMapper on ListChampionResponse {
  ListChampion toEntity() {
    return ListChampion(
      listChampions: listChampions.map((e) => e.toEntity()).toList(),
    );
  }
}