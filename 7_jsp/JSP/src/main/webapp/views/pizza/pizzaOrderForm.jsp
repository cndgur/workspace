<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>피자주문페이지</h1>
    <h2>오늘의날짜</h2>
    <%
    Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
    %>

    <h4><%=sdf.format(today)%></h4>

    <!--
        주문자정보, 주문정보를 입력받아서
        서버에 결제요청(서블릿에 전달)
        controller -> PizzaServlet.java
        응답을 위한 jsp페이지
        pizza -> pizzaPayment.jsp
    -->

    <form action="/JSP/confirmPizza.do" method="Get">
        <fieldset>
            <legend>주문자 정보</legend>

            <table>
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="userName" required></td>
                </tr>

                <tr>
                    <td>전화번호</td>
                    <td><input type="text" name="phone" required></td>
                </tr>

                <tr>
                    <td>주소</td>
                    <td><input type="text" name="address" required></td>
                </tr>

                <tr>
                    <td>요청 메시지</td>
                    <td><textarea name="message"></textarea></td>
                </tr>
            </table>
        </fieldset>

        <fieldset>
            <legend>주문 정보</legend>
            <table>
                <tr>
                    <th>피자</th>
                    <td>
                        <select name="pizza">
                            <option>콤비네이션</option>
                            <option>포테이토</option>
                            <option>고구마</option>
                            <option>치즈</option>
                            <option>하와이안</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>토핑</th>
                    <td>
                        <label>
                            <input type="checkbox" name="topping" value="고구마무스"> 고구마무스
                        </label>
                        <label>
                            <input type="checkbox" name="topping" value="치즈"> 치즈
                        </label>
                        <label>
                            <input type="checkbox" name="topping" value="베이컨"> 베이컨
                        </label>
                        <label>
                            <input type="checkbox" name="topping" value="포테이토"> 포테이토
                        </label>
                        <label>
                            <input type="checkbox" name="topping" value="소세지"> 소세지
                        </label>
                        <label>
                            <input type="checkbox" name="topping" value="피클"> 피클
                        </label>
                    </td>
                </tr>

                <tr>
                    <th>사이드</th>
                    <td>
                        <label>
                            <input type="checkbox" name="side" value="콜라"> 콜라
                        </label>
                        <label>
                            <input type="checkbox" name="side" value="사이다"> 사이다
                        </label>
                    </td>
                </tr>

                <tr>
                    <th>결제 방식</th>
                    <td>
                        <input type="radio" name="payment" value="card" checked> 카드
                        <input type="radio" name="payment" value="cash"> 현금
                    </td>
                </tr>
            </table>
        </fieldset>

        <br>

        <input type="submit" value="주문">
        <input type="reset">
    </form>
</body>
</html>