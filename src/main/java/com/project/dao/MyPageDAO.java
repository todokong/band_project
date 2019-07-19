package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.BandBoardDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.MemberDTO;


public interface MyPageDAO {
	public List<MemberDTO> getMember();
	public List<BandBoardDTO> getBoard(Map<String, Object> m);
	public List<BoardReplyDTO> getReply(Map<String, Object> m);
}
