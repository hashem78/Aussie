import 'package:Aussie/interfaces/paginated.dart';
import 'package:Aussie/interfaces/paginated_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/paginated/common/paginated_screen_state.dart';

abstract class PaginatedScreenCubit<T extends PaginatedDataModel>
    extends Cubit<PaginatedScreenState> implements Pagniated<T> {
  PaginatedScreenCubit(PaginatedScreenState state) : super(state);
}
