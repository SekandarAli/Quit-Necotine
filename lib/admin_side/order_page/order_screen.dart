import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {


  var _listProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Column(
        children: [
          DataTable(
            columns: const [
              DataColumn(
                  label: Text(
                    "Customer\n Name",
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500,),
                  )),
              DataColumn(
                  label: Text(
                    "Order\n ID",
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500),
                  )),
              DataColumn(
                  label: Text(
                    "Order\n Status",
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500),
                  )),
              DataColumn(
                  label: Text(
                    "Shipppind\n Address",
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500),
                  )),
            ],
            rows: _listProducts
             .map((e) =>

              DataRow(cells: [
                DataCell(Text("Pavan",style: TextStyle(fontSize: 10),)),
                DataCell(Text("3",style: TextStyle(fontSize: 10),)),
                DataCell(Text("99",style: TextStyle(fontSize: 10),)),
                DataCell(Text("99",style: TextStyle(fontSize: 10),)),
              ])).toList(),


          ),
  ],
),
    );
  }
}
