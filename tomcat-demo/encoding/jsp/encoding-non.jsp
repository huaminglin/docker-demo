<%@ page contentType="text/html" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
     <title>Character encoding test page</title>
   </head>
   <body>
     <p>Data posted/got to this form was:<pre><%
       out.println("Query string: " + request.getQueryString());
       if ("GET".equals(request.getMethod())) {
          out.println("Parameter mymethod: " + request.getParameter("mymethod"));
          out.println("Parameter mydata: " + request.getParameter("mydata"));
       }
       StringBuilder sb = new StringBuilder();
       char[] charBuffer = new char[1024];
       int bytesRead = request.getReader().read(charBuffer);
       if (bytesRead > 0) {
          sb.append(charBuffer, 0, bytesRead);
       }
       out.println("Raw body: ");
       out.println(sb.toString());
       out.println("Body decoded: ");
       out.println(java.net.URLDecoder.decode(sb.toString(), java.nio.charset.StandardCharsets.US_ASCII.name()));
     %></pre>

     </p>
<br/>GET:
     <form method="GET" action="encoding-non.jsp">
        <input type="hidden" name="mymethod" value="GET">
       <input type="text" name="mydata">
       <input type="submit" value="Submit" />
       <input type="reset" value="Reset" />
     </form>
<br/>POST:
     <form method="POST" action="encoding-non.jsp">
       <input type="hidden" name="mymethod" value="POST">
       <input type="text" name="mydata">
       <input type="submit" value="Submit" />
       <input type="reset" value="Reset" />
     </form>
     document.characterSet: <script>
       document.write(document.characterSet);
     </script>
   </body>
</html>
