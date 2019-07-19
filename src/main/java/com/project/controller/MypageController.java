package com.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.project.dao.BandDAOImpl;
import com.project.dto.MemberDTO;
import com.project.service.MypageService;


@Controller
public class MypageController {
	static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired private BandDAOImpl dao;
	@Autowired private MypageService mypageService;
	
	/*@RequestMapping(value="/", method=RequestMethod.GET)
	public String root() {
		return "member/list";
	}*/
	@RequestMapping(value="/member", method=RequestMethod.GET)
	public String member() {
		return "member/list";
	}
	@RequestMapping(value="/mypage_info_{userid}.do", method=RequestMethod.GET)
	public ModelAndView info(@PathVariable(value = "userid") String userid) {
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = this.dao.selectone(userid);
		int invite = this.dao.invitecount(dto.getUsercode());
		
		mav.addObject("invite", invite);
		mav.addObject("userid", userid);
		mav.setViewName("mypage/info");
		return mav;
	}
	@RequestMapping(value="/mypage_board_{userid}.do", method=RequestMethod.GET)
	public ModelAndView board(@PathVariable(value = "userid") String userid) {
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = this.dao.selectone(userid);
		int invite = this.dao.invitecount(dto.getUsercode());
		
		mav.addObject("invite", invite);
		mav.addObject("userid", userid);
		mav.setViewName("mypage/board");
		return mav;
	}
	@RequestMapping(value="/mypage_bookmark_{userid}.do", method=RequestMethod.GET)
	public ModelAndView bookmark(@PathVariable(value = "userid") String userid) {
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = this.dao.selectone(userid);
		int invite = this.dao.invitecount(dto.getUsercode());
		
		mav.addObject("invite", invite);
		mav.addObject("userid", userid);
		mav.setViewName("mypage/bookmark");
		return mav;
	}
	
	// json 


	@RequestMapping(value="/member_list.do", method=RequestMethod.GET)
	@ResponseBody
	public String getMember() {
		return new Gson().toJson(mypageService.getMember());
	}

	@RequestMapping(value="/board_list.do", method=RequestMethod.GET)
	@ResponseBody
	public String getBoard(@RequestParam(value = "userid")String userid) {
		return new Gson().toJson(mypageService.getBoard(userid));
	}

	@RequestMapping(value="/reply_list.do", method=RequestMethod.GET)
	@ResponseBody
	public String getReply(@RequestParam(value = "userid")String userid) {
		return new Gson().toJson(mypageService.getReply(userid));
	}
		
}
