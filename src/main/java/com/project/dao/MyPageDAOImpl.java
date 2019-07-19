package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.BandBoardDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.MemberDTO;



@Repository
public class MyPageDAOImpl implements MyPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<MemberDTO> getMember() {
		return sqlSession.selectList("getMember");
	}

	@Override
	public List<BandBoardDTO> getBoard(Map<String, Object> m) {
		return sqlSession.selectList("getBoard",m);
	}

	@Override
	public List<BoardReplyDTO> getReply(Map<String, Object> m) {
		return sqlSession.selectList("getReply",m);
	}

}
