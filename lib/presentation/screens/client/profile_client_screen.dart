import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/client/client_orders_screen.dart';
import 'package:restaurant/presentation/screens/intro/checking_login_screen.dart';
import 'package:restaurant/presentation/screens/profile/change_password_screen.dart';
import 'package:restaurant/presentation/screens/profile/edit_Prodile_screen.dart';
import 'package:restaurant/presentation/screens/profile/list_addresses_screen.dart';

class ProfileClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          modalLoading(context);
        } else if (state is SuccessAuthState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'Picture Change Successfully',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: ProfileClientScreen())));
          Navigator.pop(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              const SizedBox(height: 20.0),
              // Align(alignment: Alignment.center, child: ImagePickerFrave()),
              const SizedBox(height: 20.0),
              Center(
                  child: TextCustom(
                      text: authBloc.state.user!.firstName +
                          ' ' +
                          authBloc.state.user!.lastName,
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 5.0),
              Center(
                  child: TextCustom(
                      text: authBloc.state.user!.email,
                      fontSize: 20,
                      color: Colors.grey)),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Conta', color: Colors.grey),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Configurações de Perfil',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.push(
                    context, routeFrave(page: EditProfileScreen())),
              ),
              ItemAccount(
                text: 'Alterar Senha',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ChangePasswordScreen())),
              ),
              ItemAccount(
                text: 'Adicionar Endereço',
                icon: Icons.my_location_rounded,
                colorIcon: 0xffFB5019,
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ListAddressesScreen())),
              ),
              ItemAccount(
                text: 'Solicitações de Serviços',
                icon: Icons.shopping_bag_outlined,
                colorIcon: 0xffFBAD49,
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ClientOrdersScreen())),
              ),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Pessoal', color: Colors.grey),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Políticas & Privacidade',
                icon: Icons.policy_rounded,
                colorIcon: 0xff6dbd63,
              ),
              ItemAccount(
                text: 'Segurança',
                icon: Icons.lock_outline_rounded,
                colorIcon: 0xff1F252C,
              ),
              ItemAccount(
                text: 'Termos & Condições',
                icon: Icons.description_outlined,
                colorIcon: 0xff458bff,
              ),
              ItemAccount(
                text: 'Ajuda',
                icon: Icons.help_outline,
                colorIcon: 0xff4772e6,
              ),
              const TextCustom(text: '', color: Colors.grey),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Sair',
                icon: Icons.power_settings_new_sharp,
                colorIcon: 0xffF02849,
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(
                      context,
                      routeFrave(page: CheckingLoginScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationFrave(3),
      ),
    );
  }
}
