import 'dart:typed_data';
import 'package:mysql_driver/mysql_protocol.dart';

class MySQLPacketEmptyPayload extends MySQLPacketPayload {
  @override
  Uint8List encode() {
    throw UnimplementedError();
  }
}
