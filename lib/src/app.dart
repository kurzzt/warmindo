import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:warung_sample/src/data/userHandler.dart';
import 'package:warung_sample/src/screens/add_user.dart';
import 'package:warung_sample/src/screens/edit_user.dart';
import 'package:warung_sample/src/screens/user_details.dart';
import 'package:warung_sample/src/screens/users.dart';
import 'package:warung_sample/src/screens/roles.dart';

import 'auth.dart';
import 'data.dart';
import 'screens/author_details.dart';
import 'screens/authors.dart';
import 'screens/book_details.dart';
import 'screens/books.dart';
import 'screens/scaffold.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'widgets/book_list.dart';
import 'widgets/fade_transition_page.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final booksNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'books shell');

class Warung extends StatefulWidget {
  const Warung({super.key});

  @override
  State<Warung> createState() => _WarungState();
}

class _WarungState extends State<Warung> {
  final WarungAuth auth = WarungAuth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return WarungAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: GoRouter(
        refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/books/popular',
        redirect: (context, state) {
          final signedIn = WarungAuth.of(context).signedIn;
          if (state.uri.toString() != '/sign-in' && !signedIn) {
            return '/sign-in';
          }
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return WarungScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/books') => 0,
                  var p when p.startsWith('/authors') => 1,
                  var p when p.startsWith('/roles') => 2,
                  var p when p.startsWith('/settings') => 3,
                  var p when p.startsWith('/users') => 4,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    // Use a builder to get the correct BuildContext
                    // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                    child: Builder(builder: (context) {
                      return BooksScreen(
                        onTap: (idx) {
                          GoRouter.of(context).go(switch (idx) {
                            0 => '/books/popular',
                            1 => '/books/new',
                            2 => '/books/all',
                            _ => '/books/popular',
                          });
                        },
                        selectedIndex: switch (state.uri.path) {
                          var p when p.startsWith('/books/popular') => 0,
                          var p when p.startsWith('/books/new') => 1,
                          var p when p.startsWith('/books/all') => 2,
                          _ => 0,
                        },
                        child: child,
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/books/popular',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return BookList(
                              books: libraryInstance.popularBooks,
                              onTap: (book) {
                                GoRouter.of(context)
                                    .go('/books/popular/book/${book.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'book/:bookId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return BookDetailsScreen(
                            book: libraryInstance
                                .getBook(state.pathParameters['bookId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/books/new',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        child: Builder(
                          builder: (context) {
                            return BookList(
                              books: libraryInstance.newBooks,
                              onTap: (book) {
                                GoRouter.of(context)
                                    .go('/books/new/book/${book.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'book/:bookId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return BookDetailsScreen(
                            book: libraryInstance
                                .getBook(state.pathParameters['bookId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/books/all',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        child: Builder(
                          builder: (context) {
                            return BookList(
                              books: libraryInstance.allBooks,
                              onTap: (book) {
                                GoRouter.of(context)
                                    .go('/books/all/book/${book.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'book/:bookId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return BookDetailsScreen(
                            book: libraryInstance
                                .getBook(state.pathParameters['bookId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: '/authors',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return AuthorsScreen(
                        onTap: (author) {
                          GoRouter.of(context)
                              .go('/authors/author/${author.id}');
                        },
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'author/:authorId',
                    builder: (context, state) {
                      final author = libraryInstance.allAuthors.firstWhere(
                          (author) =>
                              author.id ==
                              int.parse(state.pathParameters['authorId']!));
                      // Use a builder to get the correct BuildContext
                      // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                      return Builder(builder: (context) {
                        return AuthorDetailsScreen(
                          author: author,
                          onBookTapped: (book) {
                            GoRouter.of(context)
                                .go('/books/all/book/${book.id}');
                          },
                        );
                      });
                    },
                  )
                ],
              ),
              GoRoute(
                path: '/roles',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: RolesScreen(),
                  );
                },
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const SettingsScreen(),
                  );
                },
              ),
              GoRoute(
                  path: '/users',
                  pageBuilder: (context, state) {
                    return FadeTransitionPage<dynamic>(
                      key: state.pageKey,
                      child: Builder(builder: (context) {
                        return UsersScreen(
                          onTap: (user) {
                            GoRouter.of(context)
                            .go('/users/${user['id']}', extra: user);
                          },
                          onTapUpdate: (user) {
                            GoRouter.of(context)
                            .go('/users/${user['id']}/edit', extra: user);
                          },
                        );
                        }
                      )
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'add',
                      builder: (context, state) {
                        return Builder(builder: (context) {
                          return AddUserScreen();
                        });
                      }
                    ),
                    GoRoute(
                      path: ':userId',
                      builder: (context, state) {
                        final Object user = GoRouterState.of(context).extra!;
                        return Builder(builder: (context) {
                          return UserDetailsScreen(
                            user: user
                          );
                        });
                      }
                    ),
                    GoRoute(
                      path: ':userId/edit',
                      builder: (context, state) {
                        final Object user = GoRouterState.of(context).extra!;
                        return Builder(builder: (context) {
                          return EditUserScreen(
                            user: user
                          );
                        });
                      }
                    )
                  ]),
            ],
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              // Use a builder to get the correct BuildContext
              // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
              return Builder(
                builder: (context) {
                  return SignInScreen(
                    onSignIn: (value) async {
                      final router = GoRouter.of(context);
                      await WarungAuth.of(context)
                          .signIn(value.username, value.password);
                      router.go('/books/popular');
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
