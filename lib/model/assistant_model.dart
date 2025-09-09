import 'package:ai_chat_bot_app/utils/enums/assistant_type.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart';

class AssistantModel {
  final String name;
  final String description;
  final AssistantType type;
  final String iconPath;

  AssistantModel({required this.name, required this.description, required this.type, required this.iconPath});
}

List<AssistantModel> assistants = [
  AssistantModel(
    name: 'Generic',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.generic,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Doctor',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.doctor,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Accountant',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.accountant,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Writer',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.writer,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Wife',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.wife,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Husband',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.husband,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Relationship Doctor',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.relationshipDoctor,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Personal Trainer',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.personalTrainer,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Dietitian',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.dietitian,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Astrology',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.astrology,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Fashion Designer',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.fashionDesigner,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Chef',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.chef,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Image Generation',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.imageGeneration,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Influencer',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.influencer,
    iconPath: Assets.gifLogoSpin,
  ),
  AssistantModel(
    name: 'Math Teacher',
    description: 'Lorem ipsum is a dummy or placeholder text commonly',
    type: AssistantType.mathTeacher,
    iconPath: Assets.gifLogoSpin,
  ),
];