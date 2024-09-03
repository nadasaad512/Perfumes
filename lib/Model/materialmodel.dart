class MaterialModel {
  int? id;
  String materialName;
  String materialCategory;
  String note;
  String casNumber;
  String relativeImpact;
  String odorStrength;
  String molecularWeight;
  String odorDescription;
  String remarks;
  String restrictions;
  String finalRestriction;
  String subMaterials;
  String blendsWellWith;
  String materialInfo;
  String categoryType;
  String scentreeCategory;

  MaterialModel({
    this.id,
    required this.materialName,
    required this.materialCategory,
    required this.note,
    required this.casNumber,
    required this.relativeImpact,
    required this.odorStrength,
    required this.molecularWeight,
    required this.odorDescription,
    required this.remarks,
    required this.restrictions,
    required this.finalRestriction,
    required this.subMaterials,
    required this.blendsWellWith,
    required this.materialInfo,
    required this.categoryType,
    required this.scentreeCategory,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'material_name': materialName,
      'material_category': materialCategory,
      'note': note,
      'cas_number': casNumber,
      'relative_impact': relativeImpact,
      'odor_strength': odorStrength,
      'molecular_weight': molecularWeight,
      'odor_description': odorDescription,
      'remarks': remarks,
      'restrictions': restrictions,
      'final_restriction': finalRestriction,
      'sub_materials': subMaterials,
      'blends_well_with': blendsWellWith,
      'material_info': materialInfo,
      'category_type': categoryType,
      'scentree_category': scentreeCategory,
    };
  }

  // Convert a Map object into a Material object
  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      id: map['id'],
      materialName: map['material_name'],
      materialCategory: map['material_category'],
      note: map['note'],
      casNumber: map['cas_number'],
      relativeImpact: map['relative_impact'],
      odorStrength: map['odor_strength'],
      molecularWeight: map['molecular_weight'],
      odorDescription: map['odor_description'],
      remarks: map['remarks'],
      restrictions: map['restrictions'],
      finalRestriction: map['final_restriction'],
      subMaterials: map['sub_materials'],
      blendsWellWith: map['blends_well_with'],
      materialInfo: map['material_info'],
      categoryType: map['category_type'],
      scentreeCategory: map['scentree_category'], // Add this line
    );
  }}
