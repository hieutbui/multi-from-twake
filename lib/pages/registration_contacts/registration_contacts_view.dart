import 'package:fluffychat/pages/registration_contacts/registration_contacts.dart';
import 'package:fluffychat/pages/registration_contacts/registration_contracts_view_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';

class RegistrationContactsView extends StatelessWidget {
  final RegistrationContactsController controller;

  const RegistrationContactsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RegistrationContractsViewStyle.decoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const RegistrationAppBar(
          rightButtonText: 'Logout',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                Padding(
                  padding: RegistrationContractsViewStyle.padding,
                  child: Text(
                    'Find your contacts',
                    maxLines: null,
                    softWrap: true,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white.withAlpha(222),
                          fontSize: 34,
                        ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: RegistrationContractsViewStyle.padding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keep up with updates and chats from your friends and contacts',
                    style: TextStyle(
                      color:
                          Colors.white.withAlpha(153) /* Text-Main-Secondary */,
                      fontSize: 17,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
                const SizedBox(height: 90.0),
                Center(child: Image.asset(ImagePaths.imgRegistrationContacts)),
                const SizedBox(height: 44.0),
                const Padding(
                  padding: RegistrationContractsViewStyle.padding,
                  child: MultiRegistrationButton(
                    label: 'Enable access',
                    type: MultiRegistrationButtonType.mainPrimaryDefault,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Padding(
                  padding: RegistrationContractsViewStyle.padding,
                  child: MultiRegistrationButton(
                    label: 'Not right now',
                    type: MultiRegistrationButtonType.mainSecondaryDefault,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
