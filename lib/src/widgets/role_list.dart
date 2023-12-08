import 'package:flutter/material.dart';

import '../data.dart';

class RoleList extends StatelessWidget {
  final List<Role> roles;
  final ValueChanged<Role>? onTap;

  const RoleList({
    required this.roles,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            roles[index].name,
          ),
          subtitle: Text(
            // '${roles[index].books.length} books',
            'pp'
          ),
          onTap: onTap != null ? () => onTap!(roles[index]) : null,
        ),
      );
}
