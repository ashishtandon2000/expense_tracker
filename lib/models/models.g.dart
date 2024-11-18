// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 3;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      title: fields[2] == null ? 'undefined-title' : fields[2] as String,
      amount: fields[3] == null ? 0 : fields[3] as int,
      category: fields[4] == null
          ? ExpenseCategory.miscellaneous
          : fields[4] as ExpenseCategory,
      subCategory: fields[5] == null
          ? ExpenseSubCategory.other
          : fields[5] as ExpenseSubCategory,
      date: fields[1] as DateTime,
      id: fields[0] as String,
      isRecurring: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.subCategory)
      ..writeByte(6)
      ..write(obj.isRecurring);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 1;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.essential;
      case 1:
        return ExpenseCategory.nonEssential;
      case 2:
        return ExpenseCategory.miscellaneous;
      default:
        return ExpenseCategory.essential;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.essential:
        writer.writeByte(0);
        break;
      case ExpenseCategory.nonEssential:
        writer.writeByte(1);
        break;
      case ExpenseCategory.miscellaneous:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseSubCategoryAdapter extends TypeAdapter<ExpenseSubCategory> {
  @override
  final int typeId = 2;

  @override
  ExpenseSubCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseSubCategory.food;
      case 1:
        return ExpenseSubCategory.living;
      case 2:
        return ExpenseSubCategory.travel;
      case 3:
        return ExpenseSubCategory.shopping;
      case 4:
        return ExpenseSubCategory.other;
      default:
        return ExpenseSubCategory.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseSubCategory obj) {
    switch (obj) {
      case ExpenseSubCategory.food:
        writer.writeByte(0);
        break;
      case ExpenseSubCategory.living:
        writer.writeByte(1);
        break;
      case ExpenseSubCategory.travel:
        writer.writeByte(2);
        break;
      case ExpenseSubCategory.shopping:
        writer.writeByte(3);
        break;
      case ExpenseSubCategory.other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSubCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
