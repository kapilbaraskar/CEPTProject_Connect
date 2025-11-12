using System;

namespace BLL.Utilities1
{
    public class MasterFactory
    {
        public static ServerBase GenerateMasterObject(String ModuleName, String TransactionType)
        {
            switch (ModuleName)
            {
                case "S"://Generate Sales Master Object
                    return GenerateSalesMasterObject(TransactionType);
                case "F"://Generate Finance Master Object
                    return GenerateFinanceMasterObject(TransactionType);
                default:
                    return null;
            }           
        }

        private static ServerBase GenerateSalesMasterObject(String TransactionType)
        {
            switch (TransactionType)
            {
                //case Constant.TT_Menu_Master:
                //    return new MenuMst();
                //case Constant.TT_Company_Master_New:
                //    return new CompanyMst();
                //case Constant.TT_User_Master_New:
                //    return new UserMst();
                //case Constant.TT_Country_Master:
                //    return new CountryMst();
                //case Constant.TT_State_Master:
                //    return new StateMst();
                //case Constant.TT_City_Master:
                //    return new CityMst();
                //case Constant.TT_Patient_Master:
                //    return new PatientMst();
                //case Constant.TT_State_Sale_Rule:
                //    return new StateSaleRuleMst();
                default:
                    return null;
            }
        }

        private static ServerBase GenerateFinanceMasterObject(String TransactionType)
        {
            switch (TransactionType)
            {
                default:
                    return null;
            }
        }
    }
}