import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';



class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
      // Set background color to black for contrast
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Privacy Policy',
                style:Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We value your privacy and are committed to protecting your personal data. This Privacy Policy explains how we handle your information, '
                'the choices you have regarding your data, and how you can contact us for more information.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Information We Collect',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We collect information that you provide directly to us when you use our services, such as when you create an account, update your profile, '
                'or communicate with us. This may include your name, email address, phone number, and any other details necessary for us to provide our services.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'How We Use Your Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We use the information we collect to provide, maintain, and improve our services. This includes personalizing your experience, responding to '
                'your requests, and communicating with you about updates, promotions, or technical issues.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Sharing Your Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We do not share your personal information with third parties, except in the following circumstances:\n'
                '- With your consent or at your direction.\n'
                '- To comply with legal obligations or protect the rights and safety of our users.\n'
                '- In connection with a business transaction, such as a merger or sale of assets.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Your Data Rights',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'You have the right to access, update, and delete your personal data. You can manage your information by accessing your account settings or contacting us directly.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Cookies',
                style:Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We use cookies and similar technologies to enhance your experience on our platform. You can control cookie settings through your browser, but disabling cookies may affect the functionality of our services.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Changes to this Policy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'We may update this Privacy Policy from time to time. We encourage you to review it periodically to stay informed about how we are protecting your data.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              SB.h(20),
              Text(
                'Contact Us',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SB.h(10),
              Text(
                'If you have any questions or concerns about this Privacy Policy or how we handle your information, feel free to contact us at:\n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Email: rootPointers@example.com\n'
                'Phone: +1-234-567-890\n'
                'Address: 1234 Canal View, Data Lahore, Pakistan',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
