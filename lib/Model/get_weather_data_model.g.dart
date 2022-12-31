// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetWeatherDataModelAdapter extends TypeAdapter<GetWeatherDataModel> {
  @override
  final int typeId = 1;

  @override
  GetWeatherDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetWeatherDataModel();
  }

  @override
  void write(BinaryWriter writer, GetWeatherDataModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetWeatherDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
