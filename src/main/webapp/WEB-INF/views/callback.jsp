<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "b_P87p7e5nMmJxe1aK7s";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "ASixlz1vP_";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://localhost:18080/controller/callback.do", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";

    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;

      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      
      
      
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      
      if(responseCode==200) {
        out.println("RESPONSE : " + res.toString());
        
        
        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject)parser.parse(res.toString());
        
        System.out.println("access_token : " + jsonObject.get("access_token"));
        System.out.println("refresh_token : " + jsonObject.get("refresh_token"));
        System.out.println("token_type : " + jsonObject.get("token_type"));
        System.out.println("expires_in : " + jsonObject.get("expires_in"));
        
        String token = (String)jsonObject.get("access_token");// 네이버 로그인 접근 토큰;
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        try {
            apiURL = "https://openapi.naver.com/v1/nid/me";
           	url = new URL(apiURL);
            con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            responseCode = con.getResponseCode();

            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            StringBuffer responseBuffer = new StringBuffer();
            while ((inputLine = br.readLine
            		()) != null) {
            	responseBuffer.append(inputLine);
            }
            br.close();
            System.out.println("RESPONSE 22222 : " + responseBuffer.toString());
            
            JSONObject jasonObject = (JSONObject)parser.parse(responseBuffer.toString());
            
            System.out.println(" naverId : " + ((JSONObject)jasonObject.get("response")).get("id"));
            System.out.println(" naverName : " + ((JSONObject)jasonObject.get("response")).get("name"));

            session.setAttribute("id", ((JSONObject)jasonObject.get("response")).get("id"));
            response.sendRedirect("http://localhost:8282/controller/login.do");
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        
      }
    } catch (Exception e) {
      System.out.println(e);
    }
  %>
  
  
  </body>
</html>