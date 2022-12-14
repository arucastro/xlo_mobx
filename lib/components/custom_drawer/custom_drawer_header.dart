import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../screens/login/login_screen.dart';

class CustomDrawerHeader extends StatelessWidget {
  CustomDrawerHeader({Key? key}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if (userManagerStore.isUserLogged) {
          userManagerStore.logout();
          //GetIt.I<PageStore>().setPage(4);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
          );
        }
      },
      child: Container(
        color: Colors.purple,
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userManagerStore.isUserLogged
                        ? userManagerStore.user!.name!
                        : 'Acesse sua conta!',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    userManagerStore.isUserLogged
                        ? userManagerStore.user!.email!
                        : 'Clique aqui.',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  if (userManagerStore.isUserLogged) const Icon(Icons.logout, color: Colors.white, size: 25,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
