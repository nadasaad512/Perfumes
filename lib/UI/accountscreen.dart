import 'package:flutter/material.dart';
import 'package:perfumes/Model/accountmodel.dart';
import 'package:perfumes/UI/widgets.dart/CustomDropdown.dart';
import '../Data/dp_Operations.dart';
import '../Model/materialmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

// FloatingActionButton(
// onPressed: () async {
// PDFGenerator pdfGenerator = PDFGenerator();
// await pdfGenerator.generatePDF(table2Data);
// },
// child: Icon(Icons.picture_as_pdf),
// ),


class _AccountScreenState extends State<AccountScreen> {
  final Map<int, TextEditingController> _quantityOfMaterialsController = {};
  final Map<int, TextEditingController> _dilutionController = {};

  // final Map<int, TextEditingController> _quantityFrom100Controller = {};
  // final Map<int, TextEditingController> _quantityToBeWorkedOnController = {};
  final TextEditingController _quantityFrom100Controller =
      TextEditingController();
  final TextEditingController _quantityToBeWorkedOnController =
      TextEditingController();
  final TextEditingController _formulanameController = TextEditingController();
  final TextEditingController _perfum_with_alcoholController =
      TextEditingController();
  final TextEditingController _need_workeController = TextEditingController();

  List<Account> table2Data = [];
  final DbOperations _dbOperations = DbOperations();

  double one_amount = 0.0;
  double total_amount = 0.0;
  String? needworkevalue;
  String? formulaName;
  String? TotalAlcohol;

  @override
  void dispose() {
    _quantityOfMaterialsController.values
        .forEach((controller) => controller.dispose());
    _dilutionController.values.forEach((controller) => controller.dispose());

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadTable2Data();
    _updateTotalAmount();
  }

  void _updateTotalAmount() {
    total_amount = table2Data.fold(0.0, (sum, material) {


      if( material.quantityOfMaterials=="") {
        return 0.0;
      }else{
      return sum + double.parse(material.quantityOfMaterials.toString());
      }

    });
  }

  TextEditingController _getQuantityController(int id) {
    if (!_quantityOfMaterialsController.containsKey(id)) {
      _quantityOfMaterialsController[id] = TextEditingController();
    }
    return _quantityOfMaterialsController[id]!;
  }

  TextEditingController _getdilutionController(int id) {
    if (!_dilutionController.containsKey(id)) {
      _dilutionController[id] = TextEditingController();
    }
    return _dilutionController[id]!;
  }

