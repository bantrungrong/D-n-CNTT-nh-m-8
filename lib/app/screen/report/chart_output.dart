// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PieChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biểu đồ xuất sản phẩm'),
      ),
      // body: Center(
      //   child: PieChart(
      //     PieChartData(
      //       sections: _createSampleData(),
      //       centerSpaceRadius: 40,
      //       sectionsSpace: 2,
      //     ),
      //   ),
      // ),
    );
  }
}

//   List<PieChartSectionData> _createSampleData() {
//     return [
//       PieChartSectionData(
//         color: Colors.red,
//         value: 30,
//         title: '30%',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.blue,
//         value: 25,
//         title: '25%',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.green,
//         value: 20,
//         title: '20%',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.yellow,
//         value: 15,
//         title: '15%',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.orange,
//         value: 10,
//         title: '10%',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//     ];
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: PieChartSample(),
//   ));
// }
