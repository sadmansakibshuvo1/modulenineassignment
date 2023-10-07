import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bag',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<int> itemCounts = List<int>.generate(3, (index) => 0);
  List<double> unitPrices = [51, 30, 43];
  double totalAmount = 0;

  void updateTotalAmount() {
    setState(() {
      totalAmount = 0;
      for (int i = 0; i < itemCounts.length; i++) {
        totalAmount += (unitPrices[i] * itemCounts[i]);
      }
    });
  }

  void increaseItemCount(int index) {
    setState(() {
      itemCounts[index]++;
      updateTotalAmount();
    });
  }

  void decreaseItemCount(int index) {
    if (itemCounts[index] > 0) {
      setState(() {
        itemCounts[index]--;
        updateTotalAmount();
      });
    }
  }

  void showCongratulatorySnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> items = [
      ClothingItem(
        name: 'Pullover',
        imageUrl:
        'https://m.media-amazon.com/images/I/81NhYmYylLL._AC_UY1000_.jpg',
        color: 'Black',
        size: 'L',
        price: 51,
      ),
      ClothingItem(
        name: 'T-Shirt',
        imageUrl:
        'https://5.imimg.com/data5/UM/AX/AM/SELLER-22386761/men-s-polyster-round-neck-tshirts-500x500.jpg',
        color: 'Gray',
        size: 'L',
        price: 30,
      ),
      ClothingItem(
        name: 'Sport Dress',
        imageUrl:
        'https://i5.walmartimages.com/asr/f5d53638-3bf4-4610-9b1e-543330219dbb.28ba6ce16c15da56581edf1ec7a24905.jpeg?odnHeight=2000&odnWidth=2000&odnBg=FFFFFF',
        color: 'Black',
        size: 'M',
        price: 43,
      ),
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.search),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'My Bag',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      for (int index = 0; index < itemCounts.length; index++)
                        Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.green,
                                  width: double.infinity,
                                  height: 150,
                                  child: Image.network(
                                    items[index].imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            items[index].name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Icon(Icons.more_vert),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Color: ${items[index].color}   Size: ${items[index].size}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Card(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      decreaseItemCount(index);
                                                    },
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                ),
                                              ),
                                              Text('${itemCounts[index]}'),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Card(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      increaseItemCount(index);
                                                    },
                                                    icon: Icon(Icons.add),
                                                  ),
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 20),
                                                child: Text("${items[index].price}\$"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total amount: '),
                              Text(
                                '${totalAmount.toStringAsFixed(2)}\$',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            showCongratulatorySnackbar();
                          },
                          child: Text('CHECK OUT'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClothingItem {
  final String name;
  final String imageUrl;
  final String color;
  final String size;
  final double price;

  ClothingItem({
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.size,
    required this.price,
  });
}
