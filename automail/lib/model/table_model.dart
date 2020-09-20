class TransactionTableModel {
  int transID;
  String transDesc;
  String transStatus;
  DateTime dateTime;

  TransactionTableModel(
      {this.transID, this.transDesc, this.transStatus, this.dateTime});

  int get getID => transID;
  String get getDesc => transDesc;
  String get getStatus => transStatus;
  DateTime get getDate => dateTime;
}
