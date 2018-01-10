/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ultilities;

import javax.servlet.http.*;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author junnguyen
 */
public class CookieService {

    private HttpServletRequest request;
    private HttpServletResponse response;

    public CookieService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }

    public void storeCookie(String name, String value, Integer timeout)
    {
        Cookie c = new Cookie(name, value);
        c.setMaxAge(timeout);
        response.addCookie(c);
    }
    
    public void storeCookieName(String firstName, String lastName) {
        Cookie c = new Cookie("myName", firstName + " " + lastName);
        c.setMaxAge(60 * 60 * 24 * 7);
        response.addCookie(c);

    }

    public String getCookieName(String name) {

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }

        return null;
    }

}
