/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.DatabaseService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import obj.Order;
import obj.Product;
import ultilities.SessionService;

/**
 *
 * @author Cpt_Snag
 */
@WebServlet(name = "OrderController", urlPatterns =
{
    "/order"
})
public class OrderController extends HttpServlet
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
        HttpSession ss = request.getSession();
        if (ss.getAttribute("user") == null && ss.getAttribute("admin") == null)
        {
            response.sendRedirect("login.jsp");
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if (request.getParameter("order") != null)
        {
            SessionService ss = new SessionService(request.getSession());
            DatabaseService dbs = new DatabaseService();

            String uid = (String) ss.getAtt("mail");
            Integer pid = 0;

            Date orderDate = new Date();
            Date rcvDate = new Date();

            String name = null;

            if (request.getParameter("cname") == null || request.getParameter("cname").trim().equals(""))
            {
                System.out.println("[+] USER 1");
//                RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                dispatcher.forward(request, response);
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }
            else if (ultilities.Ultilities.hasSpecialChar(request.getParameter("cname")))
            {
                System.out.println("[+] USER 2");
                if (!response.isCommitted())
                {
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                    dispatcher.forward(request, response);
                    response.sendRedirect("wrong.html");
                }
            }
            else //if (request.getParameter("cname") != null && !request.getParameter("cname").trim().equals(""))
            {
                System.out.println("[+] USER 3");
                name = request.getParameter("cname");
            }

            String address = null;

            if (request.getParameter("address") == null || request.getParameter("address").trim().equals(""))
            {
                if (!response.isCommitted())
                {
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                    dispatcher.forward(request, response);
                    response.sendRedirect("errorUser.jsp");
                }
            }
            else if (ultilities.Ultilities.hasSpecialChar(request.getParameter("address")))
            {
                if (!response.isCommitted())
                {
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                    dispatcher.forward(request, response);
                    response.sendRedirect("wrong.html");
                }
            }
            else if (request.getParameter("address") != null && !request.getParameter("address").trim().equals(""))
            {
                address = request.getParameter("address");
            }

            String phone = null;
            if (request.getParameter("phone") == null || request.getParameter("phone").trim().equals(""))
            {
                if (!response.isCommitted())
                {
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                    dispatcher.forward(request, response);
                    response.sendRedirect("errorUser.jsp");

                }
            }
            else if (ultilities.Ultilities.hasSpecialChar(request.getParameter("phone")))
            {
                if (!response.isCommitted())
                {
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorUser.jsp");
//                    dispatcher.forward(request, response);
                    response.sendRedirect("wrong.html");
                }
            }
            else if (request.getParameter("phone") != null && !request.getParameter("phone").trim().equals(""))
            {
                phone = request.getParameter("phone");
            }

            String desc = null;
            if (request.getParameter("desc") != null && request.getParameter("desc").trim() == "")
            {
                desc = request.getParameter("desc");
            }

            Integer quantity = 0;
            Integer sent = 0;

            ArrayList<Product> cart = ss.getCart();
            if (cart == null)
            {
                if (!response.isCommitted())
                {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request, response);
                }
//              
            }
            else
            {
                for (Product p : cart)
                {
                    Order o = new Order(p.getpID(), uid, ss.getCartTotal(), orderDate, rcvDate, name, address, phone, desc, p.getpStockNum(), sent);
                    try
                    {
                        dbs.addOrder(o);
                        if (!response.isCommitted())
                        {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("success.jsp");
                            dispatcher.forward(request, response);
                        }
                    }
                    catch (SQLException ex)
                    {
                        Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
        else if (request.getParameter("deliver") != null)
        {
            String email = request.getParameter("email");
            String date = request.getParameter("date");
            System.out.println(date);
            DatabaseService dbs = new DatabaseService();
            try
            {
                dbs.deliverOrder(email, date);
                response.sendRedirect(request.getHeader("referer"));
            }
            catch (SQLException ex)
            {
                Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>

}
