<%--
  Created by IntelliJ IDEA.
  User: neptis
  Date: 17.10.16
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <%@ page isELIgnored="false" %>

    <title>Spring 4 MVC Hello World Example with Maven Eclipse</title>
    <link rel='stylesheet' href='<c:url value="/resources/css/style.css" />' type='text/css' media='all' />
</head>
<body>
<h2>Hello World, Spring MVC</h2>

<p>Welcome, ${name}</p>
</body>
</html>
