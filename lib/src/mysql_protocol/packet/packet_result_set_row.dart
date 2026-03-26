import 'dart:convert';
import 'dart:typed_data';
import 'package:mysql_driver/mysql_protocol.dart';
import 'package:mysql_driver/mysql_protocol_extension.dart';

class MySQLResultSetRowPacket extends MySQLPacketPayload {
  List<dynamic> values;

  MySQLResultSetRowPacket({
    required this.values,
  });

  factory MySQLResultSetRowPacket.decode(Uint8List buffer, int numOfCols) {
    final byteData = ByteData.sublistView(buffer);
    int offset = 0;

    List<dynamic> values =
        []; // Doit être dynamic pour accepter String ou Uint8List

    for (int x = 0; x < numOfCols; x++) {
      final nextByte = byteData.getUint8(offset);

      if (nextByte == 0xfb) {
        values.add(null);
        offset += 1;
      } else {
        // 1. On lit les octets bruts
        final binaryResult = buffer.getBinaryLengthEncoded(offset);
        final Uint8List rawBytes = binaryResult.item1;

        try {
          // 2. On tente le décodage texte
          values.add(utf8.decode(rawBytes));
        } catch (e) {
          // 3. C'est du binaire (UUID/Blob), on stocke tel quel !
          values.add(rawBytes);
        }

        offset += binaryResult.item2;
      }
    }

    return MySQLResultSetRowPacket(values: values);
  }
  @override
  Uint8List encode() {
    throw UnimplementedError();
  }
}
