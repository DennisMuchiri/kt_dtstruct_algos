part of 'link_bloc.dart';


abstract class CampaignEvent extends Equatable {

  const CampaignEvent();

  @override
  List<Object> get props => [];

}

class FetchCampaigns extends CampaignEvent {
  const FetchCampaigns();

  @override
  List<Object> get props => [];
}

class AddCampaign extends CampaignEvent {
  const AddCampaign();

  @override
  List<Object> get props => [];
}