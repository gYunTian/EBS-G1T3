namespace scp.cloud;

type UserType : String enum {
  Volunteer;
  Admin;
  MSF;
}


entity Users {
  key userID    : UUID      @odata.Type : 'Edm.String'  @title : 'UserID';
      email     : String(50)@title      : 'Email';
      name      : String(50)@title      : 'Username';
      password  : String(50)@title      : 'Password';
      userType  : UserType  @title      : 'UserType';
      Charities : Association to many UsersCharities
                    on Charities.user = $self;
}

entity UsersCharities {
  key user    : Association to Users;
  key charity : Association to Charities;
}

entity Charities {
  key charityID : UUID       @odata.Type : 'Edm.String'  @title : 'CharityID';
      name      : String(50) @title      : 'CharityName';
      address   : String(100)@title      : 'Address';
      users     : Association to many UsersCharities
                    on users.charity = $self;
      // Regions   : Association to many CharitiesRegions
      //               on Regions.charity = $self;
}

// entity CharitiesRegions {
//   key charity : Association to Charities @title : 'Charity';
//   key region  : Association to Regions   @title : 'Region';
// }

//type RegionName : String enum {
//  North;
//  South;
//  East;
//  West;
//  central;
//  NorthEast;
//  NorthWest;
//  SouthEast;
//  SouthWest;
//}

entity Regions {
  key regionID  : UUID       @odata.Type : 'Edm.String'  @title : 'RegionID';
      name      : String(20) @title      : 'RegionName';
      // Charities : Association to many CharitiesRegions
      //               on Charities.region = $self;
}

type Religion : String enum {
  Buddhism;
  Christianity;
  Catholicism;
  Islam;
  Taoism;
  Hinduism;
  Sikhism;
  Others;
  None;
}

type Race : String enum {
  Chinese;
  Malay;
  Indian;
  Others;
}

entity Beneficiaries {
  key beneficiaryID       : UUID                       @odata.Type : 'Edm.String'  @title : 'BeneficiaryID';
      regionID            : Association to one Regions @title      : 'RegionID';
      address             : String(50)                 @title      : 'Adddress';
      householdSize       : Integer                    @title      : 'HouseholdSize';
      perCapitalIncome    : Decimal(10, 3)             @title      : 'PerCapitalIncome';
      religion            : Religion                   @title      : 'Religion';
      race                : Race                       @title      : 'Race';
      numWorkingAdults    : Integer                    @title      : 'NumWorkingAdults';
      noOfChildren        : Integer                    @title      : 'NoOfChildren';
      dietaryRestrictions : String(100)                @title      : 'DietaryRestrictions';
      Stocks              : Association to many BeneficiariesStocks
                              on Stocks.beneficiary = $self;
}

entity BeneficiariesStocks {
  key beneficiary : Association to Beneficiaries @title : 'Beneficiary';
  key stock       : Association to Stocks        @title : 'Stock';
      stockCount  : Integer                      @title : 'StockCount';
}

type Category : String enum {
  Vegetable;
  Fruit;
  MeatAndPoultry;
  Seafood;
  Dairy;
  Beverage;
  BreadOrBakery;
  Canned;
  Frozen;
  Instant;
  DryGoods;
  Grain;
}

entity Stocks {
  key stockID       : UUID      @odata.Type : 'Edm.String'  @title : 'StockID';
      name          : String(50)@title      : 'StockName';
      category      : Category  @title      : 'Category';
      Beneficiaries : Association to many BeneficiariesStocks
                        on Beneficiaries.stock = $self;
}

entity Schedules {
  key scheduleID : UUID                         @odata.Type : 'Edm.String'  @title : 'ScheduleID';
  key charity    : Association to one Charities @title      : 'Charity';
      date       : Date                         @title      : 'Date';
      startTime  : String(50)                   @title      : 'StartTime';
      Details    : Composition of many Tasks
                     on Details.parent = $self;
}

type DeliveryStatus : String enum {
  Completed;
  NotCompleted;
}

entity Tasks { // shall be accessed through Orders only
  key parent        : Association to Schedules;
  key volunteer     : Association to one Users;
  key beneficiary   : Association to one Beneficiaries;
      Food          : Composition of many FoodList
                        on Food.parent = $self;
      deliverStatus : DeliveryStatus @title : 'DeliveryStatus';
}

entity FoodList {
  key parent        : Association to Tasks;
  key stock         : Association to one Stocks;
      stockQuantity : Integer @title : 'StockQuantity';
}
