import 'package:flutter/material.dart';
import 'package:worldwalletnew/presentation/chatbot.dart';
import 'package:worldwalletnew/presentation/login.dart';
import 'package:worldwalletnew/presentation/restaurantsearch1.dart';
import 'package:worldwalletnew/oters/roomsearch1.dart';
import 'package:worldwalletnew/presentation/notification.dart';
import 'package:worldwalletnew/presentation/roombookinghistory.dart';
import 'package:worldwalletnew/presentation/roomsearch1.dart';
import 'package:worldwalletnew/presentation/foodbookinghistory.dart';
import 'package:worldwalletnew/presentation/viewProfile.dart';
import 'package:worldwalletnew/presentation/walletmanage.dart';
import 'package:worldwalletnew/services/getProfileApi.dart';
import 'package:worldwalletnew/services/getfoodorderingApi.dart';
import 'package:worldwalletnew/services/getfoodbookingHistory.dart';
import 'package:worldwalletnew/services/getnotificationApi.dart';
import 'package:worldwalletnew/services/getroombookinghistoryApi.dart';
import 'package:worldwalletnew/services/getwalletbalance.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key, this.username}) : super(key: key);
final username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
         
          // Drawer header with profile
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Customize the color if needed
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.kEXBJMLiahYU_7vmOq-4fwHaHa?w=156&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'), // Replace with your image URL
                  radius: 30.0,
                ),
                title: Text(
                  profiledata['Name'], // Replace with the actual user's name
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  profiledata['place'], // Replace with the user's email
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),

          // Profile section
          ListTile(
            leading: Icon(Icons.account_circle), // Profile icon
            title: Text('Profile'),
            onTap: () async{

         profiledata=await    fetchUserProfile();
              // Navigate to profile screen
              Navigator.push(context, MaterialPageRoute(builder: (tfc)=>ProfileScreen(profileData: profiledata,)));
            },
          ),

          // Logout button
          ListTile(
            leading: Icon(Icons.logout), // Logout icon
            title: Text('Logout'),
            onTap: () {
              // Implement the logout functionality

               // Show logout confirmation dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the logout function and navigate to login screen
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt)=>Login1()));
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  

           
            },
          ),
          ]
          
        ),
      ),
      appBar: AppBar(
        title: const Text("Budget Travel App"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blueAccent.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Welcome to Budget Travel",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Book affordable rooms, discover budget-friendly restaurants, and manage your expenses in one place.",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                SizedBox(height: 30),

                // Room Reservation Section
                _buildFeatureCard(
                  icon: Icons.hotel,
                  title: "Room Reservations",
                  description:
                      "Browse and reserve rooms based on price, location, and amenities.",
                  onTap: () {
                    // Navigate to Room Reservation screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RoomSearch1()));
                  },
                ),
                SizedBox(height: 20),

                // Nearby Restaurants Section
                _buildFeatureCard(
                  icon: Icons.restaurant,
                  title: "Restaurants",
                  description:
                      "Explore nearby restaurants and enjoy meals within your budget.",
                  onTap: () async {
                    // Navigate to Restaurant Discovery screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantSearchPage()));
                  },
                ),
                SizedBox(height: 20),

                // Wallet Management Section
                _buildFeatureCard(
                  icon: Icons.wallet_travel,
                  title: "Wallet Management",
                  description:
                      "Add funds, track your expenses, and view transaction history.",
                  onTap: () async {
                    String walletbalance = await getWalletbalance();
                    // Navigate to Wallet Management screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletExpenseScreen(
                                  balance: walletbalance,
                                )));
                  },
                ),
                SizedBox(height: 20),
                //    _buildFeatureCard(
                //   icon: Icons.history,
                //   title: "Booking History",
                //   description:
                //       "view booking history.",
                //   onTap: () {
                //     // Navigate to Wallet Management screen
                //   },
                // ),
                SizedBox(height: 50),

                // Bottom Navigation
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.history,
                          label: "Bwookings",
                          onTap: () async {
                            List<Map<String, dynamic>> orderHistory =
                                await fetchroomBookingHistory();
                            // Navigate to booking history
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingHistoryScreen(
                                          bookinghistory: orderHistory,
                                        )));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.delivery_dining_outlined,
                          label: "Orders",
                          onTap: () async {
                            List<Map<String, dynamic>> orderHistory =
                                await getOrderHistory();
                            // Navigate to order status
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FoodBookingHistoryScreen(
                                          foodHistory: orderHistory,
                                        )));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: _buildNavButton(
                          icon: Icons.notifications,
                          label: "notification",
                          onTap: () async {
                            List<Map<String, dynamic>> orderHistory =
                                await getNotification();
                            // Navigate to notifications
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage(
                                          notifications: orderHistory,
                                        )));
                          },
                        ),
                      ),
                      Flexible(
                        // flex: 1,
                        child: _buildNavButton(
                          icon: Icons.border_horizontal_outlined,
                          label: "AI",
                          onTap: () async {
                            //  List<Map<String, dynamic>>orderHistory=      await  getNotification();
                            // Navigate to notifications
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatBotScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.blueAccent),
              SizedBox(width: 16),
              Expanded(
                // Use Expanded here to ensure text can take up available space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      softWrap: true, // Ensure the text wraps
                      overflow: TextOverflow
                          .ellipsis, // Truncate text with ellipsis if it's too long
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color.fromARGB(255, 233, 235, 240),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: const Color.fromARGB(255, 232, 237, 246)),
          ),
        ],
      ),
    );
  }
}
