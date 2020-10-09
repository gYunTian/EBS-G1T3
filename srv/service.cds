using scp.cloud from '../db/schema';

service api {
    // entity UserDetails as select from cloud.User u join cloud.User2Charity uc on u.associatedCharity = uc.user { 
    //    u.userID, u.name, u.password, u.userType, uc.charity
    // };

    // view test as select from cloud.User u, cloud.User2Charity uc {
    //     u.userID, u.name, uc.charity
    // } where u.userID = uc.user;

    //entity UserChairity as projection on cloud.UserChairity;

    entity User as projection on cloud.User;
    entity User2Charity as projection on cloud.User2Charity;
    entity Charity as projection on cloud.Charity;

    entity CharityRegion as projection on cloud.CharityRegion;
    entity Region as projection on cloud.Region;
    entity Beneficiary as projection on cloud.Beneficiary;
    entity BeneficiaryStock as projection on cloud.BeneficiaryStock;
    entity Stock as projection on cloud.Stock;
    entity Schedule as projection on cloud.Schedule;
}

//select * from user inner join userCharity on user.userid = usercharity.userid
