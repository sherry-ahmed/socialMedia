import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
//
//RESPONSIVE
//
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;
  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;
  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;
  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

//
//MEDIA QUERY
//
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;
  double get paddingDefault => height * 0.02;

//
//TEXT STYLES
//


//   Future<bool?> showToast(String message) {
//     return Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: primary,
//       textColor: onPrimary,
//     );
//   }
}

// class ExperimentOfContext extends StatelessWidget {
//   const ExperimentOfContext({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Experiment Of Context', style: context.titleTextStyle),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: context.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('displayMedium', style: context.displayMedium),
//               Text('displaySmall', style: context.displaySmall),
//               Text('headlineLarge', style: context.headlineLarge),
//               Text('headlineMedium', style: context.headlineMedium),
//               Text('titleLarge', style: context.titleLarge),
//               Text('titleMedium', style: context.titleMedium),
//               Text('titleSmall', style: context.titleSmall),
//               Text('labelLarge', style: context.labelLarge),
//               Text('bodySmall', style: context.bodySmall),
//               Text('titleTextStyle', style: context.titleTextStyle),
//               Text('bodyExtraSmall', style: context.bodyExtraSmall),
//               Text('bodyLarge', style: context.bodyLarge),
//               Text('dividerTextSmall', style: context.dividerTextSmall),
//               Text('dividerTextLarge', style: context.dividerTextLarge),
//               const SizedBox(height: 8.0),
//               ElevatedButton(
//                 onPressed: () => context.showToast('Toast'),
//                 child: const Text('Toast'),
//               ),
//               const SizedBox(height: 8.0),
//               ElevatedButton(
//                 onPressed: () => context.showSnackBar('SnackBar'),
//                 child: const Text('Show snack bar'),
//               ),
//               const SizedBox(height: 8.0),
//               ElevatedButton(
//                 onPressed: () => context.showBottomSheet(const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text('Bottom Sheet'))),
//                 child: const Text('Bottom Sheet'),
//               ),
//               const SizedBox(height: 8.0),
//               Text('width: ${context.width}'),
//               Text('height: ${context.height}'),
//               Container(
//                 height: 50.0,
//                 width: context.width,
//                 decoration: BoxDecoration(
//                   gradient: context.vertical,
//                 ),
//                 child: Text('Gradient and height: ${context.height}'),
//               ),
//               const SizedBox(height: 8.0),
//               Container(
//                 height: 50.0,
//                 width: context.width,
//                 decoration: BoxDecoration(
//                   gradient: context.horizontal,
//                 ),
//                 child: Text('Gradient and width: ${context.width}'),
//               ),
//               const SizedBox(height: 8.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
