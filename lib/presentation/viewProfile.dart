import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/getProfileApi.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profileData;

  const ProfileScreen({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple,
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctcfgv)=>ProfileUpdateScreen(profileData: profileData,)));
        }, icon: Icon(Icons.edit,color: Colors.white,))],
      ),
      body: Center(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.deepPurple),
                  title: Text('Name'),
                  subtitle: Text(profileData['Name'] ?? 'N/A'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.deepPurple),
                  title: Text('Phone'),
                  subtitle: Text(profileData['phone'] ?? 'N/A'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.deepPurple),
                  title: Text('Place'),
                  subtitle: Text(profileData['place'] ?? 'N/A'),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// update

class ProfileUpdateScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const ProfileUpdateScreen({super.key, required this.profileData});

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _placeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profileData['Name']);
    _phoneController = TextEditingController(text: widget.profileData['phone']);
    _placeController = TextEditingController(text: widget.profileData['place']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  void _saveProfile()async {
    // You can update the profile data here
    // For now, let's just print the updated values to the console
    print('Updated Profile:');
    print('Name: ${_nameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Place: ${_placeController.text}');
    
    // Show a confirmation message or navigate back

    updateUserProfile({
      'Name': _nameController.text , 
      'place': _placeController.text,
      'phone': _phoneController.text,
    },context);
   
    Navigator.pop(context);
    Navigator.pop(context);
    setState(() {
      
    });
    //  Map<String, dynamic>profiledata=await    fetchUserProfile();
    //           // Navigate to profile screen
    //           Navigator.push(context, MaterialPageRoute(builder: (tfc)=>ProfileScreen(profileData: profiledata,)));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
