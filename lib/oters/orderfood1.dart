import 'package:flutter/material.dart';

// Sample data for nearby restaurants and their menus
class Restaurant {
  final String name;
  final String imageUrl;
  final List<MenuItem> menu;

  Restaurant({required this.name, required this.imageUrl, required this.menu});
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}

class Order {
  final MenuItem item;
  int quantity;

  Order({required this.item, required this.quantity});

  double get totalPrice => item.price * quantity;
}

class OrderFoodPage extends StatefulWidget {
  final Restaurant restaurant;

  OrderFoodPage({required this.restaurant});

  @override
  _OrderFoodPageState createState() => _OrderFoodPageState();
}

class _OrderFoodPageState extends State<OrderFoodPage> {
  List<Order> orders = [];

  void addToOrder(MenuItem item) {
    setState(() {
      orders.add(Order(item: item, quantity: 1)); // default quantity 1
    });
  }

  void removeFromOrder(Order order) {
    setState(() {
      orders.remove(order);
    });
  }

  void updateQuantity(Order order, int quantity) {
    setState(() {
      order.quantity = quantity;
    });
  }

  double get totalAmount {
    double total = 0.0;
    for (var order in orders) {
      total += order.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality (optional)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Restaurant details and menu list
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.restaurant.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Menu',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.restaurant.menu.length,
                itemBuilder: (context, index) {
                  final menuItem = widget.restaurant.menu[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        menuItem.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text('\$${menuItem.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart, color: Colors.deepOrangeAccent),
                        onPressed: () => addToOrder(menuItem),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (orders.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                'Your Order',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        title: Text(order.item.name),
                        subtitle: Row(
                          children: [
                            Text('x${order.quantity}'),
                            SizedBox(width: 10),
                            Text('\$${order.totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.deepOrangeAccent),
                              onPressed: () {
                                if (order.quantity > 1) {
                                  updateQuantity(order, order.quantity - 1);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.deepOrangeAccent),
                              onPressed: () {
                                updateQuantity(order, order.quantity + 1);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => removeFromOrder(order),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Total: \$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Process the order and payment
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Order Placed'),
                      content: Text('Your order has been placed successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              orders.clear();
                            });
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ] else ...[
              Center(child: Text('No items in the cart.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for nearby restaurants
    final restaurant = Restaurant(
      name: 'Sushi King',
      imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-m/1280/18/d5/5b/d8/sushi-king-sooka.jpg',
      menu: [
        MenuItem(name: 'Sushi Rolls', price: 12.0),
        MenuItem(name: 'Nigiri', price: 15.0),
        MenuItem(name: 'Maki', price: 10.0),
      ],
    );

    return MaterialApp(
      title: 'Restaurant Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrderFoodPage(restaurant: restaurant),
    );
  }
}
