// import 'package:appapp/database/db_table.dart';
//
// // void main() async {
// //   final sqliteManager = SqliteManager.instance;
// //   await sqliteManager.connect();
// //
// //   // เพิ่มข้อมูล
// //   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'เงินเดือน'});
// //   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'ค่าอาหาร'});
// //   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'ค่าเดินทาง'});
// //   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'อื่นๆ'});
// //
// //   // await sqliteManager.closeDatabase();
// // }
// // เรียกใช้เมทอด insertData ในคลาส SqliteManager
// final sqliteManager = SqliteManager.instance;
// final Map<String, dynamic> financialData = {
//   'date_user': '2024-03-03', // ตัวอย่างเท่านั้น คุณควรดึงวันที่จริงจากการป้อนข้อมูลจากผู้ใช้
//   'amount_financial': 100.50, // ตัวอย่างเท่านั้น คุณควรดึงจำนวนจริงจากการป้อนข้อมูลจากผู้ใช้
//   'type_expense': 1, // ตัวอย่างเท่านั้น คุณควรดึงค่าจากการป้อนข้อมูลจากผู้ใช้
//   'ID_type_financial': 1, // ตัวอย่างเท่านั้น คุณควรดึงค่าจากการป้อนข้อมูลจากผู้ใช้
//   'memo_financial': 'Expense for groceries', // ตัวอย่างเท่านั้น คุณควรดึงข้อมูลจากการป้อนข้อมูลจากผู้ใช้
// };
//
// // บันทึกข้อมูลลงในตาราง Financial
// await sqliteManager.insertData('Financial', financialData);
//
//
//
// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'database/db_table.dart';
//
// class Page2 extends StatelessWidget {
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
// @override
// Widget build(BuildContext context) => Scaffold(
// key: _scaffoldKey,
// appBar: AppBar(title: Text('Static Chart')),
// body: Center(
// child: Column(
// children: [
// TableCalendar(
// firstDay: DateTime.utc(2023, 1, 1),
// lastDay: DateTime.utc(2024, 12, 31),
// focusedDay: DateTime.now(),
// // ... other properties
// ),
// SizedBox(height: 20),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 2),
// borderRadius: BorderRadius.circular(10),
// ),
// child: IconButton(
// icon: Icon(Icons.bar_chart),
// onPressed: () {
// _showFinancialPieChart(context);
// },
// iconSize: 60,
// color: Colors.blue,
// ),
// ),
// SizedBox(width: 20),
// Container(
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 2),
// borderRadius: BorderRadius.circular(10),
// ),
// child: IconButton(
// icon: Icon(Icons.edit),
// onPressed: () {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('รายการ'),
// ),
// );
// },
// iconSize: 60,
// color: Colors.green,
// ),
// ),
// SizedBox(width: 20),
// Container(
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 2),
// borderRadius: BorderRadius.circular(10),
// ),
// child: IconButton(
// icon: Icon(Icons.scale),
// onPressed: () {
// _showFinancialBarChart(context);
// },
// iconSize: 60,
// color: Colors.orange,
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// );
//
// //***************[ B A R C H A R T ]******************
// void _showFinancialBarChart(BuildContext context) async {
// Map<String, double> data = await fetchIncomeExpenseFromDatabase();
// double totalIncome = data['totalIncome'] ?? 0;
// double totalExpense = data['totalExpense'] ?? 0;
// print('Total Income: $totalIncome');
// print('Total Expense: $totalExpense');
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: Text('Financial Chart'),
// content: FinancialBarChart(
// totalIncome: totalIncome,
// totalExpense: totalExpense,
// ),
// actions: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text('Close'),
// ),
// ],
// );
// },
// );
// }
// }
// class FinancialBarChart extends StatelessWidget {
// final double totalIncome;
// final double totalExpense;
//
// FinancialBarChart({
// required this.totalIncome,
// required this.totalExpense,
// });
//
// @override
// Widget build(BuildContext context) {
// return BarChart(
// BarChartData(
// barGroups: [
// BarChartGroupData(
// x: 0,
// barRods: [
// BarChartRodData(
// y: totalIncome,
// colors: [Colors.green],
// width: 25,
// ),
// ],
// ),
// BarChartGroupData(
// x: 1,
// barRods: [
// BarChartRodData(
// y: totalExpense,
// colors: [Colors.red],
// width: 25,
// ),
// ],
// ),
// ],
// titlesData: FlTitlesData(
// leftTitles: SideTitles(showTitles: false),
// bottomTitles: SideTitles(
// showTitles: true,
// getTitles: (double value) {
// if (value == 0) {
// return 'Income';
// } else if (value == 1) {
// return 'Expense';
// }
// return '';
// },
// ),
// ),
// borderData: FlBorderData(show: false),
// barTouchData: BarTouchData(enabled: false),
// ),
// );
// }
//
//
//
// }
// //****************[ B A R C H A R T ]************************
//
//
//
// //****************[ P I E C H A R T ]*************************
// Future<List<FinancialPieChartItem>> calculateFinancialData(
// String selectedPeriod) async {
// List<FinancialPieChartItem> financialData = [];
// try {
// String query = '';
// switch (selectedPeriod) {
// case 'Day':
// query =
// 'SELECT ID_type_financial, SUM(amount_financial) AS total_amount FROM financial WHERE type_expense = 1 AND DATE(date_user) = DATE(\'now\') GROUP BY ID_type_financial';
// break;
// case 'Week':
// query =
// 'SELECT ID_type_financial, SUM(amount_financial) AS total_amount FROM financial WHERE type_expense = 1 AND strftime(\'%W\', timestamp) = strftime(\'%W\', \'now\') GROUP BY ID_type_financial';
// break;
// case 'Month':
// query =
// 'SELECT ID_type_financial, SUM(amount_financial) AS total_amount FROM financial WHERE type_expense = 1 AND strftime(\'%m\', timestamp) = strftime(\'%m\', \'now\') GROUP BY ID_type_financial';
// break;
// case 'Year':
// query =
// 'SELECT ID_type_financial, SUM(amount_financial) AS total_amount FROM financial WHERE type_expense = 1 AND strftime(\'%Y\', timestamp) = strftime(\'%Y\', \'now\') GROUP BY ID_type_financial';
// break;
// default:
// query = '';
// }
//
// if (query.isNotEmpty) {
// List<Map<String, dynamic>> result =
// await SqliteManager.instance.queryDatabase(query);
// financialData = result.map((row) {
// int id = row['ID_type_financial'];
// double totalAmount =
// double.tryParse(row['total_amount'].toString()) ?? 0.0;
// return FinancialPieChartItem(
// id: id,
// amount: totalAmount,
// color: getRandomColor(),
// );
// }).toList();
// }
// } catch (error) {
// print('Error calculating financial data: $error');
// }
// return financialData;
// }
//
//
// Future<Map<String, double>> fetchIncomeExpenseFromDatabase() async {
// double totalIncome = 0;
// double totalExpense = 0;
// try {
// List<Map<String, dynamic>> incomeResult = await SqliteManager.instance
//     .queryDatabase(
// 'SELECT SUM(amount_financial) AS total_income FROM Financial WHERE type_expense = 0');
// totalIncome = (incomeResult[0]['total_income'] ?? 0).toDouble();
//
// List<Map<String, dynamic>> expenseResult = await SqliteManager.instance
//     .queryDatabase(
// 'SELECT SUM(amount_financial) AS total_expense FROM Financial WHERE type_expense = 1');
// totalExpense = (expenseResult[0]['total_expense'] ?? 0).toDouble();
// } catch (error) {
// print("Error fetching data from database: $error");
// }
// return {
// 'totalIncome': totalIncome,
// 'totalExpense': totalExpense,
// };
// }
//
// void _showFinancialPieChart(BuildContext context) {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: Text('Financial Pie Chart'),
// content: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// ElevatedButton(
// onPressed: () {
// _showPieChartByPeriod(context, 'Day');
// },
// child: Text('Day'),
// ),
// ElevatedButton(
// onPressed: () {
// _showPieChartByPeriod(context, 'Week');
// },
// child: Text('Week'),
// ),
// ElevatedButton(
// onPressed: () {
// _showPieChartByPeriod(context, 'Month');
// },
// child: Text('Month'),
// ),
// ElevatedButton(
// onPressed: () {
// _showPieChartByPeriod(context, 'Year');
// },
// child: Text('Year'),
// ),
// ],
// ),
// actions: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text('Close'),
// ),
// ],
// );
// },
// );
// }
//
// void _showPieChartByPeriod(BuildContext context, String selectedPeriod) {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return FutureBuilder(
// future: calculateFinancialData(selectedPeriod), // ส่ง selectedPeriod เข้าไป
// builder: (BuildContext context,
// AsyncSnapshot<List<FinancialPieChartItem>> snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Center(child: CircularProgressIndicator());
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// List<FinancialPieChartItem> pieChartItems =
// snapshot.data ?? [];
// return AlertDialog(
// title: Text('Financial Pie Chart'),
// content: Container(
// width: MediaQuery.of(context).size.width * 0.9,
// height: MediaQuery.of(context).size.height * 0.5,
// child: FinancialPieChart(items: pieChartItems),
// ),
// actions: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text('Close'),
// ),
// ],
// );
// }
// },
// );
// },
// );
// }
//
//
// Color getRandomColor() {
// final Random random = Random();
// return Color.fromRGBO(
// random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
// }
//
//
// class FinancialPieChart extends StatelessWidget {
// final List<FinancialPieChartItem> items;
//
// FinancialPieChart({required this.items});
//
// @override
// Widget build(BuildContext context) {
// double totalAmount =
// items.fold(0, (previous, current) => previous + current.amount);
//
// return Row(
// children: [
// Expanded(
// child: PieChart(
// PieChartData(
// sections: List.generate(
// items.length,
// (index) => PieChartSectionData(
// color: items[index].color,
// value: (items[index].amount / totalAmount) * 100,
// title:
// '${((items[index].amount / totalAmount) * 100).toStringAsFixed(2)}%',
// radius: 100,
// titleStyle: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.bold,
// color: Colors.black,
// ),
// ),
// ),
// sectionsSpace: 0,
// centerSpaceRadius: 40,
// ),
// ),
// ),
// SizedBox(width: 10),
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: List.generate(
// items.length,
// (index) => Row(
// children: [
// Container(
// width: 20,
// height: 20,
// color: items[index].color,
// ),
// SizedBox(width: 5),
// Text('Category ${items[index].id}'),
// ],
// ),
// ),
// ),
// ],
// );
// }
// }
//
// class FinancialPieChartItem {
// final int id;
// final double amount;
// final Color color;
//
// FinancialPieChartItem({required this.id, required this.amount, required this.color});
// }
//
