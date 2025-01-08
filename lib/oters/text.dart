import 'package:flutter/material.dart';

class asdf extends StatelessWidget {
  const asdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          color: Colors.amber,
          child:Row(
            children: [
              Text('sffgh'),
              SizedBox(width: 20,),
              Text('jhfjh'),
              Text('fffgc'),
              ElevatedButton(onPressed: (){}, child:Text('login'))
            ],
          )
        ),
      )

    );
  }
}