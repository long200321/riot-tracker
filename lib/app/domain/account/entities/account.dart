class Account {
  final String? puuid;
  final String? gameName;
  final String? tagLine;
  final int? profileIconId;
  final int? summonerLevel;
  final List<Rank>? ranks;

  Account({
    this.puuid,
    this.gameName,
    this.tagLine,
    this.profileIconId,
    this.summonerLevel,
    this.ranks
  });

  Account copyWith({
    String? puuid,
    String? gameName,
    String? tagLine,
    int? profileIconId,
    int? summonerLevel,
    List<Rank>? ranks,
  }) {
    return Account(
      puuid: puuid ?? this.puuid,
      gameName: gameName ?? this.gameName,
      tagLine: tagLine ?? this.tagLine,
      profileIconId: profileIconId ?? this.profileIconId,
      summonerLevel: summonerLevel ?? this.summonerLevel,
      ranks: ranks ?? this.ranks,
    );
  }
}

class Rank {
  final QueueType? queueType;
  final String? tier;
  final String? rank;
  final int? leaguePoints;
  final int? wins;
  final int? losses;

  Rank({
    this.queueType = QueueType.unknown,
    this.tier,
    this.rank,
    this.leaguePoints,
    this.wins,
    this.losses,
  });

  String? get queueDisplayName => queueType?.displayName;

}

enum QueueType {
  rankedSolo,
  rankedFlex,
  unknown,
}

QueueType parseQueueType(String? value) {
  switch (value) {
    case "RANKED_SOLO_5x5":
      return QueueType.rankedSolo;
    case "RANKED_FLEX_SR":
      return QueueType.rankedFlex;
    default:
      return QueueType.unknown;
  }
}

extension QueueTypeExtension on QueueType {
  String get displayName {
    switch (this) {
      case QueueType.rankedSolo:
        return "SOLO/DUO";
      case QueueType.rankedFlex:
        return "FLEX 5V5";
      case QueueType.unknown:
      default:
        return "Không xác định";
    }
  }
}


