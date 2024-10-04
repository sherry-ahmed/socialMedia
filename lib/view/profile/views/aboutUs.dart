import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
       // Set background color to black for contrast
      body:  Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Mission',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SB.h(10),
              Text(
                'At Rumored, our mission is to provide the best services and products that meet the needs of our customers. '
                'We are committed to quality, innovation, and ensuring that you have the best experience possible.',
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Our Vision',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SB.h(10),
              Text(
                'We envision a future where technology seamlessly integrates into everyday life, solving problems and creating new opportunities '
                'for people around the world. We strive to be at the forefront of that change, driving innovation and excellence in everything we do.',
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Our Team',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SB.h(10),
              Text(
                'Our team consists of passionate professionals dedicated to delivering the best possible products and services. '
                'We come from diverse backgrounds, united by our desire to make a positive impact through technology.',
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Contact Us',
                style:  Theme.of(context).textTheme.titleLarge
              ),
              SB.h(20),
               Text(
                'Thank You',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SB.h(10),
              Text(
                'Thank you for choosing Vinciio. We are excited to have you with us on this journey, and we look forward to serving you!',
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.justify,
              ),
              SB.h(10),
              Text(
                'If you have any questions or suggestions, feel free to reach out to us:\n',
                
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.justify,
              ),
              Text(
                
                'Email: rootPointers@example.com\n'
                'Phone: +1-234-567-890\n'
                'Address: 1234 Canal Road, Lahore, Pakistan',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}
