/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import obj.Comment;
import obj.Order;
import obj.OrderTemp;
import obj.Product;
import obj.User;

/**
 *
 * @author junnguyen
 */
public class DatabaseService
{

    private Connection conn;
    private PreparedStatement preparedStatement;

    public DatabaseService()
    {

        preparedStatement = null;
        conn = Connector.getConn();
        //System.out.println("[+] Conn is okie || " + conn);

    }

    //----------------START USER MANIPULATION-----------------\\
    public boolean isExist(String email) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.user WHERE email = ?;";

        try
        {

            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next())
            {
                //System.out.println("[+] RS has next");
                return true;
//                String tmp = rs.getString("email");
//                if (tmp == null)
//                    return false;
            }
        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
        return false;
    }

    public void addUser(String email, String passString, Integer active) throws SQLException
    {
        String sqlQuery = "INSERT INTO `mydb`.`user` "
                + "(`email`, `password`, `active`) "
                + "VALUES (?, ?, ?);";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, passString);
            preparedStatement.setInt(3, active);
            preparedStatement.executeUpdate();

        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public String getPassword(String email) throws SQLException
    {

        String sqlQuery = "SELECT * FROM mydb.user "
                + "WHERE email = ? AND active = 1";

        String passwd = null;
        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next())
            {
                passwd = rs.getString("password");
                //System.out.println("PASS IS " + passwd);
            }
        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
        return passwd;
    }

    public Integer getUID(String email) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.user WHERE email = ?";

        Integer uid = null;
        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next())
            {
                uid = rs.getInt("uid");
            }
        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
        return uid;
    }

    public User getUser(Integer uid) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.user WHERE uid = ?";
        User u = null;
        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, uid);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next())
            {
                Integer id = rs.getInt(1);
                String email = rs.getString(2);
                String hashPass = rs.getString(3);
                Integer active = rs.getInt(4);

                u = new User(uid, email, hashPass, active);
            }
        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
        return u;
    }

    public ArrayList<User> getAllUser() throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.user;";
        //+ "WHERE pStockNum <> 0 ;";
        ArrayList<User> uList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                Integer uid = rs.getInt(1);
                String email = rs.getString(2);
                String hashPass = rs.getString(3);
                Integer active = rs.getInt(4);

                User u = new User(uid, email, hashPass, active);
                uList.add(u);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return uList;
    }

    public void activeUser(Integer uid) throws SQLException
    {
        String sqlQuery = null;
        User u = getUser(uid);
        if (u.getActive() == 1)
        {
            sqlQuery = "UPDATE `mydb`.`user` "
                    + "SET `active`='0' "
                    + "WHERE `uid`= ?;";
        }
        else
        {
            sqlQuery = "UPDATE `mydb`.`user` "
                    + "SET `active`='1' "
                    + "WHERE `uid`= ?;";
        }

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setInt(1, uid);

            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }
    //----------------START USER MANIPULATION-----------------\\

    //----------------START PRODUCT MANIPULATION-----------------\\
    public void addProduct(Product p) throws SQLException
    {

        String sqlQuery = "INSERT INTO `mydb`.`product` "
                + "(`pName`, `pPrice`, `pStockNum`, `pCategory`, `pImage`, `pDesc`) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setString(1, p.getpName());
            preparedStatement.setInt(2, p.getpPrice());
            preparedStatement.setInt(3, p.getpStockNum());
            preparedStatement.setString(4, p.getpCategory());
            preparedStatement.setString(5, p.getpImage());
            preparedStatement.setString(6, p.getpDescription());

            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public void deleteProduct(Integer id) throws SQLException
    {

        String sqlQuery = "UPDATE `mydb`.`product` SET `pStockNum`='0' WHERE `pid`= ?";
        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setInt(1, id);

            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public void updateProduct(Product p, Integer pid) throws SQLException
    {
        String sqlQuery = "UPDATE `mydb`.`product` "
                + "SET `pName` = ?, `pPrice` = ?, `pStockNum` = ?, `pImage` = ?, `pDesc` = ? "
                + "WHERE `pid`= ?;";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setString(1, p.getpName());
            preparedStatement.setInt(2, p.getpPrice());
            preparedStatement.setInt(3, p.getpStockNum());
            preparedStatement.setString(4, p.getpImage());
            preparedStatement.setString(5, p.getpDescription());
            preparedStatement.setInt(6, pid);

            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public Product getProductById(Integer pid) throws SQLException
    {
        //String sqlQuery = "SELECT * FROM mydb.product "
        //        + "WHERE pid=?;";
        String sqlQuery = "SELECT * from `mydb`.`product` WHERE pid = ?;";
        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, pid);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                Integer id = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");
                //System.out.println("[+] PRICE IS: " + price);

                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                return p;
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return null;
    }

    public ArrayList<Product> getProductList() throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.product WHERE pStockNum <> 0;";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }

    public ArrayList<Product> getAllProductList() throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.product;";
        //+ "WHERE pStockNum <> 0 ;";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }

    public ArrayList<Product> getProductList(Integer n) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.product "
                + "WHERE pStockNum <> 0 "
                + "LIMIT ?;";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, n);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }

    public ArrayList<Product> getProductList(String cate, Integer n) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.product "
                + "WHERE pCategory=? AND pStockNum <> 0 "
                + "LIMIT ?;";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            if (n == 0)
            {
                preparedStatement.setInt(2, 10);
            }
            else
            {
                preparedStatement.setInt(2, n);
            }
            preparedStatement.setString(1, cate);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }

    public ArrayList<Product> getProductListByKeyword(String key) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.product "
                + "WHERE pName LIKE ? ESCAPE '!'";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, "%" + key + "%");

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }

    public ArrayList<Product> getProductListByKeyword(String key, String cat) throws SQLException
    {
        key = key
                .replace("!", "!!")
                .replace("%", "!%")
                .replace("_", "!_")
                .replace("[", "![");
        String sqlQuery = "SELECT * FROM mydb.product "
                + "WHERE pName LIKE ? ESCAPE '!' AND pCategory = ?";
        ArrayList<Product> productList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setString(1, "%" + key + "%");
            preparedStatement.setString(2, cat);
            System.out.println("[+] Pre " + preparedStatement);
            System.out.println("[+] Query " + sqlQuery);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("pName");
                Integer price = rs.getInt("pPrice");
                Integer quantity = rs.getInt("pStockNum");
                String category = rs.getString("pCategory");
                String imageURL = rs.getString("pImage");
                String description = rs.getString("pDesc");

                //System.out.println("[+] Desc Pro: " + description);
                Product p = new Product(pid, name, price, quantity, imageURL, category, description);
                productList.add(p);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return productList;
    }
    //----------------END PRODUCT MANIPULATION-----------------\\

    //----------------START COMMENT MANIPULATION-----------------\\
    public void addComment(Comment c) throws SQLException
    {
        String sqlQuery = "INSERT INTO `mydb`.`comment` "
                + "(`pid`, `cName`, `cComment`, `cDate`, `cLike`) "
                + "VALUES (?, ?, ?, ?, ?);";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, c.getPid());
            preparedStatement.setString(2, c.getEmail());
            preparedStatement.setString(3, c.getComment());
            preparedStatement.setString(4, c.getDate());
            preparedStatement.setInt(5, c.getLike());

            preparedStatement.executeUpdate();
            System.out.println("[+] EXECUTING COMMENT...");
        }

        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public ArrayList<Comment> getCommentByPID(Integer id) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.comment "
                + "WHERE pid = ?;";
        ArrayList<Comment> commentList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("cName");
                String comment = rs.getString("cComment");
                String date = rs.getString("cDate");
                Integer like = rs.getInt("cLike");
                Integer cid = rs.getInt("cid");
                Comment c = new Comment(pid, name, comment, date, like, cid);
                commentList.add(c);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return commentList;
    }

    public Comment getCommentByCID(Integer cid) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.comment "
                + "WHERE cid = ?;";
        Comment c = null;

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, cid);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                //System.out.println("[+] getProductList: ok");
                Integer pid = rs.getInt("pid");
                String name = rs.getString("cName");
                String comment = rs.getString("cComment");
                String date = rs.getString("cDate");
                Integer like = rs.getInt("cLike");

                c = new Comment(pid, name, comment, date, like, cid);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return c;
    }

    public void upvote(Integer cid, String email) throws SQLException
    {
        String sqlQuery1 = "UPDATE `mydb`.`comment` "
                + "SET `cLike`= `cLike` + 1 "
                + "WHERE cid = ?;";

        String sqlQuery2 = "INSERT INTO `mydb`.`comment_rates` "
                + "(`cid`, `cName`, `vote`) "
                + "VALUES (?, ?, 'upvote');";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery1);
            preparedStatement.setInt(1, cid);
            preparedStatement.executeUpdate();

            preparedStatement = conn.prepareStatement(sqlQuery2);
            preparedStatement.setInt(1, cid);
            preparedStatement.setString(2, email);
            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }

    }

    public void downvote(Integer cid, String email) throws SQLException
    {
        String sqlQuery1 = "UPDATE `mydb`.`comment` "
                + "SET `cLike`= `cLike` - 1 "
                + "WHERE cid = ?;";

        String sqlQuery2 = "INSERT INTO `mydb`.`comment_rates` "
                + "(`cid`, `cName`, `vote`) "
                + "VALUES (?, ?, 'downvote');";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery1);
            preparedStatement.setInt(1, cid);
            preparedStatement.executeUpdate();

            preparedStatement = conn.prepareStatement(sqlQuery2);
            preparedStatement.setInt(1, cid);
            preparedStatement.setString(2, email);
            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }

    }

    public Boolean didVote(Integer cid, String email, String vote) throws SQLException
    {
        String sqlQuery1 = "SELECT * FROM mydb.comment_rates "
                + "WHERE cid = ? AND cName = ? AND vote = ?;";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery1);
            preparedStatement.setInt(1, cid);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, vote);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                return true;
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return false;
    }

    //----------------END COMMENT MANIPULATION-----------------\\
    //----------------START ORDER MANIPULATION-----------------\\
    public void addOrder(Order o) throws SQLException
    {

        String sqlQuery = "INSERT INTO `mydb`.`order` "
                + "(`email`, `pid`,  `oTotal`, `oDate`, `oDateTransfer`, `oRcvName`, `oRcvAddress`, `oPhone`, `oDescription`, `oQuantity`, `oSending`) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setString(1, o.getUid());
            preparedStatement.setInt(2, o.getPid());
            preparedStatement.setDouble(3, o.getTotal());
            preparedStatement.setString(4, ultilities.Ultilities.getDateFormat());
            preparedStatement.setString(5, null);
            preparedStatement.setString(6, o.getName());
            preparedStatement.setString(7, o.getAddress());
            preparedStatement.setString(8, o.getPhone());
            preparedStatement.setString(9, o.getDescription());
            preparedStatement.setInt(10, o.getQuantity());
            preparedStatement.setInt(11, 0);

            preparedStatement.executeUpdate();
            System.out.println("[+] EXECUTING ORDER .....");
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {

            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }

        }
    }

    public ArrayList<OrderTemp> getOrderGroup(Integer isSent) throws SQLException
    {
        String sqlQuery = "SELECT distinct t1.email, t1.oDate, t1.oDateTransfer, t1.oRcvName, t1.oRcvAddress, t1.oPhone, t1.oDescription, t1.oTotal "
                + "FROM mydb.`order` t1, mydb.`order` t2 "
                + "WHERE t1.oDate <> t2.oDate and t1.oSending = ? "
                + "ORDER BY oDate;";

        ArrayList<OrderTemp> orderList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setInt(1, isSent);

            ResultSet rs = preparedStatement.executeQuery();
            System.out.println("[+] Executing OrderTmp...");
            while (rs.next())
            {
                String uid = rs.getString(1);
                String date = rs.getString(2);
                String deliverDate = rs.getString(3);
                String name = rs.getString(4);
                String address = rs.getString(5);
                String phone = rs.getString(6);
                String desc = rs.getString(7);
                Integer total = rs.getInt(8);

                OrderTemp o = new OrderTemp(uid, date, deliverDate, name, address, phone, desc, total);
                orderList.add(o);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return orderList;
    }

    public ArrayList<Order> getOrderByDetail(String u, String d) throws SQLException
    {
        String sqlQuery = "SELECT * FROM mydb.`order` "
                + "WHERE email = ? and oDate = ?;";
        ArrayList<Order> orderList = new ArrayList<>();

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setString(1, u);
            preparedStatement.setString(2, d);

            ResultSet rs = preparedStatement.executeQuery();
            //System.out.println("[+] Executing Detail...");
            while (rs.next())
            {
                Integer oid = rs.getInt(1);
                Integer pid = rs.getInt(3);
                String uid = rs.getString(2);
                Double total = rs.getDouble(4);

                Date dateOrder = rs.getDate(5);
                Date dateDelivery = rs.getDate(6);

                String name = rs.getString(7);
                String address = rs.getString(8);
                String phone = rs.getString(9);
                String description = rs.getString(10);

                Integer quantity = rs.getInt(11);
                Integer isSent = rs.getInt(12);
                Order o = new Order(oid, pid, uid, total, dateOrder, dateDelivery, name, address, phone, description, quantity, isSent);
                orderList.add(o);
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
        return orderList;
    }

    public void deliverOrder(String email, String oDate) throws SQLException
    {
        String sqlQuery = "UPDATE `mydb`.`order` "
                + "SET `oDateTransfer`= ?, `oSending`='1' "
                + "WHERE `oDate` = ? AND `email` = ?;";

        try
        {
            conn = Connector.createConnection();
            preparedStatement = conn.prepareStatement(sqlQuery);

            preparedStatement.setString(1, ultilities.Ultilities.getDateFormat());
            preparedStatement.setString(2, oDate);
            preparedStatement.setString(3, email);

            preparedStatement.executeUpdate();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DatabaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally
        {
            if (preparedStatement != null)
            {
                preparedStatement.close();
            }

            if (conn != null)
            {
                conn.close();
            }
        }
    }
}
