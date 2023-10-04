import 'package:flutter/material.dart';

import '../models/bill_model.dart';

class BillItem extends StatelessWidget {
  final BillModel bill;
  final VoidCallback? onDelete;
  final Function(bool?)? onChange;
  final Function(bool?)? onChangeNoPay;
  const BillItem({
    super.key,
    required this.bill,
    this.onChange,
    this.onChangeNoPay,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Tên Khách Hàng : ${bill.name ?? ''}'),
          const SizedBox(height: 5),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Vip ',
                    style: TextStyle(
                      color:
                          bill.isVip ?? false ? Colors.red : Colors.transparent,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color:
                        bill.isVip ?? false ? Colors.red : Colors.transparent,
                    size: 18,
                  ),
                ],
              ),
              const Spacer(),
              Text('Số Lượng : ${bill.quantity ?? ''}'),
              const Spacer(),
              Text('Giá : ${bill.price?.toStringAsFixed(0)} VND'),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Divider(
                  height: 4,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Tổng Tiền : ${bill.totalPrice.toStringAsFixed(0)} VND',
                ),
              ),
              const Expanded(
                child: Divider(
                  height: 4,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 2,
            color: Colors.blue,
          ),
          const SizedBox(height: 5),
          
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: bill.isPay ?? false,
                      onChanged: onChangeNoPay,
                    ),
                    const Text(
                      'Chưa Thanh Toán',
                      style: TextStyle(fontSize: 11),
                    ),


                    
                    const Spacer(),
                    Radio(
                      value: true,
                      groupValue: bill.isPay ?? false,
                      onChanged: onChange,
                    ),
                    const Text(
                      'Đã Thanh Toán',
                      style: TextStyle(fontSize: 11),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  () {
                    if (bill.isPay ?? false) {
                    } else {
                      return Icons.delete;
                    }
                  }(),
                  size: 22,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
