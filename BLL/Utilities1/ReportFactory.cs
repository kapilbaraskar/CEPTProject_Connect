using System;

namespace BLL.Utilities1
{
    public class ReportFactory
    {
        public static ServerBase GenerateReportObject(String ModuleName, String TransactionType)
        {
            switch (ModuleName)
            {
                case "S"://Generate Sales Report Object
                    return GenerateSalesReportObject(TransactionType);
                case "F"://Generate Finance Report Object
                    return GenerateFinanceReportObject(TransactionType);    
                default:
                    return null;
            }
        }

        private static ServerBase GenerateSalesReportObject(String TransactionType)
        {
            switch (TransactionType)
            {
                default:
                    return null;
            }
        }

        private static ServerBase GenerateFinanceReportObject(String TransactionType)
        {
            switch (TransactionType)
            {
                default:
                    return null;
            }
        }
    }
}