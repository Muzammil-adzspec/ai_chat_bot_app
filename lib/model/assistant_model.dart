import 'package:ai_chat_bot_app/utils/enums/assistant_type.dart';

class AssistantModel {
  final String name;
  final AssistantType type;
  final String iconPath;

  AssistantModel({required this.name, required this.type, required this.iconPath});
}

List<AssistantModel> assistants = [
  AssistantModel(name: 'Generic', type: AssistantType.generic, iconPath: ''),
  AssistantModel(name: 'Doctor', type: AssistantType.doctor, iconPath: ''),
  AssistantModel(name: 'Accountant', type: AssistantType.accountant, iconPath: ''),
  AssistantModel(name: 'Writer', type: AssistantType.writer, iconPath: ''),
  AssistantModel(name: 'Wife', type: AssistantType.wife, iconPath: ''),
  AssistantModel(name: 'Husband', type: AssistantType.husband, iconPath: ''),
  AssistantModel(name: 'Relationship Doctor', type: AssistantType.relationshipDoctor, iconPath: ''),
  AssistantModel(name: 'Personal Trainer', type: AssistantType.personalTrainer, iconPath: ''),
  AssistantModel(name: 'Dietitian', type: AssistantType.dietitian, iconPath: ''),
  AssistantModel(name: 'Astrology', type: AssistantType.astrology, iconPath: ''),
  AssistantModel(name: 'Fashion Designer', type: AssistantType.fashionDesigner, iconPath: ''),
  AssistantModel(name: 'Chef', type: AssistantType.chef, iconPath: ''),
  AssistantModel(name: 'Image Generation', type: AssistantType.imageGeneration, iconPath: ''),
  AssistantModel(name: 'Influencer', type: AssistantType.influencer, iconPath: ''),
  AssistantModel(name: 'Math Teacher', type: AssistantType.mathTeacher, iconPath: ''),
];