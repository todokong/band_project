package com.project.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dao.BandDAOImpl;
import com.project.dto.BandBoardDTO;
import com.project.dto.BandFrontDTO;
import com.project.dto.BandListDTO;
import com.project.dto.MemberDTO;;

@Controller
public class BoardController<HttpSessionResponse> {
	
	@Autowired	// 占쎈뮞占쎈늄筌띻낯�몵嚥≪뮆占쏙옙苑� 占쎌쁽占쎈짗占쎌몵嚥∽옙 application 占쎌젟癰귣�占쏙옙 獄쏆룆�뮉占쎈뼄.
	ServletContext application;
	
	@Autowired
	private BandDAOImpl dao;
	
	/*@RequestMapping("/signUpp.do")
	public String signup(@RequestParam("userid") String userid, @RequestParam("pwd") String pwd, HttpServletRequest request,
			Model model) {
		
		MemberDTO dto = this.dao.login(userid);
		if(dto!=null) {
			if(dto.getPwd().equals(pwd)) {
				System.out.println("�븘�씠�뵒 o 鍮꾨쾲 0");
			}else {
				System.out.println("�븘�씠�뵒 o 鍮꾨쾲 x");
				
			}
		}else {
			System.out.println("�븘�씠�뵒 x");
		}
		
		return "";
	}*/
	@RequestMapping("/signUp.do")
	public String signUp(){
		return "signUp";
	
	}
	@RequestMapping("/signUpOk.do")
	public String singUpOk(MemberDTO dto) {
		this.dao.signUpOk(dto);
		return "signUpOk";
	}
	@RequestMapping("/searchpwd.do")
	public String searchpwd() {
		return "searchpwd";
	
	}
	@RequestMapping("/searchid.do")
	public String searchid() {
		return "searchid";
	}
	
	@RequestMapping("/findid.do")
		public String findid(MemberDTO memberDTO,HttpServletRequest request, Model model ) {
		
		MemberDTO dto2 = this.dao.findid(memberDTO);
	
		if(dto2 != null) {
			model.addAttribute("userid", dto2.getUserid());
			model.addAttribute("pwd", dto2.getPwd());
			return "idres";
		}else { 
			
		}
		return "searcherror";		
	}
	
	@RequestMapping("/findpwd.do")
	public String findpwd(MemberDTO memberDTO,HttpServletRequest request, Model model ) {
	
	MemberDTO dto3 = this.dao.findpwd(memberDTO);

	if(dto3 != null) {
		model.addAttribute("userid", dto3.getUserid());
		model.addAttribute("pwd", dto3.getPwd());

		return "pwdres";
	}else {
		
	}	
		return "pwderror";		
	}

	@RequestMapping("/login.do")
	
	public String login(MemberDTO memberDTO,@RequestParam("userid") String userid,HttpServletRequest request, Model model ) {
	HttpSession session = request.getSession();
		
		MemberDTO dto = this.dao.selectone(userid);
		session.setAttribute("dto", dto);
		String page = "";
		
		int memberCount = this.dao.login(memberDTO);
		if(memberCount == 1) {
			//로그인 성공
			//1. 세션에 담아. ex) session.setAttribute("dto", dto);
			//2. 페이지 이동.
						
			MemberDTO dto2 = this.dao.selectone(userid);
			int invite = this.dao.invitecount(dto2.getUsercode());
			
			model.addAttribute("invite", invite);
			
			List<BandListDTO> list = this.dao.list(userid);
			
			List<BandListDTO> pop= this.dao.pop();
			
			Map<Integer,Integer> count = this.dao.count(userid);
			
			List<BandFrontDTO> afront = new ArrayList<BandFrontDTO>();
			
			for(int i=0 ; i<list.size();i++) {
				BandFrontDTO dto3= new BandFrontDTO(list.get(i).getBandcode(),
						list.get(i).getBandname(),
						list.get(i).getBandimage(),
						count.get(list.get(i).getBandcode()));
				afront.add(dto3);
			}

			List<BandBoardDTO> popboard = this.dao.replylist();
			
			model.addAttribute("userid", userid);
			model.addAttribute("bandlist",afront);
			model.addAttribute("pop", pop);
			model.addAttribute("popboard",popboard);
			
			session.setAttribute("userid", userid);
			return "bandlist";
			
		}else if(memberCount == 0) {
			//로그인 실패
			//1. 모델에 0값을 담아서 main2.jsp 페이지에 넘겨줘서. 알럿을 띄워줘."로그인이 실패하셨습니다. 다시 로그인 해주세요"
		
			page = "loginfail";			
		}
		return page;
	}
	
	@RequestMapping("/checkUserId.do")
	@ResponseBody
	public int checkUserId(String userid){
		int checkResult = this.dao.checkUserId(userid);
			
		return checkResult;
	}	
	
	@RequestMapping(value = "/testLogin.do")
	public String isComplete(HttpSession session) {
		return "main2";
	}
	
	@RequestMapping(value = "/callback.do")
	public String navLogin(HttpServletRequest request) throws Exception {	
		
		return "callback";
	}
	
	@RequestMapping(value = "/personalInfo")
	public void personalInfo(HttpServletRequest request) throws Exception {
	        String token = "YOUR_ACCESS_TOKEN";// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
	        String header = "Bearer " + token; // Bearer 다음에 공백 추가
	        try {
	            String apiURL = "https://openapi.naver.com/v1/nid/me";
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("Authorization", header);
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { // 정상 호출
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            } else {  // 에러 발생
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                response.append(inputLine);
	            }
	            br.close();
	            System.out.println(response.toString());
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	}
}
