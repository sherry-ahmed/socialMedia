import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';


class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('(FAQs)', style: Theme.of(context).textTheme.titleLarge),
              SB.h(10),
              _buildFaqItem(context, 'How do I create an account?',
                  'To create an account, tap the "Sign Up" button and fill in your details. You\'ll receive a verification email to activate your account.'),
              _buildFaqItem(
                  context,
                  'I forgot my password. How can I reset it?',
                  'On the login page, tap "Forgot Password" and enter your email address. Follow the instructions in the email to reset your password.'),
              _buildFaqItem(context, 'How can I update my profile?',
                  'Go to the "Profile" section, tap "Edit Profile," and make any necessary updates to your information.'),
              _buildFaqItem(context, 'How do I contact customer support?',
                  'You can contact our support team by tapping "Contact Support" or by emailing us at rootPointers@example.com.'),
              SB.h(20),
              Text('Contact Support',
                  style: Theme.of(context).textTheme.titleLarge),
              SB.h(10),
              Text(
                'If you need assistance, our support team is available to help.\n',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              Text(
                  'Email: rootPointers@example.com\n'
                  'Phone: +1-234-567-890\n'
                  'Support Hours: Monday to Friday, 9 AM - 6 PM (PKT)',
                  style: Theme.of(context).textTheme.bodyMedium),
              SB.h(10),
              Text('App Troubleshooting',
                  style: Theme.of(context).textTheme.titleLarge),
              SB.h(10),
              _buildTroubleshootItem(
                  context,
                  'The app is crashing or not responding.',
                  'Restart your device and reopen the app.Ensure you\'re using the latest version of the app.Clear the app\'s cache and data from your device settings.'),
              _buildTroubleshootItem(context, 'Notifications aren\'t working.',
                  'Check if notifications are enabled for the app in your phone settings.Try logging out and back into the app.'),
              _buildTroubleshootItem(
                  context,
                  'Location services are not working.',
                  'Ensure location permissions are granted for the app.Make sure location services are enabled on your device.'),
              SB.h(20),
              Text('Terms & Conditions',
                  style: Theme.of(context).textTheme.titleLarge),
              SB.h(10),
              Text(
                  'For more details on our terms and conditions, privacy policy, and user agreement, visit our website at www.example.com/terms.',
                  style: Theme.of(context).textTheme.bodyLarge),
              SB.h(20),
              Text('Need More Help?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white)),
              SB.h(10),
              Text(
                'For further assistance, contact us through the app or visit our website for additional resources.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white)),
          const SizedBox(height: 5),
          Text(
            answer,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootItem(
      BuildContext context, String issue, String solution) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(issue,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white)),
          const SizedBox(height: 5),
          Text(
            solution,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
