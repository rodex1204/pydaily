class User {
  final int xp;
  final List<String> completedChallenges;
  final int level;
  final int streak;
  final DateTime lastPlayedDate;

  User({
    this.xp = 0,
    this.completedChallenges = const [],
    this.level = 1,
    this.streak = 0,
    DateTime? lastPlayedDate,
  }) : lastPlayedDate = lastPlayedDate ?? DateTime.now();

  double get progress => (xp % 100) / 100;
  
  //Calcular el nivel
  int get calculatedLevel => (xp ~/ 100) + 1;

  //Bonus por racha
  int get streakBonus => streak * 5;

  User copyWith({
    int? xp,
    List<String>? completedChallenges,
    int? level,
    int? streak,
    DateTime? lastPlayedDate,
  }) {
    final newXp = xp ?? this.xp;
    return User(
      xp: newXp,
      completedChallenges: completedChallenges ?? this.completedChallenges,
      level: level ?? calculatedLevel,
      streak: streak ?? this.streak,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    );
  }

  // Verifica si el usuario jugó hoy
  bool get playedToday {
    final now = DateTime.now();
    return lastPlayedDate.year == now.year &&
        lastPlayedDate.month == now.month &&
        lastPlayedDate.day == now.day;
  }

  // Verifica si el usuario jugó ayer
  bool get playedYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return lastPlayedDate.year == yesterday.year &&
        lastPlayedDate.month == yesterday.month &&
        lastPlayedDate.day == yesterday.day;
  }
}