import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/add.wallet.dart';
import 'package:worldwalletnew/services/getTransactionHistory.dart';


class WalletExpenseScreen extends StatefulWidget {
  final balance;
  const WalletExpenseScreen({super.key, this.balance});
 // Changed from WalletManageScreen to WalletExpenseScreen
  @override
  _WalletExpenseScreenState createState() => _WalletExpenseScreenState(); // Changed from _WalletManageScreenState to _WalletExpenseScreenState
}

class _WalletExpenseScreenState extends State<WalletExpenseScreen> { // Changed from _WalletManageScreenState to _WalletExpenseScreenState
  double walletBalance = 50.00; // Current wallet balance
  double lowBalanceThreshold = 20.00; // Threshold for low balance alert

  List<Map<String, dynamic>> transactions = [
    {'type': 'Room Booking', 'amount': 100, 'date': '2024-12-01'},
    {'type': 'Food Order', 'amount': 25, 'date': '2024-12-02'},
    {'type': 'Room Booking', 'amount': 80, 'date': '2024-12-05'},
    {'type': 'Food Order', 'amount': 30, 'date': '2024-12-06'},
    {'type': 'Room Booking', 'amount': 50, 'date': '2024-12-10'},
  ];

  double totalRoomSpending = 0;
  double totalFoodSpending = 0;

  // Function to calculate total spending for rooms and food
  void calculateTotalSpending() {
    totalRoomSpending = 0;
    totalFoodSpending = 0;

    for (var transaction in transactions) {
      if (transaction['type'] == 'Room Booking') {
        totalRoomSpending += transaction['amount'];
      } else if (transaction['type'] == 'Food Order') {
        totalFoodSpending += transaction['amount'];
      }
    }
  }

  // Navigate to AddFundsScreen
  // void navigateToAddFundsScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PaymentTopUpScreen(
  //         currentBalance: walletBalance,
  //         onFundsAdded: (amount) {
  //           setState(() {
  //             walletBalance += amount;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    calculateTotalSpending(); // Calculate total spending on init
  }

  @override
  Widget build(BuildContext context) {
    bool isLowBalance = walletBalance < lowBalanceThreshold;

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet Manage & Expenses", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Display
              Text(
                "Current Wallet Balance:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              Text(
                "\$${widget.balance}",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isLowBalance ? Colors.red : Colors.green),
              ),
              SizedBox(height: 20),

              // Low Balance Alert (if applicable)
              if (isLowBalance)
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your wallet balance is low! Please add funds to continue making reservations or orders.",
                          style: TextStyle(fontSize: 16, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),

              // Action Buttons
              ElevatedButton(
                onPressed: (){
                   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentTopUpScreen(
         
         
          
        ),
      ),);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Add Funds", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: ()async {
                   List<Map<String, dynamic>>orderHistory=      await getTransactionHistory();
                  // Navigate to transaction history screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionHistoryScreen(transactions: orderHistory)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("View Transaction History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),

              // Total Spending Summary
              _totalSpendingSummary(),
            ],
          ),
        ),
      ),
    );
  }

  // Total Spending Summary Widget
  Widget _totalSpendingSummary() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Spending",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Room Booking: \$${totalRoomSpending.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            Text(
              "Food Orders: \$${totalFoodSpending.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            SizedBox(height: 10),
            Text(
              "Total Spending: \$${(totalRoomSpending + totalFoodSpending).toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentTopUpScreen extends StatefulWidget {




  @override
  _PaymentTopUpScreenState createState() => _PaymentTopUpScreenState();
}

class _PaymentTopUpScreenState extends State<PaymentTopUpScreen> {
  final _amountController = TextEditingController();
  String selectedPaymentMethod = "Credit/Debit Card";

  // void processPayment() {
  //   // Simulate payment processing
  //   if (_amountController.text.isNotEmpty) {
  //     double amount = double.parse(_amountController.text);
  //     if (amount > 0) {
  //       widget.onFundsAdded(amount); // Update the wallet balance
  //       Navigator.pop(context); // Return to the WalletManageScreen after adding funds
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Funds Added Successfully!")),
  //       );
  //     } else {
  //       showError("Amount should be greater than 0.");
  //     }
  //   } else {
  //     showError("Please enter an amount.");
  //   }
  // }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Up Wallet", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Add Funds to Wallet",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal[700]),
              ),
              SizedBox(height: 20),

              // Amount input field
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "Enter amount to add",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // Payment Method selection
              Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.teal[700]),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: DropdownButton<String>(
                  value: selectedPaymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                  underline: SizedBox(),
                  isExpanded: true,
                  items: <String>["Credit/Debit Card", "PayPal", "Google Pay"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 18)),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Payment button
              ElevatedButton.icon(
                onPressed: (){
                  addtoWlletApi({
                    'balance':_amountController.text,
                    'paymenttype':selectedPaymentMethod
                  },context);
                },
                icon: Icon(Icons.payment, color: Colors.white),
                label: Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  TransactionHistoryScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(Icons.money_off_outlined, color: Colors.teal[600], size: 30),
                title: Text("${transactions[index]['transactiontype']} - \$${transactions[index]['amount']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text("Date: ${transactions[index]['date']??'07-01-2025'}", style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
                // trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
