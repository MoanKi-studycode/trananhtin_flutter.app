import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/form/form_model.dart';

class PageFormMathang extends StatelessWidget {
  PageFormMathang({Key? key}) : super(key: key);
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  MatHang m = MatHang();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoLuong = TextEditingController();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Demo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                controller: txtName,
                onSaved: (newValue) => m.name = newValue,
                validator: (value) => validateString(value),
                decoration: InputDecoration(labelText: "Ten mat hang"),
              ),
              DropdownButtonFormField<String>(
                items: loaiMHs
                    .map(
                      (loaiMH) => DropdownMenuItem<String>(
                        child: Text("${loaiMH}"),
                        value: loaiMH,
                      ),
                    )
                    .toList(),
                value: dropdownValue,
                validator: (value) => validateString(value),
                decoration: InputDecoration(labelText: "Loai mat hang"),
                onChanged: (value) => dropdownValue = value,
                onSaved: (newValue) => m.loaiMH = newValue,
              ),
              TextFormField(
                controller: txtSoLuong,
                keyboardType: TextInputType.number,
                onSaved: (newValue) => m.soluong = int.parse(newValue!),
                validator: (value) => validateSoluong(value),
                decoration: InputDecoration(labelText: "So luong"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _save(context),
                    child: Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      hienThiDiaLog(context);
    }
  }

  validateString(String? value) {
    return value == null || value.isEmpty
        ? "You are not asign any data yet"
        : null;
  }

  validateSoluong(String? value) {
    if (value == null || value.isEmpty)
      return "You are not asign any number yet";
    else
      return int.parse(value) < 0 ? "Number do not lower than 0" : null;
  }

  void hienThiDiaLog(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Alert"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Ban  da nhap mat hang:"),
          Text("Ten MH: ${m.name}"),
          Text("Loai MH: ${m.loaiMH}"),
          Text("So luong: ${m.soluong}"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}
