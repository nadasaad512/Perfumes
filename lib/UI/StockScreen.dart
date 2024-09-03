import 'package:flutter/material.dart';

import '../Data/dp_Operations.dart';
import '../Model/materialmodel.dart';
import 'accountscreen.dart';

class MaterialTableScreen extends StatefulWidget {
  const MaterialTableScreen({super.key});

  @override
  _MaterialTableScreenState createState() => _MaterialTableScreenState();
}

class _MaterialTableScreenState extends State<MaterialTableScreen> {
  List<MaterialModel> materials = [];
  List<MaterialModel> filteredMaterials = [];
  final DbOperations _dbOperations = DbOperations();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  Future<void> _loadMaterials() async {
    final List<MaterialModel> loadedMaterials =
        await _dbOperations.loadMaterials();
    setState(() {
      materials = loadedMaterials;
      filteredMaterials = materials;
    });
  }

  Future<void> _addMaterial() async {
    final newMaterial = await showDialog<MaterialModel>(
      context: context,
      builder: (context) {
        return const MaterialEditDialog();
      },
    );

    if (newMaterial != null) {
      await _dbOperations.addMaterial(newMaterial);
      _loadMaterials();
    }
  }

  Future<void> _editMaterial(MaterialModel material) async {
    final updatedMaterial = await showDialog<MaterialModel>(
      context: context,
      builder: (context) {
        return MaterialEditDialog(material: material);
      },
    );

    if (updatedMaterial != null) {
      await _dbOperations.editMaterial(material.id!, updatedMaterial);
      _loadMaterials();
    }
  }

