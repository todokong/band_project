package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MyPageDAO;
import com.project.dto.BandBoardDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.MemberDTO;

@Service
public class MypageService {
	@Autowired private MyPageDAO myPageDAO;

	public List<MemberDTO> getMember() {
		return myPageDAO.getMember();
	}
	public List<BandBoardDTO> getBoard(String userid) {
		Map<String, Object> m = new HashMap<String,Object>();
		m.put("userid", userid);
		return myPageDAO.getBoard(m);
	}
	public List<BoardReplyDTO> getReply(String userid) {
		Map<String, Object> m = new HashMap<String,Object>();
		m.put("userid", userid);
		return myPageDAO.getReply(m);
	}
}
