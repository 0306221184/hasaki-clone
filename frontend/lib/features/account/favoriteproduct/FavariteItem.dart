// import 'package:flutter/material.dart';
//
// class FavariteItem extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final int price;
//   final double rating;
//   final String description;
//   final VoidCallback onRemove;
//
//   const FavariteItem({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.description,
//     required this.onRemove,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Image.network(
//                   imageUrl,
//                   height: 100,
//                   width: 100,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(width: 8), // Add some space between image and text
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.dangerous_outlined, color: Colors.grey),
//                             onPressed: onRemove,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         '$price đ',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Rating: $rating',
//                         style: const TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
