library automail;

import 'package:auto_mail/db/db.dart';
import 'package:flutter/foundation.dart';

class AutoMail {
  final String mailAddress;
  AutoMail({@required this.mailAddress}) {
    addDataToTable(mailAddress);
  }

  addDataToTable(String mail) async {
    DB db = DB();

    await db.initDB();
    await db.insertData();
    await db.transaction();
    await db.getData(mail);
  }
}
