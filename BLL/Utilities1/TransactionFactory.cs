using System;

namespace BLL.Utilities1
{
    public class TransactionFactory
    {
        public static ServerBase GenerateTransactionObject(String ModuleName, String TransactionType)
        {
            switch (ModuleName)
            {
                case "S"://Generate Sales Transaction Object					
                    return GenerateSalesTransactionObject(TransactionType);
                case "F"://Generate Finance Transaction Object
                    return GenerateFinanceTransactionObject(TransactionType);
                default:
                    return null;
            }            
        }

        private static ServerBase GenerateSalesTransactionObject(String TransactionType)
        {
            switch (TransactionType)
            {
                default:
                    return null;
            }
        }

        private static ServerBase GenerateFinanceTransactionObject(String TransactionType)
        {
            switch (TransactionType)
            {
                default:
                    return null;
            }
        }
    }
}