import 'package:flutter/material.dart';

import '../models/bill_model.dart';

class BillItemSearch extends StatelessWidget {
  final BillModel bill;
  final String status;
  const BillItemSearch({
    super.key,
    required this.bill,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 3.3),
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Tên Khách Hàng : ${bill.name ?? ''}',
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Khách Hàng Vip ',
                  style: TextStyle(
                    color:
                        bill.isVip ?? false ? Colors.red : Colors.transparent,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: bill.isVip ?? false ? Colors.red : Colors.transparent,
                  size: 18,
                ),
              ],
            ),
            Text('Số lượng sách : ${bill.quantity ?? ''}'),
            Text('Giá tiền : ${bill.price?.toStringAsFixed(0)} VNĐ'),
            Text('Tổng tiền : ${bill.totalPrice.toStringAsFixed(0)} VNĐ'),
            Text(
              'Tình trạng : $status',
            ),
          ],
        ),
      ),
    );
  }
}
