namespace scp.cloud;

using {
  cuid,
  managed,
  sap.common
} from '@sap/cds/common';

entity User {
  key userID       : String(10)               @title : 'UserID';
      name         : String(50)               @title : 'Name';
      password     : String(50)               @title : 'Password';
      userType     : String(50)               @title : 'UserType';
      associatedCharity: Association to many User2Charity on associatedCharity.user = $self;
      //assignedUser : Association to many Charity on assignedUser.assignedCharity = userID;
}


entity User2Charity {
  key user : Association to User;
  key charity : Association to Charity;
}


entity Charity {
  key charityID : String(10) @title : 'CharityID';
      name      : String(50) @title : 'Name';
      address : String(100) @title : 'Address';
      // assignedCharity: Association to User;
      associatedUser: Association to many User2Charity on associatedUser.charity = $self;
      regions: Association to many Region on regions.associatedRegion = $self;
}

entity CharityRegion {
  key charityID : Association to Charity  @title : 'CharityID';
  key regionID      : Association to Region  @title : 'RegionID';
      //associatedChairityRegion: Association to Region on associatedChairityRegion.associatedRegion = $self;
}

entity Region {
  key regionID  : String(10) @title : 'RegionID';
      name      : String(50) @title : 'Name';
      associatedRegion: Association to Charity;
}




entity Beneficiary : managed {
  key beneficiaryID       : String(10) @title : 'BeneficiaryID';
  regionID                : String(50) @title : 'RegionID';
  address                 : String(50) @title: 'Adddress';
  householdSize           : Integer @title: 'HouseholdSize';
  perCapitalIncome        : Decimal(10,3) @title : 'PerCapitalIncome';
  religion                : String(50) @title : 'Religion';
  race                    : String(50) @title : 'Race';
  numWorkingAdults        : Integer @title : 'NumWorkingAdults';
  noOfChildren            : Integer @title : 'NoOfChildren';
  dietaryRestrictions    : String(50) @title : 'DietaryRestrictionns';

}

entity BeneficiaryStock : managed {
  key beneficiaryID : Association to Beneficiary  @title : 'BeneficiaryID';
      stockID      : Association to Stock @title : 'StockID';
      stockCount: Integer @title : 'StockCount';
}

entity Stock : managed {
  key stockID           : String(10) @title : 'StockID';
      name      : String(50) @title : 'Name';
      category  : Association to StockType  @title : 'StockType';
}

entity Schedule : managed {
  key scheduleID      : String(10) @title : 'ScheduleID';
  Date                : Date       @title : 'Date';
  startTime           : String(50) @title : 'StartTime';
  userID              : String(50) @title:  'UserID';
  charityID           : Integer    @title: 'ChairityID';
  stockID             : Integer    @title : 'StockID';
  stockQuantity       : String(50) @title : 'StockQuantity';
  deliverStatus       : String(50) @title : 'DeliverStatus';
}

/**
  codelists
 */

entity StockCodeList : common.CodeList {
  key code : String(20);
}

entity StockType : StockCodeList {}

// entity UserCodeList : common.CodeList {
//   key code : String(20);
// }

// entity UserTypes : UserCodeList {}