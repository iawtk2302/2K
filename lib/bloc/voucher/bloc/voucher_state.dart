part of 'voucher_bloc.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();
  
  @override
  List<Object> get props => [];
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherLoaded extends VoucherState {
  const VoucherLoaded(this.vouchers);
  final List<Voucher> vouchers;
}
