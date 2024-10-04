class DistrictDropListModel{
  String district;
  String state;

  DistrictDropListModel(this.state,this.district);
}

class AssemblyDropListModel{
  String district;
  String assembly;
  String state;

  AssemblyDropListModel(this.state,this.district,this.assembly);
}

class AssemblyTotalModel{
  double amount;
  String district;
  String assembly;
  String state;

  AssemblyTotalModel(this.amount,this.state,this.district,this.assembly);
}