  Future<void> _deleteMaterial(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حذف '),
          content: const Text('هل انت متأكد من حذف الصف؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('نعم '),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('لا'),
            ),
          ],
        );
      },
    );

    // Ensure that confirmed is not null
    if (confirmed == true) {
      await _dbOperations.deleteMaterial(id);
      _loadMaterials();
    }
  }

  void _filterMaterials(String query) {
    setState(() {
      filteredMaterials = materials.where((material) {
        final noteLower = material.note.toLowerCase();
        final materialNameLower = material.materialName.toLowerCase();
        final materialCategory = material.materialCategory.toLowerCase();
        final casNumber = material.casNumber.toLowerCase();
        final relativeImpact = material.relativeImpact.toLowerCase();
        final categoryType = material.categoryType.toLowerCase();
        final scentreeCategory = material.scentreeCategory.toLowerCase();
        final searchLower = query.toLowerCase();
        return noteLower.contains(searchLower) ||
            casNumber.contains(searchLower) ||
            materialCategory.contains(searchLower) ||
            relativeImpact.contains(searchLower) ||
            categoryType.contains(searchLower) ||
            scentreeCategory.contains(searchLower) ||
            materialNameLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addMaterial,
      ),
      appBar: AppBar(

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 50,
              margin:  EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterMaterials,
                decoration:  InputDecoration(
                  hintText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple
                    ),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.purple),
                ),
              ),
            ),
          ),
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('م'),),
              DataColumn(label: Text('اسم المادة')),
              DataColumn(label: Text('تصنيف المادة')),
              DataColumn(label: Text('النوته')),
              DataColumn(label: Text('رقم CAS')),
              DataColumn(label: Text('التأثير النسبي')),
              DataColumn(label: Text('قوة الرائحة')),
              DataColumn(label: Text('الوزن الجزيئي')),
              DataColumn(label: Text('وصف الرائحه')),
              DataColumn(label: Text('الملاحظات')),
              DataColumn(label: Text('القيود')),
              DataColumn(
                  label: Text('قيد المادة بعد حساب قيود المواد الفرعية')),
              DataColumn(label: Text('المواد الفرعية')),
              DataColumn(label: Text('"من الكتاب يمتزج جيدا مع :"')),
              DataColumn(label: Text('"من الكتاب وصف الماده او معلومه"')),
              DataColumn(label: Text('نوع الفئه')),
              DataColumn(label: Text('تصنيف scentree.co')),
              DataColumn(label: Text('اجراء')),
            ],
            rows: filteredMaterials.map((material) {
              return DataRow(
                cells: [
                  DataCell(Text(material.id?.toString() ?? '')),
                  DataCell(Text(material.materialName)),
                  DataCell(Text(material.materialCategory)),
                  DataCell(Text(material.casNumber)),
                  DataCell(Text(material.note)),
                  DataCell(Text(material.relativeImpact)),
                  DataCell(Text(material.odorStrength)),
                  DataCell(Text(material.molecularWeight)),
                  DataCell(Text(material.odorDescription)),
                  DataCell(Text(material.remarks)),
                  DataCell(Text(material.restrictions)),
                  DataCell(Text(material.finalRestriction)),
                  DataCell(Text(material.subMaterials)),
                  DataCell(Text(material.blendsWellWith)),
                  DataCell(Text(material.materialInfo)),
                  DataCell(Text(material.categoryType)),
                  DataCell(Text(material.scentreeCategory)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,color: Colors.green,),
                          onPressed: () => _editMaterial(material),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: () => _deleteMaterial(material.id!),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MaterialEditDialog extends StatefulWidget {
  final MaterialModel? material;

  const MaterialEditDialog({super.key, this.material});

  @override
  _MaterialEditDialogState createState() => _MaterialEditDialogState();
}

class _MaterialEditDialogState extends State<MaterialEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _casNumberController;
  late TextEditingController _noteController;
  late TextEditingController _relativeImpactController;
  late TextEditingController _odorStrengthController;
  late TextEditingController _molecularWeightController;
  late TextEditingController _odorDescriptionController;
  late TextEditingController _remarksController;
  late TextEditingController _restrictionsController;
  late TextEditingController _finalRestrictionController;
  late TextEditingController _subMaterialsController;
  late TextEditingController _blendsWellWithController;
  late TextEditingController _materialInfoController;
  late TextEditingController _categoryTypeController;
  late TextEditingController _scentreeCategoryController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.material?.materialName ?? '');
    _categoryController =
        TextEditingController(text: widget.material?.materialCategory ?? '');
    _casNumberController =
        TextEditingController(text: widget.material?.casNumber ?? '');
    _noteController = TextEditingController(text: widget.material?.note ?? '');
    _relativeImpactController =
        TextEditingController(text: widget.material?.relativeImpact ?? '');
    _odorStrengthController =
        TextEditingController(text: widget.material?.odorStrength ?? '');
    _molecularWeightController =
        TextEditingController(text: widget.material?.molecularWeight ?? '');
    _odorDescriptionController =
        TextEditingController(text: widget.material?.odorDescription ?? '');
    _remarksController =
        TextEditingController(text: widget.material?.remarks ?? '');
    _restrictionsController =
        TextEditingController(text: widget.material?.restrictions ?? '');
    _finalRestrictionController =
        TextEditingController(text: widget.material?.finalRestriction ?? '');
    _subMaterialsController =
        TextEditingController(text: widget.material?.subMaterials ?? '');
    _blendsWellWithController =
        TextEditingController(text: widget.material?.blendsWellWith ?? '');
    _materialInfoController =
        TextEditingController(text: widget.material?.materialInfo ?? '');
    _categoryTypeController =
        TextEditingController(text: widget.material?.categoryType ?? '');
    _scentreeCategoryController =
        TextEditingController(text: widget.material?.scentreeCategory ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _casNumberController.dispose();
    _noteController.dispose();
    _relativeImpactController.dispose();
    _odorStrengthController.dispose();
    _molecularWeightController.dispose();
    _odorDescriptionController.dispose();
    _remarksController.dispose();
    _restrictionsController.dispose();
    _finalRestrictionController.dispose();
    _subMaterialsController.dispose();
    _blendsWellWithController.dispose();
    _materialInfoController.dispose();
    _categoryTypeController.dispose();
    _scentreeCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.material == null ? 'اضافة مادة' : 'تعديل مادة'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'اسم المادة'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'تصنيف المادة'),
            ),
            TextField(
              controller: _casNumberController,
              decoration: const InputDecoration(labelText: 'رقم CAS'),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText:'النوته'),
            ),
            TextField(
              controller: _relativeImpactController,
              decoration: const InputDecoration(labelText:'التأثير النسبي'),
            ),
            TextField(
              controller: _odorStrengthController,
              decoration: const InputDecoration(labelText: 'قوة الرائحة'),
            ),
            TextField(
              controller: _molecularWeightController,
              decoration: const InputDecoration(labelText: 'الوزن الجزيئي'),
            ),
            TextField(
              controller: _odorDescriptionController,
              decoration: const InputDecoration(labelText:'وصف الرائحه'),
            ),
            TextField(
              controller: _remarksController,
              decoration: const InputDecoration(labelText: 'الملاحظات'),
            ),
            TextField(
              controller: _restrictionsController,
              decoration: const InputDecoration(labelText: 'القيود'),
            ),
            TextField(
              controller: _finalRestrictionController,
              decoration: const InputDecoration(labelText:'قيد المادة بعد حساب قيود المواد الفرعية'),
            ),
            TextField(
              controller: _subMaterialsController,
              decoration: const InputDecoration(labelText:'المواد الفرعية'),
            ),
            TextField(
              controller: _blendsWellWithController,
              decoration: const InputDecoration(labelText: '"من الكتاب يمتزج جيدا مع :"'),
            ),
            TextField(
              controller: _materialInfoController,
              decoration: const InputDecoration(labelText: '"من الكتاب وصف الماده او معلومه"'),
            ),
            TextField(
              controller: _categoryTypeController,
              decoration: const InputDecoration(labelText: 'نوع الفئه'),
            ),
            TextField(
              controller: _scentreeCategoryController,
              decoration: const InputDecoration(labelText: 'تصنيف scentree.co'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialModel(
              id: widget.material?.id,
              materialName: _nameController.text,
              materialCategory: _categoryController.text,
              casNumber: _casNumberController.text,
              note: _noteController.text,
              relativeImpact: _relativeImpactController.text,
              odorStrength: _odorStrengthController.text,
              molecularWeight: _molecularWeightController.text,
              odorDescription: _odorDescriptionController.text,
              remarks: _remarksController.text,
              restrictions: _restrictionsController.text,
              finalRestriction: _finalRestrictionController.text,
              subMaterials: _subMaterialsController.text,
              blendsWellWith: _blendsWellWithController.text,
              materialInfo: _materialInfoController.text,
              categoryType: _categoryTypeController.text,
              scentreeCategory: _scentreeCategoryController.text,
            ));
          },
          child: const Text('حفظ'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('الغاء'),
        ),
      ],
    );
  }
}
