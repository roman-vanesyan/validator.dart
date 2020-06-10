abstract class Validatable {
  //
  bool validate(Validator validator);
}

class Validator {
  bool validate(Validatable validatable) => validatable.validate(this);
}
