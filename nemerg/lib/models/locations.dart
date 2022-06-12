class Hastane {
  int ID;
  String U_NAME;
  String position;
  String waitingtime;
  String p_num;

  Hastane({
    required this.ID,
    required this.U_NAME,
    required this.position,
    required this.waitingtime,
    required this.p_num,
  });

  Hastane.fromJson(Map<dynamic, dynamic> json)
      : ID = json['ID'] == null ? 0 : int.parse(json['ID']),
        U_NAME = json['U_NAME'],
        waitingtime = json['waitingtime'] ?? '',
        p_num = json['p_num'] ?? '',
        position = json['position'];
}
