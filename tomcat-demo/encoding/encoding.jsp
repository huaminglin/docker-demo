<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
     <title>Character encoding test page</title>
   </head>
   <body>
     <p>Data posted/got to this form was:
     <%
       request.setCharacterEncoding("UTF-8");
       out.print("<br/>");
       out.print(request.getParameter("mymethod"));
       out.print("<br/>");
       out.print(request.getParameter("mydata"));
       out.print("<br/>");
       out.print(request.getQueryString());
     %>

     </p>
<br/>GET:
     <form method="GET" action="encoding.jsp">
        <input type="hidden" name="mymethod" value="GET">
       <input type="text" name="mydata">
       <input type="submit" value="Submit" />
       <input type="reset" value="Reset" />
     </form>
<br/>POST:
     <form method="POST" action="encoding.jsp">
       <input type="hidden" name="mymethod" value="POST">
       <input type="text" name="mydata">
       <input type="submit" value="Submit" />
       <input type="reset" value="Reset" />
     </form>
   </body>
</html>
