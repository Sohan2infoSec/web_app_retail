/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package obj;

/**
 *
 * @author Cpt_Snag
 */
public class Product
{
    private Integer pID;
    private String pName;
    private Integer pPrice;
    private Integer pStockNum;
    private String pImage;
    private String pCategory;
    private String pDescription;

    public Product()
    {
    }

    public Product(String pName, Integer pPrice, Integer pStockNum, String pImage, String pCategory, String pDescription)
    {
        this.pName = pName;
        this.pPrice = pPrice;
        this.pStockNum = pStockNum;
        this.pImage = pImage;
        this.pCategory = pCategory;
        this.pDescription = pDescription;
    }
    
    public Product(Integer pid, String pName, Integer pPrice, Integer pStockNum, String pImage, String pCategory, String pDescription)
    {
        this.pID = pid;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pStockNum = pStockNum;
        this.pImage = pImage;
        this.pCategory = pCategory;
        this.pDescription = pDescription;
    }
    
    public Integer getpID()
    {
        return pID;
    }

    public String getpName()
    {
        return pName;
    }

    public Integer getpPrice()
    {
        return pPrice;
    }

    public Integer getpStockNum()
    {
        return pStockNum;
    }

    public String getpImage()
    {
        return pImage;
    }

    public String getpCategory()
    {
        return pCategory;
    }

    public String getpDescription()
    {
        return pDescription;
    }

    public void setpID(Integer pID)
    {
        this.pID = pID;
    }

    public void setpName(String pName)
    {
        this.pName = pName;
    }

    public void setpPrice(Integer pPrice)
    {
        this.pPrice = pPrice;
    }

    public void setpStockNum(Integer pStockNum)
    {
        this.pStockNum = pStockNum;
    }

    public void setpImage(String pImage)
    {
        this.pImage = pImage;
    }

    public void setpCategory(String pCategory)
    {
        this.pCategory = pCategory;
    }

    public void setpDescription(String pDescription)
    {
        this.pDescription = pDescription;
    }
    
    
}
