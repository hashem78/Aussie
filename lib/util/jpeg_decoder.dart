import 'dart:typed_data';

import 'package:aussie/models/block_entity.dart';

import 'asize.dart';

class JpegDecoder {
  final Uint8List data;

  JpegDecoder(this.data);

  int convertRadix16ToInt(List<int> list, {bool reverse = false}) {
    final sb = StringBuffer();

    if (reverse) {
      final List<int> rev = list.reversed.toList();
      for (final i in rev) {
        sb.write(i.toRadixString(16).padLeft(2, '0'));
      }
    } else {
      for (final i in list) {
        sb.write(i.toRadixString(16).padLeft(2, '0'));
      }
    }

    final numString = sb.toString();
    return int.tryParse(numString, radix: 16);
  }

  ASize get size {
    int start = 2;
    BlockEntity block;

    while (true) {
      block = getBlockInfo(start);
      if (block == null) {
        return null;
      }

      if (block.type == 0xC0 || block.type == 0xC2) {
        final widthList = data.getRange(start + 7, start + 9).toList();
        final heightList = data.getRange(start + 5, start + 7).toList();
        final width = convertRadix16ToInt(widthList);
        final height = convertRadix16ToInt(heightList);
        return ASize(width, height);
      } else {
        start += block.length;
      }
    }
  }

  int getIntFromRange(List<int> list, int start, int end) {
    final rangeInt = list.getRange(start, end);
    final sb = StringBuffer();
    for (final i in rangeInt) {
      sb.write(i.toRadixString(16).padLeft(2, '0'));
    }
    return int.tryParse(sb.toString(), radix: 16);
  }

  BlockEntity getBlockInfo(int blackStart) {
    try {
      final blockInfoList = data.getRange(blackStart, blackStart + 4).toList();

      if (blockInfoList[0] != 0xFF) {
        return null;
      }

      final radix16List = data.getRange(blackStart + 2, blackStart + 4);
      final blockLength = convertRadix16ToInt(radix16List.toList()) + 2;
      final typeInt = blockInfoList[1];

      return BlockEntity(typeInt, blockLength);
    } catch (e) {
      return null;
    }
  }
}
