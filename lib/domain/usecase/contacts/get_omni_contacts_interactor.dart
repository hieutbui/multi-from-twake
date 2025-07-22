import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/contact/omni_contact_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/contact/get_contacts_state.dart';
import 'package:fluffychat/domain/repository/contact/omni_contact_repository.dart';

class GetOmniContactsInteractor {
  final OmniContactRepository _repository = getIt.get<OmniContactRepository>();

  GetOmniContactsInteractor();

  Stream<Either<Failure, Success>> execute({
    OmniContactStatus? status,
  }) async* {
    try {
      yield const Right(ContactsLoading());
      final response = await _repository.fetchContacts(
        status: status,
      );

      if (response.isEmpty) {
        yield const Left(GetContactsIsEmpty());
      } else {
        yield Right(GetContactsSuccess(contacts: response));
      }
    } catch (e) {
      yield Left(GetContactsFailure(keyword: '', exception: e));
    }
  }
}
