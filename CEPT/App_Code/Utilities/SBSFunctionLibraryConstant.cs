using System;
using System.Collections.Generic;
using System.Text;

/// <summary>
/// Summary description for SBSFunctionLibraryConstant
/// </summary>
public class SBSFunctionLibraryConstant
{
	public SBSFunctionLibraryConstant()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    #region General purpose Constants
    public const int FontSize = -9;
    public const String ITEM_TYPE_NORMAL = "N";
    public const String ITEM_TYPE_PHYSICIAN_SAMPLE = "PS";
    public const String ITEM_TYPE_PRAMOTION_ARTICLE = "PA";
    public const String CUSTOMER_ORDER_PS_PA = "COP";

    //Doc Type
    public const String PS_PA_ORDER_DOC_TYPE = "OPSPA";
    public const String GOODS_RECEIPT_PHYSICIAN_SAMPLE_DOC_TYPE = "GR002";
    public const String GOODS_RECEIPT_PRAMOTION_ARTICLE_DOC_TYPE = "GR003";
    #endregion
}