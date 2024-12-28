import 'package:flutter/material.dart';

class TableNumberPage extends StatelessWidget {
  final String tableNumber;
  final List<Map<String, dynamic>> productDetails;

  TableNumberPage({required this.tableNumber, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طاولة رقم $tableNumber'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text(
              'رقم الطاولة: $tableNumber',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productDetails.length,
              itemBuilder: (context, index) {
                var product = productDetails[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('السعر المدخل: ${product['price']}'),
                      Text('السعر المعدل: ${product['modifiedPrice']}'),
                      Text('عدد الإضافات: ${product['addCount']}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
