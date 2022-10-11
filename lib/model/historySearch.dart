class HistorySearch {
  HistorySearch({required this.idUser, required this.search});

  HistorySearch.fromJson(Map<String, Object?> json)
    : this(
        idUser: json['idUser']! as String,
        search: json['search']! as List<dynamic>,
      );

  final String idUser;
  final List<dynamic> search;

  Map<String, Object?> toJson() {
    return {
      'idUser': idUser,
      'search': search,
    };
  }
}