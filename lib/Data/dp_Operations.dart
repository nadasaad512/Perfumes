import 'package:perfumes/Model/accountmodel.dart';

import '../Model/materialmodel.dart';
import 'DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class DbOperations {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<MaterialModel>> loadMaterials() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> result = await db.query('materials');
      return result.map((e) => MaterialModel.fromMap(e)).toList();
    } catch (e) {
      // Handle error
      print('Error loading materials: $e');
      return [];
    }
  }

  Future<void> addMaterial(MaterialModel material) async {
    final db = await _dbHelper.database;

    // Find the smallest available ID
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT MIN(id + 1) as id FROM materials 
    WHERE (id + 1) NOT IN (SELECT id FROM materials)
  ''');

    int? availableId = result.first['id'];

    // If no gaps, use the next available ID
    if (availableId == null) {
      List<Map<String, dynamic>> maxResult =
          await db.rawQuery('SELECT MAX(id) as max_id FROM materials');
      availableId = (maxResult.first['max_id'] ?? 0) + 1;
    }

    await db.insert(
      'materials',
      {
        'id': availableId,
        'material_name': material.materialName,
        'material_category': material.materialCategory,
        'cas_number': material.casNumber,
        'note': material.note,
        'relative_impact': material.relativeImpact,
        'odor_strength': material.odorStrength,
        'molecular_weight': material.molecularWeight,
        'odor_description': material.odorDescription,
        'remarks': material.remarks,
        'restrictions': material.restrictions,
        'final_restriction': material.finalRestriction,
        'sub_materials': material.subMaterials,
        'blends_well_with': material.blendsWellWith,
        'material_info': material.materialInfo,
        'category_type': material.categoryType,
        'scentree_category': material.scentreeCategory,
      },
    );
  }

  Future<void> editMaterial(int id, MaterialModel updatedMaterial) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'materials',
        updatedMaterial.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      // Consider returning or handling result if needed
    } catch (e) {
      // Handle error
      print('Error editing material: $e');
    }
  }

  Future<void> resetIdSequence() async {
    try {
      final db = await _dbHelper.database;

      // Reset the sequence by deleting the sqlite_sequence entry for the table
      await db.execute('DELETE FROM sqlite_sequence WHERE name="materials"');
      print('ID sequence reset successfully.');
    } catch (e) {
      print('Error resetting ID sequence: $e');
    }
  }

  Future<void> deleteMaterial(int id) async {
    try {
      final db = await _dbHelper.database;
      await db.delete('materials', where: 'id = ?', whereArgs: [id]);
      // Consider returning or handling result if needed
    } catch (e) {
      // Handle error
      print('Error deleting material: $e');
    }
  }

  addAccount({
    required String materialname,
    required String materialcategory,
    required String dilution,
    required String noteA,
    required String quantityOfMaterials,
    required String quantityFrom,
    required String worked,
    required String amountSub,
    required String relativeInfluence,
    required String smell,
    required String notes,
    required String restrictions,
    required String registration,
  }) async {
    final db = await _dbHelper.database;

    // Find the smallest available ID that is not currently used
    List<Map<String, dynamic>> result = await db.rawQuery('''
  SELECT MIN(id + 1) as id FROM accounts 
  WHERE (id + 1) NOT IN (SELECT id FROM accounts)
  ''');

    int? availableId = result.first['id'];

    // If no gaps were found, use the next available ID (one more than the current max ID)
    if (availableId == null) {
      List<Map<String, dynamic>> maxResult =
          await db.rawQuery('SELECT MAX(id) as max_id FROM accounts');
      availableId = (maxResult.first['max_id'] ?? 0) + 1;
    }

    // Insert the new material with the determined ID
    await db.insert(
      'accounts',
      {
        'id': availableId,
        'materialname': materialname,
        'formulaname': '',
        'perfum_with_alcohol': '',
        'need_worke': '',
        'materialcategory': materialcategory,
        'dilution': dilution,
        'noteA': noteA,
        'Quantity_of_materials': quantityOfMaterials,
        'Quantity_from_100': quantityFrom,
        'The_quantity_to_be_worked_on': worked,
        'amountsub': amountSub,
        'Relative_influence': relativeInfluence,
        'smell': smell,
        'Notes': notes,
        'Restrictions': restrictions,
        'Registrationsub': registration,
      },
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Optional: Handle conflicts
    );

    await loadMaterials2();
  }

  Future<List<Account>> loadMaterials2() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> result = await db.query('accounts');
      return result.map((e) => Account.fromMap(e)).toList();
    } catch (e) {
      // Handle error
      print('Error loading materials: $e');
      return [];
    }
  }

  Future<void> deleteMaterial2(int id) async {
    try {
      final db = await _dbHelper.database;
      await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
      // Consider returning or handling result if needed
    } catch (e) {
      // Handle error
      print('Error deleting material: $e');
    }
  }

  Future<void> editAccount(int id, String value, String key) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'accounts',
        {key: value},
        where: 'id = ?',
        whereArgs: [id],
      );

      await loadMaterials2();
      // Consider returning or handling result if needed
    } catch (e) {
      // Handle error
      print('Error editing material: $e');
    }
  }

  Future<void> editGeneral(String value, String key) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'accounts',
        {key: value},
      );
      await loadMaterials2();
      // Consider returning or handling result if needed
    } catch (e) {
      // Handle error
      print('Error editing material: $e');
    }
  }

  Future<String?> getFormulaName(String key) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query('accounts');
      if (result.isNotEmpty) {
        return result.first[key] as String?;
      } else {
        return null; // No formulaname found
      }
    } catch (e) {
      print('Error retrieving formulaname: $e');
      return null;
    }
  }
}
