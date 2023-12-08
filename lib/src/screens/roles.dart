import 'package:flutter/material.dart';
import 'package:warung_sample/src/data.dart';
// import 'package:warung_sample/src/data/Roles.dart';

import '../widgets/author_list.dart';

class RolesScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Author> onTap;

  const RolesScreen({
    required this.onTap,
    this.title = 'Roles',
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: AuthorList(
          authors: libraryInstance.allAuthors,
          onTap: onTap,
        ),
      );
}
