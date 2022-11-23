import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../model/voucher.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherInitial()) {
    on<LoadVoucher>((event, emit) async{
      emit(VoucherLoading());
      
     
    });
  }
}
