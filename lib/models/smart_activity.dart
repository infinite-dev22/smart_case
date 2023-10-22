import 'package:smart_case/models/smart_model.dart';

class SmartActivity extends SmartModel {
  int id;
  String name;
  String? description;
  String code;
  int categoryId;
  int isActive;
  String? activityDate;

  SmartActivity({
    required this.id,
    required this.name,
    required this.description,
    required this.code,
    required this.categoryId,
    required this.isActive,
    required this.activityDate,
  });

  factory SmartActivity.fromJson(Map json) {
    return SmartActivity(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        code: json['code'],
        categoryId: json['category_id'],
        isActive: json['is_active'],
        activityDate: json['created_at']);
  }

  static toJson(SmartActivity activity) {
    return {
      'id': activity.id,
      'name': activity.name,
      'description': activity.description,
      'code': activity.code,
      'category_id': activity.categoryId,
      'is_active': activity.isActive,
      'created_at': activity.activityDate,
    };
  }

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }
}