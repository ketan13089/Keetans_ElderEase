import 'package:cafe1/home/catTab.dart';
import 'package:cafe1/home/coffeeProd.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Row(
                  children: [
                    Text(
                      'Set Location',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ],
            ),
            Text(
              'Login',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Coffee',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 16),


            // Main Image

            //offer container
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView(
                  children: [
                    Image.asset(
                      'assets/slide1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/slide2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/slide3.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 16),


            // Category Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allows horizontal scrolling
              child: Row(
                children: [
                  CategoryTab(title: 'Cappuccino'),
                  SizedBox(width: 16),
                  CategoryTab(title: 'Americano'),
                  SizedBox(width: 16),
                  CategoryTab(title: 'Espresso'),
                  SizedBox(width: 16),
                  CategoryTab(title: 'Latte'),
                  SizedBox(width: 16),
                  CategoryTab(title: 'Mocha'),
                ],
              ),
            ),
            SizedBox(height: 16),


            // Product Grid
            Expanded(
              child: GridView.builder(
                itemCount: 6, // Adjust based on the number of products
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return CoffeeProductCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



