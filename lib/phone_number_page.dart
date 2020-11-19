import 'package:contact_picker/contact_picker.dart' as cp;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberPage extends StatefulWidget {

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final cp.ContactPicker _contactPicker = cp.ContactPicker();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _bVNController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  String _phoneNumber;
  DateTime _dateOfBirth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Please enter your phone number then press next"),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InternationalPhoneNumberInput(
                  hintText: "Phone Number",
                  initialValue: PhoneNumber(isoCode: 'NG'),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      showFlags: true),
                  onInputChanged: (number) {
                    _phoneNumber = number.dialCode + number.phoneNumber;
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  cp.Contact contact = await _contactPicker.selectContact();
                  if (contact != null) {
                    _phoneNumber = contact.phoneNumber.number;
                  }
                },
                icon: Icon(Icons.contacts),
              ),
            ],
          ),

          SizedBox(height: 10),
          TextFormField(
            controller: _dateOfBirthController,
            readOnly: true,
            onTap: _selectDate,
            decoration: InputDecoration(
              hintText: "Date Of Birth",
            ),
          ),

          SizedBox(height: 10),
          TextFormField(
            controller: _bVNController,
            decoration: InputDecoration(
              hintText: "BVN (Optional)",
            ),
          ),

          SizedBox(height: 10),
          TextFormField(
            controller: _referralController,
            decoration: InputDecoration(
              hintText: "Referral ID (Optional)",
            ),
          ),
        ],
      ),
    );
  }

  _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth)
      setState(() {
        _dateOfBirthController.text = _dateFormat.format(picked).toString();
        _dateOfBirth = picked;
      });
  }
}