  Future<void> _loadTable2Data() async {
    final List<Account> data = await _dbOperations.loadMaterials2();
   needworkevalue= await _dbOperations.getFormulaName('need_worke');
   formulaName= await _dbOperations.getFormulaName('formulaname');
   TotalAlcohol= await _dbOperations.getFormulaName('perfum_with_alcohol');
    setState(() {
      table2Data = data;
      needworkevalue;
      needworkevalue!=null?
      _need_workeController.text=needworkevalue.toString():null;

      formulaName!=null?
      _formulanameController.text=formulaName.toString():null;


      TotalAlcohol!=null?
      _perfum_with_alcoholController.text=TotalAlcohol.toString():null;

    });
    _updateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await showDialog(
              context: context,
              builder: (context) => AccountAddDialog(),
            );

            if (result != null) {
              setState(() {
                _loadTable2Data();
              });
            }
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(

                      label:Text( 'اسم التركيبة',style: TextStyle(
                          fontSize: 10
                      ),),
                      labelStyle: TextStyle(
                        color: Colors.purple,
                      ),
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
                    ),
                    controller: _formulanameController,
                    onSubmitted: (value) async {
                      await _dbOperations.editGeneral(
                          _formulanameController.text, 'formulaname');
                      setState(() {
                        _loadTable2Data();
                      });
                    },
                  ),
                ),

                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      label:Text('اجمالي العطر مع الكحول ',style: TextStyle(
                          fontSize: 10
                      ),),
                      labelStyle: TextStyle(
                        color: Colors.purple,
                      ),
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


                    ),


                    controller: _perfum_with_alcoholController,
                    onSubmitted: (value) async {
                      await _dbOperations.editGeneral(
                          _perfum_with_alcoholController.text,
                          'perfum_with_alcohol');
                      setState(() {
                        _loadTable2Data();
                      });
                    },
                  ),
                ),

                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      label:Text('الكمية المطلوب العمل عليها',style: TextStyle(
                          fontSize: 10
                      ),),
                      labelStyle: TextStyle(
                        color: Colors.purple,
                      ),
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

                    ),
                    controller: _need_workeController,
                    onSubmitted: (value) async {
                      await _dbOperations.editGeneral(
                          _need_workeController.text, 'need_worke');
                      setState(() {
                        needworkevalue = value;
                        _updateQuantities();
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30
                      ),
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('م')),
                          DataColumn(label: Text('اسم المادة')),
                          DataColumn(label: Text('تصنيف المادة')),
                          DataColumn(label: Text('التخفيف')),
                          DataColumn(label: Text("النوته")),
                          DataColumn(label: Text("كمية المواد")),
                          DataColumn(label: Text('الكمية من 100%')),
                          DataColumn(label: Text("الكمية المطلوب العمل عليها")),
                          DataColumn(
                              label: Text("كمية المواد الفرعية داخل المادة")),
                          DataColumn(label: Text("التأثير النسبي")),
                          DataColumn(label: Text("وصف الرائحة")),
                          DataColumn(label: Text("الملاحظات")),
                          DataColumn(label: Text("القيود")),
                          DataColumn(label: Text("قيد المواد الفرعية")),
                          DataColumn(label: Text("")),
                        ],
                        rows: table2Data.map((material) {
                          final quantityController =
                              _getQuantityController(material.id!);
                          final dilutionController =
                              _getdilutionController(material.id!);
                          dilutionController.text = material.dilution.toString();
                          quantityController.text =
                              material.quantityOfMaterials.toString();
                          material.quantityOfMaterials==""?
                              null:
                          _quantityFrom100Controller.text =

                          "${((double.parse(material.quantityOfMaterials.toString()) / total_amount) * 100).toStringAsFixed(2)}%";
                          material.quantityOfMaterials==""||needworkevalue==null||needworkevalue==''?
                          null:
                          _quantityToBeWorkedOnController.text =
                              "${(((double.parse(material.quantityOfMaterials.toString())) / total_amount) *
                                  (double.parse(needworkevalue.toString()))).toStringAsFixed(2)}ml";

                          return DataRow(cells: [
                            DataCell(Text(material.id?.toString() ?? '')),
                            DataCell(Text(material.materialname.toString())),
                            DataCell(Text(material.materialcategory.toString())),
                            DataCell(TextField(
                              controller: dilutionController,
                              onSubmitted: (value) async {
                                await _dbOperations.editAccount(material.id!,
                                    dilutionController.text, 'dilution');
                                setState(() {
                                  _loadTable2Data();
                                });
                              },
                            )),
                            DataCell(Text(material.noteA.toString())),
                            DataCell(
                              TextField(
                                controller: quantityController,
                                onSubmitted: (value) async {
                                  setState(() {
                                    one_amount = double.parse(value);
                                    _updateTotalAmount();
                                    _quantityFrom100Controller.text =
                                        "${((one_amount / total_amount) * 100).toStringAsFixed(2)} %";
                                    _quantityToBeWorkedOnController.text =
                                        "${((one_amount / total_amount) * double.parse(needworkevalue.toString())).toStringAsFixed(2)} ml";
                                  });

                                  await _dbOperations.editAccount(material.id!,
                                      value, 'Quantity_of_materials');
                                  await _dbOperations.editAccount(
                                      material.id!,
                                      _quantityFrom100Controller.text,
                                      'Quantity_from_100');
                                  await _dbOperations.editAccount(
                                      material.id!,
                                      _quantityToBeWorkedOnController.text,
                                      'Quantity_to_be_worked_on');

                                  setState(() {
                                    _loadTable2Data();
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller: _quantityFrom100Controller,
                                enabled: false,
                                style: TextStyle(
                                  color: Colors.black, // Change this to the color you want
                                ),
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller: _quantityToBeWorkedOnController,
                                enabled: false,
                                style: TextStyle(
                                  color: Colors.black, // Change this to the color you want
                                ),
                              ),
                            ),
                            DataCell(Text(material
                                .amountOfSubSubstancesWithinSubstance
                                .toString())),
                            DataCell(Text(material.relativeInfluence.toString())),
                            DataCell(
                                Text(material.descriptionOfSmell.toString())),
                            DataCell(Text(material.notes.toString())),
                            DataCell(Text(material.restrictions.toString())),
                            DataCell(Text(
                                material.registrationOfSubSubjects.toString())),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.delete,color: Colors.red,),
                                      onPressed: () {
                                        _dbOperations
                                            .deleteMaterial2(material.id!);
                                        setState(() {
                                          _loadTable2Data();
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _updateQuantities() {
    if(needworkevalue!=null||needworkevalue!=''){
    setState(() {

      for (var material in table2Data) {
        final one_amount = double.parse(material.quantityOfMaterials.toString());
        final quantityFrom100 = (one_amount / total_amount) * 100;
        final quantityToBeWorkedOn = (one_amount / total_amount) * double.parse(needworkevalue.toString());

        material.quantityFrom100Percent = "${quantityFrom100.toStringAsFixed(2)}%";
        material.quantityToBeWorkedOn = "${quantityToBeWorkedOn.toStringAsFixed(2)}ml";
      }
    });
  }}


}


class AccountAddDialog extends StatefulWidget {
  @override
  State<AccountAddDialog> createState() => _AccountAddDialogState();
}

class _AccountAddDialogState extends State<AccountAddDialog> {
  final DbOperations _dbOperations = DbOperations();

  final TextEditingController _materialCategoryController =
      TextEditingController();
  final TextEditingController _materialNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _subSubstancesController =
      TextEditingController();
  final TextEditingController _relativeInfluenceController =
      TextEditingController();
  final TextEditingController _descriptionOfSmellController =
      TextEditingController();

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _registrationOfSubSubjectsController =
      TextEditingController();
  final TextEditingController _restrictionsController = TextEditingController();

  List<MaterialModel> table1Data = [];

  MaterialModel? _selectedMaterial;

  @override
  void dispose() {
    _materialCategoryController.dispose();
    _noteController.dispose();
    _materialNameController.dispose();
    _subSubstancesController.dispose();
    _relativeInfluenceController.dispose();
    _descriptionOfSmellController.dispose();
    _notesController.dispose();
    _registrationOfSubSubjectsController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadTable1Data();
  }

  Future<void> _loadTable1Data() async {
    final List<MaterialModel> data = await _dbOperations.loadMaterials();
    setState(() {
      table1Data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('اختر مادة'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensures the dialog is only as tall as it needs to be
          children: [
            CustomDropdownFormField(
              labelText: 'اسم المادة',
              items: table1Data.map((material) {
                return DropdownMenuItem<MaterialModel>(
                  value: material,
                  child: Text(material.materialName),
                );
              }).toList(),
              selectedMaterial: _selectedMaterial,
              onChanged: (MaterialModel? selectedMaterial) {
                setState(() {
                  _selectedMaterial = selectedMaterial;
                  if (selectedMaterial != null) {
                    _materialCategoryController.text =
                        selectedMaterial.materialCategory;
                    _materialNameController.text =
                        selectedMaterial.materialName;
                    print(
                        "_materialNameController is ${_materialNameController.text}");
                    _noteController.text = selectedMaterial.note;

                    _subSubstancesController.text =
                        selectedMaterial.subMaterials;
                    _relativeInfluenceController.text =
                        selectedMaterial.relativeImpact;
                    _descriptionOfSmellController.text =
                        selectedMaterial.odorDescription;

                    _notesController.text = selectedMaterial.remarks;
                    _restrictionsController.text =
                        selectedMaterial.restrictions;
                    _registrationOfSubSubjectsController.text =
                        selectedMaterial.finalRestriction;
                  }

                  print(
                      "2_materialNameController is ${_materialNameController.text}");
                });
              },
            ),
            // Add more fields here as needed
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await _dbOperations.addAccount(
              materialname: _materialNameController.text == "null"
                  ? ""
                  : _materialNameController.text,
              notes:
                  _notesController.text == "null" ? "" : _notesController.text,
              noteA: _noteController.text == "null" ? "" : _noteController.text,

              dilution: "",
              //input

              quantityFrom: "",
              //input
              quantityOfMaterials: "",
              //input
              worked: "",
              //input

              registration: _restrictionsController.text == "null"
                  ? ""
                  : _restrictionsController.text,
              relativeInfluence: _relativeInfluenceController.text == "null"
                  ? ""
                  : _relativeInfluenceController.text,
              restrictions: _registrationOfSubSubjectsController.text == "null"
                  ? ""
                  : _registrationOfSubSubjectsController.text,
              amountSub: _subSubstancesController.text == null
                  ? ""
                  : _subSubstancesController.text,
              materialcategory: _materialCategoryController.text == "null"
                  ? ""
                  : _materialCategoryController.text,
              smell: _descriptionOfSmellController.text == "null"
                  ? ""
                  : _descriptionOfSmellController.text,
            );

            Navigator.of(context).pop('result data');
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
