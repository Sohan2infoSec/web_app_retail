package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import database.DatabaseService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import obj.Product;

/**
 *
 * @author Cpt_Snag
 */
@WebServlet(urlPatterns =
{
    "/ManageProduct"
})
public class ManageProduct extends HttpServlet
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
        //response.setContentType("text/html;charset=UTF-8");
        HttpSession ss = request.getSession();
        if (ss.getAttribute("admin") != null)
        {
            response.sendRedirect("manage.jsp");
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        DatabaseService dbs = new DatabaseService();

        if (request.getParameter("add_product") != null)
        {

            String pName = request.getParameter("pName");
            //StockNum and Price are int so we need to catch
            Integer pStockNum = null;
            try
            {
                pStockNum = Integer.parseInt(request.getParameter("pStockNum"));
            }
            catch (NumberFormatException ex)
            {
                dispatcherErr(request, response);
            }
            Integer pPrice = null;
            try
            {
                pPrice = Integer.parseInt(request.getParameter("pPrice"));
            }
            catch (NumberFormatException ex)
            {
                dispatcherErr(request, response);
            }
            //End --- StockNum and Price are int so we need to catch

            String pCategory = request.getParameter("pCategory");
            String pImage = request.getParameter("pImage");
            String pDesc = request.getParameter("pDesc");

            //System.out.println("[+] Des : " + pPrice);
            if (pName == null || pName.equals(""))
            {
                response.sendRedirect("pErr.jsp");
            }
            else if (pImage == null || pImage.equals(""))
            {
                response.sendRedirect("pErr.jsp");
            }
            else
            {
                Product p = new Product(pName, pPrice, pStockNum, "img/" + pImage, pCategory, pDesc);
                try
                {
                    dbs.addProduct(p);
                }
                catch (SQLException ex)
                {
                    Logger.getLogger(ManageProduct.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect("manage.jsp");
            }

        }
        else if (request.getParameter("delete_product") != null)
        {
            Integer pid = Integer.parseInt(request.getParameter("delete_product"));
            try
            {
                dbs.deleteProduct(pid);
            }
            catch (SQLException ex)
            {
                Logger.getLogger(ManageProduct.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect("manage.jsp");
        }
        else if (request.getParameter("update_product") != null)
        {
            Integer pid = Integer.parseInt(request.getParameter("update_product"));

            String name = null;
            if (request.getParameter("name") != null && !request.getParameter("name").equals(""))
            {
                name = request.getParameter("name");
            }
            else
            {
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }

            Integer quantity = null;
            if (request.getParameter("quantity") != null && !request.getParameter("quantity").equals(""))
            {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            else
            {
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }

            Integer price = null;
            if (request.getParameter("price") != null && !request.getParameter("price").equals(""))
            {
                price = Integer.parseInt(request.getParameter("price"));
            }
            else
            {
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }

            String desc = null;
            if (request.getParameter("desc") != null)
            {
                desc = request.getParameter("desc");
            }
            else
            {
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }

            
            String img = request.getParameter("img");
            System.out.println("[+] FIRST IMAGE " + img);
            if (img.equals("") || img == null)
            {
                if (!response.isCommitted())
                {
                    response.sendRedirect("errorUser.jsp");
                }
            }
            else if (img != null)
            {
                img = "img/" + request.getParameter("img");
                System.out.println("[+] IMAGE PATH is " + img);
            }

            try
            {
                Product p = new Product(name, price, quantity, img, "", desc);
                dbs.updateProduct(p, pid);

//                PrintWriter out = response.getWriter();
//                out.println("<script type=\"text/javascript\">");
//                out.println("alert('User or password incorrect');");
//                out.println("</script>");
                if (!response.isCommitted())
                {
                    response.sendRedirect(request.getHeader("referer"));
                }
            }
            catch (SQLException ex)
            {
                Logger.getLogger(ManageProduct.class.getName()).log(Level.SEVERE, null, ex);
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

    public void dispatcherErr(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        RequestDispatcher dispatcher = request.getRequestDispatcher("pErr.jsp");
        dispatcher.forward(request, response);
    }
}
