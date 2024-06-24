// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiplication_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiplicationResultAdapter extends TypeAdapter<MultiplicationResult> {
  @override
  final int typeId = 0;

  @override
  MultiplicationResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiplicationResult(
      firstNumber: fields[0] as int,
      secondNumber: fields[1] as int,
      isCorrect: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MultiplicationResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstNumber)
      ..writeByte(1)
      ..write(obj.secondNumber)
      ..writeByte(2)
      ..write(obj.isCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiplicationResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
