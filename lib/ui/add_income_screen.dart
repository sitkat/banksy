import 'package:banksy/ui/income_screen.dart';
import 'package:banksy/ui/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/database_helper.dart';
import '../theme/app_colors.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({Key? key}) : super(key: key);

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final formFieldAmount = TextEditingController();
  final formFieldDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: CupertinoNavigationBarBackButton(
            color: AppColors.accent,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const NavigationScreen()));
            },
          ),
          title: Text(
            'Back',
            style: TextStyle(color: AppColors.accent, fontSize: 13.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  'Income amount',
                  style: TextStyle(
                    color: AppColors.whiteWithOpacity,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: formFieldAmount,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text(
                  'Income description',
                  style: TextStyle(
                    color: AppColors.whiteWithOpacity,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: formFieldDescription,
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState?.validate() != true) {
                        return;
                      } else {
                        await saveIncomeToDatabase();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NavigationScreen()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add income',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveIncomeToDatabase() async {
    final database = await DatabaseHelper.instance.database;

    final amount = double.tryParse(formFieldAmount.text) ?? 0.0;
    final description = formFieldDescription.text;

    await database.insert('Income', {
      'amount': amount,
      'description': description,
    });
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField(
      {required this.controller, this.keyboardType = TextInputType.text})
      : super();

  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: 1,
        style: TextStyle(color: AppColors.accent),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  String? validator(String? value) {
    if (value?.isEmpty == true) {
      return "Obligatory field";
    }
    if (keyboardType == TextInputType.number) {
      final regexNumber = RegExp(r'^[0-9,.]*$');
      if (!regexNumber.hasMatch(value!)) {
        return "The field can only contain numbers and ,.";
      }
    }
    return null;
  }
}
