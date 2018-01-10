package ultilities;

import java.math.BigInteger;
import java.security.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Cpt_Snag
 */
public class Ultilities
{

    public static String getMD5(String a)
    {

        try
        {
            String plaintext = a;
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.reset();
            m.update(plaintext.getBytes());
            byte[] digest = m.digest();
            BigInteger bigInt = new BigInteger(1, digest);
            String hashtext = bigInt.toString(16);
            // Now we need to zero pad it if you actually want the full 32 chars.
            while (hashtext.length() < 32)
            {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
        catch (NoSuchAlgorithmException ex)
        {
            Logger.getLogger(Ultilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public static String getDateFormat()
    {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        // MMM dd, YYYY, h:mm a
        //DateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY, h:mm a");
        Date date = new Date();
        return dateFormat.format(date);
    }

    public static String getDateFormatUser()
    {
        DateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY, h:mm a");
        Date date = new Date();
        return dateFormat.format(date);
    }

    public static Boolean hasSpecialChar(String a)
    {
        if (a == null)
        {
            return false;
        }
        Pattern p = Pattern.compile("[@#$%&*()_+=|<>?{}\\\\[\\\\]~-]", Pattern.CASE_INSENSITIVE);
        //Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(a);
        Boolean b = m.find();

        return b;
    }

}
