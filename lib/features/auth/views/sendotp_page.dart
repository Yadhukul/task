import 'package:flutter/material.dart';

class SendotpPage extends StatelessWidget {
  const SendotpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
          
            children: [
          
              Image.asset('assets/image/sendotppage_image.png',height: 250,width: 200,),
             SizedBox(height: 5,),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text("Enter Phone Number ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
              SizedBox(height: 15,),
TextFormField(
  decoration: InputDecoration(
    hintText: 'Enter Phone Number',

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.blueGrey, // 🔥 color when selected
        width: 2,
      ),
    ),
  ),
),              SizedBox(height: 15,),
              Text('By Continuing, I agree to TotalX’s Terms and condition & privacy policy'),
                SizedBox(height: 20,),
              InkWell(onTap: () {
                
              },
                child: Container(
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Colors.black ),
                  height: 50,width: double.infinity,child: Center(child: Text('Send OTP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),),
              )
          
              ],),
        ),
      ));
  }
}
