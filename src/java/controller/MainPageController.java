/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.DatabaseService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import obj.Comment;
import obj.Product;
import ultilities.SessionService;

/**
 *
 * @author Cpt_Snag
 */
@WebServlet(name = "MainPageController", urlPatterns =
{
    "/mainpage"//Alias of Action
})
public class MainPageController extends HttpServlet
{

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        response.sendRedirect("index.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if (request.getParameterMap().containsKey("p"))
        {
            String path = request.getParameter("p");
            if (path != null)
            {
                //System.out.println("[+] Okie PATH: " + path);
                RequestDispatcher dispatcher = request.getRequestDispatcher("single_product.jsp");
                dispatcher.forward(request, response);
            }
        }
        else
        {
            processRequest(request, response);
        }
        //processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        DatabaseService dbs = new DatabaseService();
        SessionService ss = new SessionService(request.getSession());
        if (request.getParameter("add_to_cart") != null)
        {
            Integer pid = Integer.parseInt(request.getParameter("add_to_cart"));

            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            //System.out.println("QUantity is " + quantity);
            try
            {
                Product p = dbs.getProductById(pid);
                p.setpStockNum(quantity);

                if (p != null)
                {
                    ss.addCart(p);
                }
            }
            catch (SQLException ex)
            {
                Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
            }

//            RequestDispatcher rd = request.getRequestDispatcher("product.jsp?p=" + pid);
//            rd.forward(request, response);
            response.sendRedirect("product.jsp?p=" + pid);
        }
        else if (request.getParameter("remove_cart") != null)
        {
            Integer pid = Integer.parseInt(request.getParameter("remove_cart"));

            try
            {
                Product p = dbs.getProductById(pid);

                if (p != null)
                {
                    ss.removeItemFromCart(pid, ss.getCart());
                    //response.sendRedirect("cart.jsp");
                    response.sendRedirect(request.getHeader("referer"));
                }
            }
            catch (SQLException ex)
            {
                Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (request.getParameter("logout") != null)
        {
            HttpSession hs = request.getSession(false);
            hs.invalidate();
            response.sendRedirect("index.jsp");
        }
        else if (request.getParameter("order") != null)
        {
            Integer uid = (Integer) ss.getAtt("user");
            Integer pid = null;

            String name = request.getParameter("cname");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String desc = request.getParameter("desc");
        }
        else if (request.getParameter("search") != null)
        {
            String keyword = request.getParameter("item_search");

            if (keyword == null || keyword.trim().equals("") || ultilities.Ultilities.hasSpecialChar(keyword))
            {
                response.sendRedirect("wrong.html");
            }
            else if (request.getParameter("cat") != null)
            {
                String cat = request.getParameter("cat");
                response.sendRedirect("index.jsp?cat=" + cat + "&key=" + keyword);
            }
            else
            {
                response.sendRedirect("index.jsp?key=" + keyword);
            }
        }
        else if (request.getParameter("add_comment") != null)
        {
            String comment = request.getParameter("comment");
            String date = ultilities.Ultilities.getDateFormatUser();
            Integer pid = Integer.parseInt(request.getParameter("add_comment"));
            String email = (String) ss.getAtt("mail");

            if (comment == null || comment.trim().equals("") || ultilities.Ultilities.hasSpecialChar(comment))
            {
                response.sendRedirect("wrong.html");
            }
            else
            {

                Comment c = new Comment(pid, email, comment, date, 0);
                try
                {
                    System.out.println("[+] In the TRy");
                    dbs.addComment(c);
                    response.sendRedirect(request.getHeader("referer"));
                }
                catch (SQLException ex)
                {
                    Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        else if (request.getParameter("upvote") != null)
        {
            Integer cid = Integer.parseInt(request.getParameter("upvote"));
            String mail = (String) ss.getAtt("mail");

            try
            {
                if (!dbs.didVote(cid, mail, "upvote"))
                {
                    try
                    {
                        dbs.upvote(cid, mail);
                    }
                    catch (SQLException ex)
                    {
                        Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            catch (SQLException ex)
            {
                Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect(request.getHeader("referer"));
        }
        else if (request.getParameter("downvote") != null)
        {
            Integer cid = Integer.parseInt(request.getParameter("downvote"));
            String mail = (String) ss.getAtt("mail");

            try
            {
                if (!dbs.didVote(cid, mail, "downvote"))
                {
                    try
                    {
                        dbs.downvote(cid, mail);
                    }
                    catch (SQLException ex)
                    {
                        Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            catch (SQLException ex)
            {
                Logger.getLogger(MainPageController.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect(request.getHeader("referer"));
        }
    }

    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>

}
