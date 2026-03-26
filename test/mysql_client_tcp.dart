import 'mysql_driver.dart';

void main() {
  testMysqlClient(
    '127.0.0.1',
    3306,
    'your_user',
    'your_password',
    'testdb',
  );
}
