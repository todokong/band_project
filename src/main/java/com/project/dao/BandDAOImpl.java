package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.BandBoardDTO;
import com.project.dto.BandCountDTO;
import com.project.dto.BandInviteDTO;
import com.project.dto.BandListDTO;
import com.project.dto.BandMemberDTO;
import com.project.dto.BoardReplyCountDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.GongjiBoardDTO;
import com.project.dto.MemberDTO;

@Repository
public class BandDAOImpl implements BandDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public MemberDTO selectone(String userid) {
		return this.sqlSession.selectOne("select", userid);
	}
	@Override
	public List<BandBoardDTO> boardlist(int bandcode) {
		return this.sqlSession.selectList("boardlist", bandcode);
	}
	@Override
	public List<BandBoardDTO> boardlist2(int bandcode) {
		return this.sqlSession.selectList("boardlist2", bandcode);
	}
	@Override
	public List<BandBoardDTO> boardlist3(BandBoardDTO boardDTO) {
		return this.sqlSession.selectList("boardlist3", boardDTO);
	}
	@Override
	public List<BandBoardDTO> boardlist4(int bandcode) {
		return this.sqlSession.selectList("boardlist4", bandcode);
	}
	@Override
	public List<BandBoardDTO> boardlist5(BandBoardDTO boardDTO) {
		return this.sqlSession.selectList("boardlist5", boardDTO);
	}
	@Override
	public List<BoardReplyDTO> replylist(int bandcode) {
		return this.sqlSession.selectList("replylist", bandcode);
	}
	@Override
	public List<BoardReplyDTO> replylist2(BoardReplyDTO replyDTO) {
		return this.sqlSession.selectList("replylist2", replyDTO);
	}
	@Override
	public void deleteboard(int boardcode) {
		this.sqlSession.delete("deleteboard", boardcode);		
	}
	@Override
	public void writereply(BoardReplyDTO replydto) {
		this.sqlSession.insert("writereply", replydto);
	}
	@Override
	public BoardReplyDTO replydto() {
		return this.sqlSession.selectOne("replydto");
	}
	@Override
	public void deletereply(int replycode) {
		this.sqlSession.delete("deletereply", replycode);
	}
	@Override
	public void updatereply(BoardReplyDTO replydto) {
		this.sqlSession.update("updatereply", replydto);
	}
	@Override
	public BoardReplyDTO replydto2(int replycode) {
		return this.sqlSession.selectOne("replydto2", replycode);
	}
	@Override
	public void boardwrite(BandBoardDTO boardDTO) {
		this.sqlSession.insert("writeboard", boardDTO);
	}
	@Override
	public void updateboardOk(BandBoardDTO boardDTO) {
		this.sqlSession.update("updateboardOk", boardDTO);
	}
	@Override
	public void updateboardOk2(BandBoardDTO boardDTO) {
		this.sqlSession.update("updateboardOk2", boardDTO);
	}
	@Override
	public BandListDTO banddto(int bandcode) {
		return this.sqlSession.selectOne("banddto", bandcode);
	}
	@Override
	public void bandout(BandMemberDTO memberdto) {
		this.sqlSession.delete("bandout", memberdto);
	}
	@Override
	public int bandmember(BandMemberDTO bandMemberDTO) {
		return this.sqlSession.selectOne("bandmember", bandMemberDTO);
	}
	@Override
	public void joinband(BandMemberDTO memberdto) {
		this.sqlSession.insert("joinband", memberdto);
	}
	@Override
	public List<BandMemberDTO> memberlist(int bandcode) {
		return this.sqlSession.selectList("memberlist", bandcode);
	}
	@Override
	public List<BandMemberDTO> memberlist2(BandBoardDTO bandBoardDTO) {
		return this.sqlSession.selectList("memberlist2", bandBoardDTO);
	}
	@Override
	public MemberDTO membername(String userid) {
		return this.sqlSession.selectOne("membername", userid);
	}
	@Override
	public void insertimage(BandBoardDTO boardDTO) {
		this.sqlSession.insert("insertimage", boardDTO);		
	}
	@Override
	public BoardReplyDTO imagereply(int boardcode) {
		return this.sqlSession.selectOne("imagereply", boardcode);
	}
	@Override
	public BandBoardDTO boardcont(int boardcode) {
		return this.sqlSession.selectOne("boardcont", boardcode);
	}
	@Override
	public BandBoardDTO preboard(BandBoardDTO boardDTO) {
		return this.sqlSession.selectOne("preboard", boardDTO);
	}
	@Override
	public BandBoardDTO minboard(int bandcode) {
		return this.sqlSession.selectOne("minboard", bandcode);
	}
	@Override
	public BandBoardDTO nextboard(BandBoardDTO boardDTO) {
		return this.sqlSession.selectOne("nextboard", boardDTO);
	}	
	@Override
	public BandBoardDTO maxboard(int bandcode) {
		return this.sqlSession.selectOne("maxboard", bandcode);
	}
	@Override
	public List<BandBoardDTO> mboardlist(BandBoardDTO boardDTO) {
		return this.sqlSession.selectList("mboardlist", boardDTO);
	}
	@Override
	public void deleteimage(int boardcode) {
		this.sqlSession.delete("deleteimage", boardcode);
	}
	@Override
	public void deleteboard2(int boardcode) {
		this.sqlSession.delete("deleteboard2", boardcode);		
	}
	@Override
	public List<BandBoardDTO> mboardlist2(BandBoardDTO boardDTO) {	
		return this.sqlSession.selectList("mboardlist2", boardDTO);
	}
	@Override
	public List<MemberDTO> mdtolist(String invitename) {
		return this.sqlSession.selectList("mdtolist", invitename);
	}
	@Override
	public MemberDTO mdto(int usercode) {
		return this.sqlSession.selectOne("mdto", usercode);
	}
	@Override
	public List<BandInviteDTO> invitedto(int usercode) {
		return this.sqlSession.selectList("invitedto", usercode);
	}
	@Override
	public MemberDTO selectone2(int usercode) {
		return this.sqlSession.selectOne("selectone2",usercode);
	}
	@Override
	public void invitemember(BandInviteDTO inviteDTO2) {
		this.sqlSession.insert("invitemember",inviteDTO2);
	}
	@Override
	public int invitecount(int usercode) {
		return this.sqlSession.selectOne("invitecount",usercode);
	}
	@Override
	public List<BandInviteDTO> invitelist(int i) {
		return this.sqlSession.selectList("invitelist", i);
	}
	@Override
	public void deleteinvite(BandInviteDTO inviteDTO) {
		this.sqlSession.delete("deleteinvite", inviteDTO);
	}
	@Override
	public void acceptband(BandInviteDTO inviteDTO) {
		this.sqlSession.insert("acceptband", inviteDTO);
		
	}
	
	
	
	// 혜림
	@Override
	public List<BandListDTO> list(String userid) {
		List<BandListDTO> list = this.sqlSession.selectList("bandlist",userid);
		
		return list;
	}

	@Override
	public List<BandListDTO> pop() {
		List<BandCountDTO> count = this.sqlSession.selectList("memberlist3");
		
		List<BandListDTO> pop = new ArrayList<BandListDTO>() ;
		BandListDTO dto;
		int bandcode;
		
		for(int i=0; i<6;i++) {
			bandcode=count.get(i).getBandcode();		
			dto=this.sqlSession.selectOne("one", bandcode);;
		   pop.add(dto);	
		}
		
		return pop;
	}

	@Override
	public void bandcreate(BandListDTO dto, String userid) {
		this.sqlSession.insert("bandlistadd",dto);
		this.sqlSession.insert("bandmemberadd",userid);
		
	}
	
	@Override
	public Map<Integer, Integer> count(String userid) {
		int a,b;
		List<BandCountDTO> dto = this.sqlSession.selectList("countlist",userid);
		
		// list를 맵으로 변환 
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		
		for(int i=0 ; i<dto.size() ; i++) {
			a=dto.get(i).getBandcode();
			b=dto.get(i).getBandcount();
			map.put(a, b);
			//System.out.println(dto.get(i).getBandcode());
		}
		return map;
	}
	
	@Override
	public List<GongjiBoardDTO> gongjilist() {
		
		List<GongjiBoardDTO> list = this.sqlSession.selectList("gongji");
		
		return list;
	}
	@Override
    public List<BandBoardDTO> replylist() {
       
       List<BoardReplyCountDTO> list = this.sqlSession.selectList("reply");
       
       List<BandBoardDTO> popboard = new ArrayList<BandBoardDTO>();
       int one ;
       BandBoardDTO dto ;
       
       for( int i=0 ; i<list.size() ;i++){
          one=list.get(i).getBoardcode();
          dto =this.sqlSession.selectOne("boardone", one);
          popboard.add(dto);
       }
       return popboard;
    }
    
	
	// 정현
	@Override
	public void signUpOk(MemberDTO dto) {
		this.sqlSession.insert("signUpOk", dto);
	}
	@Override
	public int checkUserId(String userid) {
		return this.sqlSession.selectOne("checkUserId", userid);
	}	
	@Override
	public int login(MemberDTO memberDTO) {
		return this.sqlSession.selectOne("login", memberDTO);
	}
	@Override
	public MemberDTO findid(MemberDTO memberDTO) {
		return this.sqlSession.selectOne("findid",memberDTO);
	}
	@Override
	public MemberDTO findpwd(MemberDTO memberDTO) {
		return this.sqlSession.selectOne("findpwd",memberDTO);
	}
	
	
	//현욱 
	@Override
	public List<BandListDTO> searchBand(String search) {
		return this.sqlSession.selectList("searchBand", search);
	}	
	@Override
	public List<BandBoardDTO> searchBandboard(BandBoardDTO bandBoardDTO) {
		return this.sqlSession.selectList("searchBoard", bandBoardDTO);
	}
	@Override
	public int searchBoardCount(BandBoardDTO bandBoardDTO) {
		return this.sqlSession.selectOne("searchBoardCount", bandBoardDTO);
	}
	@Override
	public MemberDTO member(MemberDTO dto) {
		return this.sqlSession.selectOne("member", dto);
	}
	
}