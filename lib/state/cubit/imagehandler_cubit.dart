import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'imagehandler_state.dart';

class ImagehandlerCubit extends Cubit<ImagehandlerState> {
  ImagehandlerCubit() : super(ImagehandlerInitial());
}
