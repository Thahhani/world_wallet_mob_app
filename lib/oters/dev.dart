import 'package:flutter/material.dart';

class flowers extends StatelessWidget {
  const flowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Column(
        children: [
          Text('rose'),
          Text('jasmine'),
          Container(
            height: 250,
            width: 250,
            color:Colors.blue,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('red'),
                Text('blue'),
                ElevatedButton(onPressed: (){}, child: Text('login'))

              ],
            ),
            
          )
        
        ],
      )
        );
      
    
    
  }
}