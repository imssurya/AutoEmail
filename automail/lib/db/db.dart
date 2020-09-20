import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer2/mailer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DB {
  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'trans_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE trans(id INTEGER , desc TEXT, status INTEGER, date TEXT)",
        );
      },
      version: 1,
    );
    print(db.path);
  }

  Future<void> insertData() async {
    String date = DateTime.now().toString();
    await db.rawInsert(
        "INSERT Into trans (id,desc,status,date) VALUES ('2','abc','Error','$date')");
  }

  Future<void> transaction() async {
    final List<Map<String, dynamic>> maps = await db.query('trans');
    print(maps);
  }

  Future<void> getData(String mail) async {
    List<Map> result = await db.rawQuery(
        'SELECT * FROM trans WHERE status=? and date like ?',
        ['Error', '%' + DateTime.now().toString().substring(0, 10) + '%']);

    // print the results
    result.forEach((row) async {
      var options = new GmailSmtpOptions()
        ..username = 'fluttertesting1@gmail.com' // enter your mail
        ..password = 'Outlook007007'; // enter your app password
      var emailTransport = new SmtpTransport(options);
      var envelope = Envelope()
        ..from = 'fluttertesting1@gmail.com'
        ..recipients.add(mail)
        ..subject = 'Error occured'
        ..text =
            'Error Data Loaded in Transaction Table please find table results below $row';
      emailTransport.send(envelope).then((envelope) {
        print("Email sent!");
      }).catchError((e) {
        print("'Error occurred: $e");
      });
    });
  }
}
