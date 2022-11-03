part of 'link_bloc.dart';

abstract class CampaignState extends Equatable{

  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignEmpty extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<Link> campaignModel;

  const CampaignLoaded({@required this.campaignModel}) : assert(campaignModel != null);

  @override
  List<Object> get props => [campaignModel];
}

class CampaignError extends CampaignState {}