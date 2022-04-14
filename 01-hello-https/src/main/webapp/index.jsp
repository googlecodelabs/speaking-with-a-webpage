<%@ page import="java.util.ArrayList" %>
<%@ page import="sun.util.calendar.LocalGregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.example.flexible.speak.ReadXmlDomParser" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Exam System</title>
    <link type="text/css" rel="stylesheet" href="css/exam.css"/>
</head>
<body>
<div id="wrap">
    <h1>Online Exam System</h1>
    <h2>Current date: <%    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date date = new Date();
    %>
    <%=formatter.format(date)%></h2>

    <%--<%

        ReadXml reader = new ReadXml();
        ArrayList<String> questions = reader.getQuestionList();
        ArrayList<String> answers = reader.getAnswerList();
        try{
            reader.buildDom();
        }
        catch(Exception e){
            e.printStackTrace();
        }

    %>--%>
    <%
        ReadXmlDomParser reader = new ReadXmlDomParser("assignment.xml");
        ArrayList<String> questionList = reader.getQuestionList();
        ArrayList<String> answerList = reader.getAnswerList();
    %>

    <form method="post">
        <table>
            <tr>
                <%
                    int id = 1;
                    for (String question : questionList) {
                %>
                <th><%=id + ". " + question %>
                </th>
                </tr>
            <tr>
                <td>
                <label for="qid_<%=id%>">Answer:</label>
                <br/>
                <label for="qid_<%=id%>">True</label>
                <input type="radio" id="True" name="qid_<%=id%>" value="true">
                <br/>
                <label for="qid_<%=id%>">False</label>
                <input type="radio" id="false" name="qid_<%=id%>" value="false">
                <br/>
                </td>

            </tr>

                <%
    id++;
    }
%>
            <tr>
                <th>
                <input type="submit" id="submit-btn" name="submit" value="Finished">
                </th>
            </tr>

    </form>

    <%
        if (request.getParameter("submit") != null) {
            id = 1;
            int score = 0;
            for (String answer : answerList) {
                String qid = "qid_" + id;
                if (request.getParameter(qid) != null) {

                    if (request.getParameter(qid).equals(answer)) {
                        score++;
                    }
                }
                id++;
            }
    %>
    <tr>
        <th>
            <h2>Your score is <%=score%>/<%=questionList.size()%>
            </h2>
        </th>
    </tr>

    <%
        }
    %>
</div>

</body>
</html>