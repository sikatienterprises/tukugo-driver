import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text('About Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(0, 0, 0, 0.7),
              )),
          SizedBox(height: 30),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                    'Professional Tuku Go Platform. Here we will provide you only interesting content, which you will like very much. We are dedicated to providing you the best of Tuku Go, with a focus on dependability and Earning. We are working to turn our passion for Tuku Go into a booming online website. We hope you enjoy our Tuku Go as much as we enjoy offering them to you. I will keep posting more important posts on my Website for all of you. Please give your support and love. Professional Tuku Go Platform. Here we will provide you only interesting content, which you will like very much. We are dedicated to providing you the best of Tuku Go, with a focus on dependability and Earning. We are working to turn our passion for Tuku Go into a booming online website. We hope you enjoy our Tuku Go as much as we enjoy offering them to you. I will keep posting more important posts on my Website for all of you. Please give your support and love.',
                    style: TextStyle(
                      wordSpacing: 2,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
