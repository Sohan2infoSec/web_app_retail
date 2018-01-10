package controller;

import database.DatabaseService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ultilities.SessionService;

/**
 *
 * @author Cpt_Snag
 */
@WebServlet(urlPatterns =
{
    "/LoginHandler"
})
public class LoginHandler extends HttpServlet
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
//        response.setContentType("text/html;charset=UTF-8");
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
        //processRequest(request, response);
        if (request.getParameter("login") != null)
        {
            String tmpEmail = request.getParameter("email");
            String tmpPasswd = request.getParameter("password");
            if (tmpEmail == null || tmpEmail.equals("") || tmpPasswd == null || tmpPasswd.equals(""))
            {
                response.sendRedirect("errorUser.jsp");
            }
            else
            {
                tmpPasswd = ultilities.Ultilities.getMD5(request.getParameter("password"));
                //System.out.println("[+] Knock Knock POST!");
                DatabaseService dbs = new DatabaseService();
                tmpEmail = tmpEmail.toLowerCase();
                //Get Passwd from DB
                String realPasswd = null;
                try
                {
                    realPasswd = dbs.getPassword(tmpEmail);
                }
                catch (SQLException ex)
                {
                    Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
                //END --- Get Passwd from DB

                System.out.println("[-] Pass is " + realPasswd);
                if (realPasswd != null && tmpPasswd.equals(realPasswd))
                {
                    //Add session for admin
                    SessionService ss = new SessionService(request.getSession());

                    if (tmpEmail.equals("admin"))
                    {
                        response.sendRedirect("index.jsp");
                        //HttpSession sess = request.getSession();
                        //response.sendRedirect(request.getParameter("from"));
                        try
                        {
                            //sess.setAttribute("admin", dbs.getUID(tmpEmail));
                            ss.removeAtt("user");
                            ss.setAtt("admin", dbs.getUID(tmpEmail));
                            
                        }
                        catch (SQLException ex)
                        {
                            Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    else
                    {
                        response.sendRedirect("index.jsp");
                        try
                        {
                            ss.removeAtt("admin");
                            ss.setAtt("user", dbs.getUID(tmpEmail));
                            ss.setAtt("mail", tmpEmail);
                            //response.sendRedirect(request.getParameter("from"));
                        }
                        catch (SQLException ex)
                        {
                            Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    // Normal user
                    //System.out.println("IT WORKS WOOO HOOOOOOOOOO");
                    try (PrintWriter out = response.getWriter())
                    {
                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>Servlet LoginHandler</title>");
                        out.println("</head>");
                        out.println("<body>");
                        out.println("<h1>Correct!</h1>");
                        out.println("</body>");
                        out.println("</html>");
                    }

                }
                else
                {
                    System.out.println("NO NO NO NO NO NO NO");
                    try (PrintWriter out = response.getWriter())
                    {
                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>Servlet LoginHandler</title>"
                                + "<style>"
                                + "body"
                                + "{"
                                + "background: url(img/block.png) no-repeat 80% 0%"
                                + "}"
                                + "</style>");
                        out.println("</head>");
                        out.println("<body>");
                        out.println("<h1>Sorry! Your account does NOT EXIST or <br>it is BANNED!</h1>");
                        out.println("</body>");
                        out.println("</html>");
                    }
                }
            }
        }
        else if (request.getParameter("register") != null)
        {
            String passwd = request.getParameter("re_password");
            String rpasswd = request.getParameter("re_password0");
            String email = request.getParameter("re_email");

            if (passwd == null || rpasswd == null || passwd.equals("") || rpasswd.equals(""))
            {
                try (PrintWriter out = response.getWriter())
                {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet LoginHandler</title>");
                    out.println("</head>");
                    out.println("<body>");
                    //out.println("<h1>Servlet LoginHandler at " + request.getContextPath() + "</h1>");
                    out.println("<h1>You need to enter password and re-password correctly!</h1>");
                    out.println("</body>");
                    out.println("</html>");
                }
            }
            else if (!passwd.equals(rpasswd))
            {
                try (PrintWriter out = response.getWriter())
                {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet LoginHandler</title>");
                    out.println("</head>");
                    out.println("<body>");
                    //out.println("<h1>Servlet LoginHandler at " + request.getContextPath() + "</h1>");
                    out.println("<h1>Your password doesn't match!</h1>");
                    out.println("</body>");
                    out.println("</html>");
                }
            }
            else
            {
                DatabaseService dbs = new DatabaseService();
                email = email.toLowerCase();
                try
                {
                    if (!dbs.isExist(email))
                    {
                        String hashPass = ultilities.Ultilities.getMD5(passwd);
                        dbs.addUser(email, hashPass, 1);
                        PrintWriter out = response.getWriter();
                        
                        SessionService ss = new SessionService(request.getSession());
                        ss.removeAtt("admin");
                        ss.setAtt("user", dbs.getUID(email));
                        ss.setAtt("mail", email);
                        
                        response.sendRedirect("index.jsp");
                    }
                    else
                    {
                        try (PrintWriter out = response.getWriter())
                        {
                            out.println("<!DOCTYPE html>");
                            out.println("<html>");
                            out.println("<head>");
                            out.println("<title>Servlet LoginHandler</title>");
                            out.println("</head>");
                            out.println("<body style=\"background: url(img/sorry.jpg) no-repeat 50% -50%;\">");
                            //out.println("<h1>Servlet LoginHandler at " + request.getContextPath() + "</h1>");
                            out.println("<h1>Your email has been used! Please pick another Email!</h1>");
                            out.println("</body>");
                            out.println("</html>");
                        }
                    }
                }
                catch (SQLException ex)
                {
                    Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>

}
