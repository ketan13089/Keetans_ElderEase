import 'package:flutter/material.dart';

import 'cart.dart';

class CoffeeProductCard extends StatelessWidget {
  const CoffeeProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/cappucino.jpg'),
                      fit: BoxFit.cover,
                  ),
                  //color: Colors.grey[400],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Text('4.9'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cappuccino', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('With Chocolate'),
                SizedBox(height: 2),
                Text('Rs. 400', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Spacer(),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>CoffeeDetailsPage()),
                  );
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
