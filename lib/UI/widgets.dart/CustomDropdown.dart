import 'package:flutter/material.dart';
import 'package:perfumes/Model/materialmodel.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuItem<MaterialModel>> items;
  final MaterialModel? selectedMaterial;
  final ValueChanged<MaterialModel?> onChanged;

  CustomDropdownFormField({
    required this.labelText,
    required this.items,
    required this.selectedMaterial,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MaterialModel>(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      value: selectedMaterial,
      items: items,
      onChanged: onChanged,
    );
  }
}
