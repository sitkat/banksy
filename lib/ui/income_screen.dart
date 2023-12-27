import 'package:banksy/data/database_helper.dart';
import 'package:banksy/theme/app_colors.dart';
import 'package:banksy/theme/custom_app_bar.dart';
import 'package:banksy/ui/add_income_screen.dart';
import 'package:flutter/material.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  List<Map<String, dynamic>> incomeData = [];

  Future<void> _fetchIncomeData() async {
    final List<Map<String, dynamic>> result =
        await DatabaseHelper.instance.fetchIncomeData();
    setState(() {
      incomeData = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchIncomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, 'Income'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: incomeData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No information on income yet',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Click on the "Add income" button',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AppColors.whiteWithOpacity,
                      ),
                    ),
                    SizedBox(height: 90),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddIncomeScreen(),
                            ),
                          );
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
              )
            : ListView.builder(
                itemCount: incomeData.length,
                itemBuilder: (context, index) {
                  final incomeItem = incomeData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: AppColors.surface,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${incomeItem['amount']}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.accent,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${incomeItem['description']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: AppColors.whiteWithOpacity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Visibility(
        visible: incomeData.isNotEmpty,
        child: FloatingActionButton(
          backgroundColor: AppColors.accent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddIncomeScreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
