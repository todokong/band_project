package com.project.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.dao.BandDAOImpl;
import com.project.dto.BandBoardDTO;
import com.project.dto.BandFrontDTO;
import com.project.dto.BandInviteDTO;
import com.project.dto.BandListDTO;
import com.project.dto.BandMemberDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.GongjiBoardDTO;
import com.project.dto.MemberDTO;

@Controller
public class HomeController {
	
	@Autowired
	ServletContext application;
	
	@Autowired
	private BandDAOImpl dao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "main2";
	}
	
	@RequestMapping("/select2.do")
	public String main2(@RequestParam("userid") String userid, @RequestParam("bandcode") int bandcode ,
			HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = this.dao.selectone(userid);
		session.setAttribute("dto", dto);
		
		BandListDTO banddto = this.dao.banddto(bandcode);
		
		BandMemberDTO bandMemberDTO = new BandMemberDTO();
		bandMemberDTO.setBandcode(bandcode);
		bandMemberDTO.setUserid(userid);
		int result = this.dao.bandmember(bandMemberDTO);
		
		List<BandMemberDTO> memberlist = this.dao.memberlist(bandcode);
		
		List<MemberDTO> dtolist = new ArrayList<MemberDTO>(); 
		for(int i=0; i<memberlist.size(); i++) {
			MemberDTO dto2 = this.dao.membername(memberlist.get(i).getUserid());
			dtolist.add(dto2);
		}
		
		int invite = this.dao.invitecount(dto.getUsercode());
		
		model.addAttribute("invite", invite);
		model.addAttribute("dtolist", dtolist);
		model.addAttribute("banddto", banddto);
		model.addAttribute("bandcode", bandcode);
		model.addAttribute("userid", userid);
		model.addAttribute("result", result);
		
		return "board_list2";
	}
	@RequestMapping("/replylist3.do")
	@ResponseBody
	public Object replylist3(@RequestParam("bandcode") int bandcode, HttpServletRequest request, Model model){
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		List<BandBoardDTO> boardlist = this.dao.boardlist2(bandcode);
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("boardlist", boardlist);
		retVal.put("userid", dto.getUserid());
		
		return retVal;
	}
	@RequestMapping("/replylist4.do")
	@ResponseBody
	public Object replylist4(@RequestParam("bandcode") int bandcode, @RequestParam("lastbno") int lastbno,
			HttpServletRequest request, Model model){
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BandBoardDTO boardDTO = new BandBoardDTO();
		boardDTO.setBandcode(bandcode);
		boardDTO.setBoardcode(lastbno);
		
		List<BandBoardDTO> boardlist = this.dao.boardlist3(boardDTO);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("boardlist", boardlist);
		retVal.put("userid", dto.getUserid());
		
		return retVal;
	}
	
	@RequestMapping("/replyview.do")
	@ResponseBody
	public Object replyview(@RequestParam("bandcode") int bandcode, @RequestParam("boardcode") int boardcode,
			HttpServletRequest request, Model model){
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BoardReplyDTO replyDTO = new BoardReplyDTO();
		replyDTO.setBandcode(bandcode);
		replyDTO.setBoardcode(boardcode);
		
		List<BoardReplyDTO> replylist2 = this.dao.replylist2(replyDTO);
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("replylist2", replylist2);
		retVal.put("userid", dto.getUserid());
		
		return retVal;
	}
	
	@RequestMapping("/deleteboard.do")
	@ResponseBody
	public void deleteboard(@RequestParam("boardcode") int boardcode,
			HttpServletRequest request, Model model) {
		
		this.dao.deleteboard(boardcode);
		this.dao.deleteboard2(boardcode);
	}
	
	@RequestMapping("/writereply.do")
	@ResponseBody
	public Object writereply(@RequestParam("bandcode") int bandcode, @RequestParam("boardcode") int boardcode,
			@RequestParam("replycontent") String replycontent, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BoardReplyDTO replydto = new BoardReplyDTO();
		replydto.setBandcode(bandcode);
		replydto.setBoardcode(boardcode);
		replydto.setReplycontent(replycontent);
		replydto.setUserid(dto.getUserid());
		replydto.setUsername(dto.getUsername());
		
		this.dao.writereply(replydto);
		
		replydto = this.dao.replydto();
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("replydto", replydto);
		retVal.put("userid", dto.getUserid());
		
		return retVal;		
	}
	@RequestMapping("/deletereply.do")
	@ResponseBody
	public void deletereply(@RequestParam("replycode") int replycode, @RequestParam("boardcode") int boardcode,
			HttpServletRequest request, Model model) {
		
		this.dao.deletereply(replycode);	
	}
	@RequestMapping("/updatereply.do")
	@ResponseBody
	public Object updatereply(@RequestParam("replycode") int replycode, @RequestParam("replycontent") String replycontent,
			HttpServletRequest request, Model model) {
		
		BoardReplyDTO replydto = new BoardReplyDTO();
		replydto.setReplycode(replycode);
		replydto.setReplycontent(replycontent);
		
		this.dao.updatereply(replydto);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		replydto = this.dao.replydto2(replycode);
		retVal.put("replydto", replydto);
		
		return retVal;		
	}
	@RequestMapping("/replydto.do")
	@ResponseBody
	public Object replydto(@RequestParam("replycode") int replycode, HttpServletRequest request, Model model) {
		
		BoardReplyDTO replydto = this.dao.replydto2(replycode);
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("replydto", replydto);
		
		return retVal;		
	}
	
	
	@RequestMapping("/writeboard.do")
	public String writeboardOk(BandBoardDTO boardDTO, @RequestParam("bandcode") int bandcode,
			HttpServletRequest request, Model model) throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		String webPath = "/resources/bandimage/";
		String savePath = application.getRealPath(webPath);
		
		MultipartFile file = boardDTO.getFile();
		String filename = "no_file";
		
		if(!file.isEmpty()) {
			filename = file.getOriginalFilename();
			
			File saveFile = new File(savePath, filename);
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}
			file.transferTo(saveFile);
		}
		boardDTO.setBoardimage(filename);
		boardDTO.setUserid(dto.getUserid());
		boardDTO.setUsername(dto.getUsername());
		boardDTO.setBandcode(bandcode);
		
		this.dao.boardwrite(boardDTO);
		
		return "redirect:select2.do?userid="+boardDTO.getUserid()+"&bandcode="+boardDTO.getBandcode();
	}
	
	@RequestMapping("/writeboardOk.do")
	public String updateboardOk(BandBoardDTO boardDTO, HttpServletRequest request, Model model) throws Exception {
		if(!boardDTO.getFile().isEmpty()) {
			String webPath = "/resources/bandimage/";
			String savePath = application.getRealPath(webPath);
		
			MultipartFile file = boardDTO.getFile();
			String filename = "no_file";
		
			if(!file.isEmpty()) {
				filename = file.getOriginalFilename();
			
				File saveFile = new File(savePath, filename);
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}else {
					long time = System.currentTimeMillis();
					filename = String.format("%d_%s", time, filename);
					saveFile = new File(savePath, filename);
				}
				file.transferTo(saveFile);
			}
			boardDTO.setBoardimage(filename);
			this.dao.updateboardOk(boardDTO);
		}else {
			this.dao.updateboardOk2(boardDTO);
		}
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		return "redirect:select2.do?userid="+dto.getUserid()+"&bandcode="+boardDTO.getBandcode();
	}
	
	@RequestMapping("/bandout.do")
	public String bandout(@RequestParam("bandcode") int bandcode, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BandMemberDTO memberdto = new BandMemberDTO();
		memberdto.setBandcode(bandcode);
		memberdto.setUserid(dto.getUserid());
		
		this.dao.bandout(memberdto);
		
		return "redirect:select2.do?userid="+dto.getUserid()+"&bandcode="+bandcode;
	}
	@RequestMapping("/joinband.do")
	public String joinband(@RequestParam("bandcode") int bandcode, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BandMemberDTO memberdto = new BandMemberDTO();
		memberdto.setBandcode(bandcode);
		memberdto.setUserid(dto.getUserid());
		
		this.dao.joinband(memberdto);
		
		return "redirect:select2.do?userid="+dto.getUserid()+"&bandcode="+bandcode;
	}
	
	@RequestMapping("/bandimage.do")
	public String bandimage(@RequestParam("bandcode") int bandcode, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		int invite = this.dao.invitecount(dto.getUsercode());
		
		model.addAttribute("invite", invite);
		
		List<BandBoardDTO> boardlist = this.dao.boardlist4(bandcode);
		model.addAttribute("boardlist", boardlist);
		
		BandListDTO banddto = this.dao.banddto(bandcode);
		
		BandMemberDTO bandMemberDTO = new BandMemberDTO();
		bandMemberDTO.setBandcode(bandcode);
		bandMemberDTO.setUserid(dto.getUserid());
		int result = this.dao.bandmember(bandMemberDTO);
		
		List<BandMemberDTO> memberlist = this.dao.memberlist(bandcode);

		List<MemberDTO> dtolist = new ArrayList<MemberDTO>(); 
		for(int i=0; i<memberlist.size(); i++) {
			MemberDTO dto2 = this.dao.membername(memberlist.get(i).getUserid());
			dtolist.add(dto2);
		}
		
		model.addAttribute("dtolist", dtolist);
		model.addAttribute("banddto", banddto);
		model.addAttribute("bandcode", bandcode);
		model.addAttribute("result", result);
		
		return "band_image";
	}
	
	@RequestMapping("/bandimage2.do")
	@ResponseBody
	public Object bandimage2(@RequestParam("bandcode") int bandcode, @RequestParam("lastbno") int lastbno,
			HttpServletRequest request, Model model) {
		
		BandBoardDTO boardDTO = new BandBoardDTO();
		boardDTO.setBoardcode(lastbno);
		boardDTO.setBandcode(bandcode);
		
		List<BandBoardDTO> boardlist = this.dao.boardlist5(boardDTO);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("boardlist", boardlist);
		
		return retVal;
	}	
	
	@RequestMapping("/insertimage.do")
	public String insertimage(BandBoardDTO boardDTO, @RequestParam("bandcode") int bandcode,
			HttpServletRequest request, Model model) throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		String webPath = "/resources/bandimage/";
		String savePath = application.getRealPath(webPath);
		
		MultipartFile file = boardDTO.getFile();
		String filename = "no_file";
		
		if(!file.isEmpty()) {
			filename = file.getOriginalFilename();
			
			File saveFile = new File(savePath, filename);
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}
			file.transferTo(saveFile);
		}
		boardDTO.setBoardimage(filename);
		boardDTO.setUserid(dto.getUserid());
		boardDTO.setUsername(dto.getUsername());
		boardDTO.setBandcode(bandcode);
		
		this.dao.insertimage(boardDTO);
		
		return "redirect:bandimage.do?bandcode="+bandcode;
	}
	
	@RequestMapping("/imagecont2.do")
	public String imagecont2(BandBoardDTO boardDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		boardDTO = this.dao.boardcont(boardDTO.getBoardcode());
		
		BoardReplyDTO replyDTO = new BoardReplyDTO();
		replyDTO.setBandcode(boardDTO.getBandcode());
		replyDTO.setBoardcode(boardDTO.getBoardcode());
		
		List<BoardReplyDTO> replylist2 = this.dao.replylist2(replyDTO);
		model.addAttribute("replylist", replylist2);
		
		model.addAttribute("boardDTO", boardDTO);
		model.addAttribute("boardcode", boardDTO.getBoardcode());
		model.addAttribute("bandcode", boardDTO.getBandcode());
		
		return "image_cont";
	}
	
	@RequestMapping("/imagereply.do")
	@ResponseBody
	public Object imagereply(BoardReplyDTO replyDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BoardReplyDTO replydto = new BoardReplyDTO();
		replydto.setBandcode(replyDTO.getBandcode());
		replydto.setBoardcode(replyDTO.getBoardcode());
		replydto.setReplycontent(replyDTO.getReplycontent());
		replydto.setUserid(dto.getUserid());
		replydto.setUsername(dto.getUsername());
		
		this.dao.writereply(replydto);
		
		replydto = this.dao.replydto();
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("replydto", replydto);
		retVal.put("userid", dto.getUserid());
		
		return retVal;			
	}
	@RequestMapping("/preimage.do")
	public String preimage(BandBoardDTO boardDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		int bandcode = boardDTO.getBandcode();
		boardDTO = this.dao.preboard(boardDTO);
		
		if(boardDTO == null) {
			boardDTO = this.dao.minboard(bandcode);
			return "redirect:imagecont2.do?bandcode="+boardDTO.getBandcode()+"&boardcode="+boardDTO.getBoardcode()+"&boardimage="+boardDTO.getBoardimage();
		}
		
		return "redirect:imagecont2.do?bandcode="+boardDTO.getBandcode()+"&boardcode="+boardDTO.getBoardcode()+"&boardimage="+boardDTO.getBoardimage();
		
	}
	@RequestMapping("/nextimage.do")
	public String nextimage(BandBoardDTO boardDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		int bandcode = boardDTO.getBandcode();
		boardDTO = this.dao.nextboard(boardDTO);
		
		if(boardDTO == null) {
			boardDTO = this.dao.maxboard(bandcode);
			return "redirect:imagecont2.do?bandcode="+boardDTO.getBandcode()+"&boardcode="+boardDTO.getBoardcode()+"&boardimage="+boardDTO.getBoardimage();
		}
		return "redirect:imagecont2.do?bandcode="+boardDTO.getBandcode()+"&boardcode="+boardDTO.getBoardcode()+"&boardimage="+boardDTO.getBoardimage();
	}
	
	@RequestMapping("/memboard.do")
	public String memboard(BandBoardDTO boardDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		int invite = this.dao.invitecount(dto.getUsercode());
		
		model.addAttribute("invite", invite);
		
		List<BandBoardDTO> mboardlist = this.dao.mboardlist(boardDTO);
		
		model.addAttribute("mboardlist", mboardlist);
		
		BandListDTO banddto = this.dao.banddto(boardDTO.getBandcode());
		
		BandMemberDTO bandMemberDTO = new BandMemberDTO();
		bandMemberDTO.setBandcode(boardDTO.getBandcode());
		bandMemberDTO.setUserid(boardDTO.getUserid());
		int result = this.dao.bandmember(bandMemberDTO);
		
		List<BandMemberDTO> memberlist = this.dao.memberlist(boardDTO.getBandcode());
		
		List<MemberDTO> dtolist = new ArrayList<MemberDTO>(); 
		for(int i=0; i<memberlist.size(); i++) {
			MemberDTO dto2 = this.dao.membername(memberlist.get(i).getUserid());
			dtolist.add(dto2);
		}
		
		model.addAttribute("dtolist", dtolist);
		
		model.addAttribute("banddto", banddto);
		model.addAttribute("bandcode", boardDTO.getBandcode());
		model.addAttribute("userid", boardDTO.getUserid());
		model.addAttribute("result", result);
		
		return "board_mem";
	}
	@RequestMapping("/memboard2.do")
	@ResponseBody
	public Object memboard2(@RequestParam("lastbno") int lastbno,
			BandBoardDTO boardDTO, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);

		boardDTO.setBoardcode(lastbno);
		
		List<BandBoardDTO> mboardlist = this.dao.mboardlist2(boardDTO);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		retVal.put("mboardlist", mboardlist);
		retVal.put("userid", dto.getUserid());
		
		return retVal;
	}
	
	@RequestMapping("/deleteimage.do")
	public String deleteimage(@RequestParam("bandcode") int bandcode, @RequestParam("boardcode") int boardcode,
			HttpServletRequest request, Model model) {
		this.dao.deleteimage(boardcode);
		this.dao.deleteboard2(boardcode);
		return "redirect:bandimage.do?bandcode="+bandcode;
	}
	@RequestMapping("/bandinvite.do")
	public String bandinvite(@RequestParam("bandcode") int bandcode, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		BandListDTO banddto = this.dao.banddto(bandcode);

		BandMemberDTO bandMemberDTO = new BandMemberDTO();
		bandMemberDTO.setBandcode(bandcode);
		bandMemberDTO.setUserid(dto.getUserid());
		int result = this.dao.bandmember(bandMemberDTO);
		
		List<BandMemberDTO> memberlist = this.dao.memberlist(bandcode);
		
		List<MemberDTO> dtolist = new ArrayList<MemberDTO>(); 
		for(int i=0; i<memberlist.size(); i++) {
			MemberDTO dto2 = this.dao.membername(memberlist.get(i).getUserid());
			dtolist.add(dto2);
		}
		int invite = this.dao.invitecount(dto.getUsercode());
		
		model.addAttribute("invite", invite);
		model.addAttribute("dtolist", dtolist);
		model.addAttribute("banddto", banddto);
		model.addAttribute("bandcode", bandcode);
		model.addAttribute("userid", dto.getUserid());
		model.addAttribute("result", result);
		
		return "band_invite";
	}
	@RequestMapping("/search2.do")
	@ResponseBody
	public Object search( @RequestParam("invitename") String invitename,
			HttpServletRequest request, Model model) {
		
		List<MemberDTO> mdto = this.dao.mdtolist(invitename);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("mdto", mdto);
		
		return retVal;
	}
	@RequestMapping("/invite.do")
	@ResponseBody
	public int invite(@RequestParam("bandcode") int bandcode, @RequestParam("usercode") int usercode,
			HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		System.out.println("aa");
		System.out.println(dto.getUserid());
		System.out.println(usercode);
		/*MemberDTO mdto = this.dao.mdto(usercode);*/
		MemberDTO inviteDTO = this.dao.selectone2(usercode);
		List<BandInviteDTO> invitelist = this.dao.invitedto(usercode); 
		
		System.out.println(inviteDTO.getUserid());
		
		int invite = 0; 
		
		if(invitelist.isEmpty()) { // 초대 테이블에 없을 때
			
			BandMemberDTO bandMemberDTO = new BandMemberDTO();
			bandMemberDTO.setBandcode(bandcode);
			bandMemberDTO.setUserid(inviteDTO.getUserid());
			
			int result = this.dao.bandmember(bandMemberDTO);
			System.out.println(result);
			if(result == 0) { // 밴드에 없을때 (초대 가능)
				BandInviteDTO inviteDTO2 = new BandInviteDTO();
				inviteDTO2.setBandcode(bandcode);
				inviteDTO2.setInviteusercode(usercode);
				inviteDTO2.setUserid(dto.getUserid());
				inviteDTO2.setUsername(dto.getUsername());
				BandListDTO banddto = this.dao.banddto(bandcode);
				inviteDTO2.setBandname(banddto.getBandname());
				this.dao.invitemember(inviteDTO2);
				
				invite = 1;
			}else { // 밴드에 있을때 (초대 불가능)
				invite = 2;
			}	
		}else { // 초대 테이블에 있을 때(초대 불가능)
			invite = 3;
		}
		return invite;		
	}
	@RequestMapping(value="/mypage_invite.do", method=RequestMethod.GET)
	public ModelAndView invitepage(@RequestParam("userid") String userid) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("userid", userid);
		mav.setViewName("invite_page");
		
		MemberDTO dto = this.dao.selectone(userid);
		int invite = this.dao.invitecount(dto.getUsercode());
		
		mav.addObject("invite", invite);
		return mav;
	}
	@RequestMapping("/getinvite.do")
	@ResponseBody
	public Object getinvite(@RequestParam("userid") String userid, HttpServletRequest request, Model model) {

		MemberDTO dto = this.dao.selectone(userid);
		
		List<BandInviteDTO> inviteDTOs = this.dao.invitelist(dto.getUsercode());
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("inviteDTOs", inviteDTOs);
		
		return retVal;
	}
	@RequestMapping("/accept.do")
	public String accept(@RequestParam("bandcode") int bandcode, @RequestParam("userid") String userid,
			HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = this.dao.selectone(userid);
		session.setAttribute("dto", dto);
		
		BandInviteDTO inviteDTO = new BandInviteDTO();
		inviteDTO.setBandcode(bandcode);
		inviteDTO.setInviteusercode(dto.getUsercode());
		inviteDTO.setUserid(dto.getUserid());
		
		this.dao.deleteinvite(inviteDTO);
		this.dao.acceptband(inviteDTO);
		
		return "redirect:select2.do?userid="+dto.getUserid()+"&bandcode="+bandcode;
	}
	@RequestMapping("/refuse.do")
	public String refuse(@RequestParam("bandcode") int bandcode, @RequestParam("userid") String userid,
			HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = this.dao.selectone(userid);
		session.setAttribute("dto", dto);
		
		BandInviteDTO inviteDTO = new BandInviteDTO();
		inviteDTO.setBandcode(bandcode);
		inviteDTO.setInviteusercode(dto.getUsercode());
		inviteDTO.setUserid(dto.getUserid());
		
		this.dao.deleteinvite(inviteDTO);
		
		return "redirect:mypage_invite.do?userid="+dto.getUserid();
	}
	
	
	
	
	
	
	// 혜림
	@RequestMapping("/bandlist.do")
	public String bandlist(Model model,@RequestParam("userid") String userid, HttpServletRequest request) {
		
		
		MemberDTO dto2 = this.dao.selectone(userid);
		int invite = this.dao.invitecount(dto2.getUsercode());
		
		HttpSession session = request.getSession();
		
		session.setAttribute("dto", dto2);
		
		
		model.addAttribute("invite", invite);
		
		List<BandListDTO> list = this.dao.list(userid);
		
		List<BandListDTO> pop= this.dao.pop();
		
		Map<Integer,Integer> count = this.dao.count(userid);
		
		List<BandFrontDTO> afront = new ArrayList<BandFrontDTO>();
		
		for(int i=0 ; i<list.size();i++) {
			BandFrontDTO dto= new BandFrontDTO(list.get(i).getBandcode(),
					list.get(i).getBandname(),
					list.get(i).getBandimage(),
					count.get(list.get(i).getBandcode()));
			afront.add(dto);
		}

		List<BandBoardDTO> popboard = this.dao.replylist();
		
		model.addAttribute("userid", userid);
		model.addAttribute("bandlist",afront);
		model.addAttribute("pop", pop);
		model.addAttribute("popboard",popboard);
		
		session.setAttribute("userid", userid);
		
		return "bandlist";	
	}
	@RequestMapping("/exnav.do")
	public String a() {
		
		return "exnav";
	}
	@RequestMapping("/bandCreateOk.do")
	public String bandcreate(Model model, HttpServletRequest request,@RequestParam("userid") String userid,
			BandListDTO dto) throws Exception {
			
	HttpSession session=request.getSession();
	session.setAttribute("userid", userid);
	
	String webPath = "/resources/bandimage/";
	String savePath = application.getRealPath(webPath);  // 절대경로
	
	MultipartFile file = dto.getUpfile();
	String filename="no_file";
	if(!file.isEmpty()) {
		filename=file.getOriginalFilename();
		File saveFile= new File(savePath, filename);
		if(!saveFile.exists()) {
			saveFile.mkdirs();
		}else {
			long time= System.currentTimeMillis();
			filename = String.format("%d_%s", time, filename);
			saveFile = new File(savePath, filename);		
		}
		file.transferTo(saveFile);
	}
		dto.setBandimage(filename);
	
		this.dao.bandcreate(dto,userid);

		return "redirect:bandlist.do?userid="+userid;
	}
	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session=request.getSession();
		//session.
		session.invalidate();
		
		return "main2";
	}
	@RequestMapping("adminboard.do")
	public String gongji(Model model, HttpServletRequest request ) {
		
		HttpSession session= request.getSession();
		String userid= (String) session.getAttribute("userid");
		
		List<GongjiBoardDTO> gongji = this.dao.gongjilist();
		
		model.addAttribute("list" , gongji);
		
		session.setAttribute("userid", userid);
		return "gongji";
	}
	
	// 현욱
	@RequestMapping("/find.do")
	public String findBand (HttpServletRequest request, Model model, 
			@ModelAttribute("BandBoardDTO") BandBoardDTO bandBoardDTO) {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		session.setAttribute("dto", dto);
		
		int invite = this.dao.invitecount(dto.getUsercode());
		
		model.addAttribute("invite", invite);
		
		int totalCount = this.dao.searchBoardCount(bandBoardDTO); 
        if (bandBoardDTO.getTotalCount() == 0) bandBoardDTO.setTotalCount(totalCount);;
        if (bandBoardDTO.getPageNo() == 0) bandBoardDTO.setPageNo(1);   
        if (bandBoardDTO.getPageSize() == 0) bandBoardDTO.setPageSize(1); 
        if (bandBoardDTO.getPageBlock() == 0 ) bandBoardDTO.setPageBlock(5); 
        
        int pageSize = bandBoardDTO.getPageSize();
        int pageNo = bandBoardDTO.getPageNo();
        int pageBlock = bandBoardDTO.getPageBlock();
        
        
        int finalPage = (totalCount + (pageSize - 1)) ;
        bandBoardDTO.setFirstPageNo(1);  
        bandBoardDTO.setFinalPageNo(finalPage); 
        
       
        boolean isNowFirst = pageNo == 1 ? true : false;    
        boolean isNowFinal = pageNo == finalPage ? true : false;  
        if (isNowFirst) {
            bandBoardDTO.setPrevPageNo(1); 
        } else {
            bandBoardDTO.setPrevPageNo(((pageNo - 1) < 1 ? 1 : (pageNo - 1))); 
        }
        if (isNowFinal) {
            bandBoardDTO.setNextPageNo(finalPage); 
        } else {
            bandBoardDTO.setNextPageNo(((pageNo + 1) > finalPage ? finalPage : (pageNo + 1))); 
        }
                
       
        int startPage = ((pageNo - 1) / pageBlock) * pageBlock + 1; 
        int endPage = startPage + pageBlock - 1;     

       
        if (endPage > finalPage) { 
            endPage = finalPage;  
        }
        bandBoardDTO.setStartPageNo(startPage); 
        bandBoardDTO.setEndPageNo(endPage);  



        
        int startRowNo = ((pageNo-1) * pageSize ) + 1;
        int endRowNo = pageNo * pageSize; 
        bandBoardDTO.setStartRowNo(startRowNo);
        bandBoardDTO.setEndRowNo(endRowNo);
		
    
		
	    logger.info("SearchValue : " + bandBoardDTO.getSearchValue());
	  
	   
	    /*int totalCount = this.dao.searchBoardCount(bandBoardDTO); 
	    bandBoardDTO.setTotalCount(totalCount);*/
	    model.addAttribute("Paging", bandBoardDTO);
	    	  
	    List<BandBoardDTO> boardList = this.dao.searchBandboard(bandBoardDTO);
	   
	    List<BandListDTO> list = this.dao.searchBand(bandBoardDTO.getSearchValue());
	    model.addAttribute("resultList", boardList);
	    model.addAttribute("search", list);    
	    
	    return "search_list";
	}

	
}
