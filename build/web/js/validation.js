/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validate(formName)
{
    var message = "";
    
    //Validate Email;
    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (!mailformat.test(formName.re_email.value))
    {
        message += "You have entered an invalid email address!\n";
        alert(message);
        //document.formName.email.focus();
        
        return false;
    }
    
    else if (formName.re_password0.value !== formName.re_password.value || formName.re_password.value.trim() === "")
    {
        //alert("here?");
        message += "Your password doesn't match.";
        alert(message);
        return false;
    }
    return true;
}  