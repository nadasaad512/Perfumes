class Account {
  int? id;
  String? materialname;
  String? formulaname;
  String? perfum_with_alcohol;
  String? need_worke;
  String? materialcategory;
  String? dilution;
  String? noteA;
  String? quantityOfMaterials;
  String? quantityFrom100Percent;
  String? quantityToBeWorkedOn;
  String? amountOfSubSubstancesWithinSubstance;
  String? relativeInfluence;
  String? descriptionOfSmell;
  String? notes;
  String? restrictions;
  String? registrationOfSubSubjects;


  Account({
    this.id,
    this.materialname,
    this.perfum_with_alcohol,
    this.formulaname,
    this.need_worke,
    this.materialcategory,
    this.dilution,
    this.noteA,
    this.quantityOfMaterials,
    this.quantityFrom100Percent,
    this.quantityToBeWorkedOn,
    this.amountOfSubSubstancesWithinSubstance,
    this.relativeInfluence,
    this.descriptionOfSmell,
    this.notes,
    this.restrictions,
    this.registrationOfSubSubjects,

  });

  // Convert a Account into a Map. The keys must correspond to the column names.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'materialname': materialname,
      'materialcategory': materialcategory,
      'need_worke': need_worke,
      'formulaname': formulaname,
      'perfum_with_alcohol': perfum_with_alcohol,
      'dilution': dilution,
      'noteA': noteA,
      'Quantity_of_materials': quantityOfMaterials,
      'Quantity_from_100': quantityFrom100Percent,
      'The_quantity_to_be_worked_on': quantityToBeWorkedOn,
      'amountsub':
          amountOfSubSubstancesWithinSubstance,
      'Relative_influence': relativeInfluence,
      'smell': descriptionOfSmell,
      'Notes': notes,
      'Restrictions': restrictions,
      'Registrationsub': registrationOfSubSubjects,

    };
  }

  // Extract an Account object from a Map.
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      materialname: map['materialname'],
      materialcategory: map['materialcategory'],
      dilution: map['dilution'],
      need_worke: map['need_worke'],
      formulaname: map['formulaname'],
      perfum_with_alcohol: map['perfum_with_alcohol'],
      noteA: map['noteA'],
      quantityOfMaterials: map['Quantity_of_materials'],
      quantityFrom100Percent: map['Quantity_from_100'],
      quantityToBeWorkedOn: map['The_quantity_to_be_worked_on'],
      amountOfSubSubstancesWithinSubstance:
          map['amountsub'],
      relativeInfluence: map['Relative_influence'],
      descriptionOfSmell: map['smell'],
      notes: map['Notes'],
      restrictions: map['Restrictions'],
      registrationOfSubSubjects: map['Registrationsub'],

    );
  }
}
