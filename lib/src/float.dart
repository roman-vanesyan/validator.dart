import '_number.dart';

bool isFloat(String value,
        {bool allowSigned = false,
        bool allowLeadingZeros = false,
        bool allowScientificNotion = false}) =>
    isNumber(value, true,
        allowSigned: allowSigned,
        allowLeadingZero: allowLeadingZeros,
        allowScientificNotion: allowScientificNotion);
