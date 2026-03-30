import 'package:flutter/material.dart';

class SendotpPage extends StatelessWidget {
  const SendotpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Column(
        children: [

          Image.asset('assets/image/sendotppage_image.png'),

          Text("Enter Phone Number "),
          SizedBox(height: 10,),
          TextFormField(decoration: InputDecoration(hint: Text('Enter Phone Number'),border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),)),
          SizedBox(height: 10,),
          Text('By Continuing, I agree to TotalX’s Terms and condition & privacy policy'),

          Container(color: Colors.black,height: 25,width: double.infinity,child: Center(child: Text('Send OTP',style: TextStyle(color: Colors.white),)),)
      
    ],));
  }
}
