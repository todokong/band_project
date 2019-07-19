package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.BandBoardDTO;
import com.project.dto.BandInviteDTO;
import com.project.dto.BandListDTO;
import com.project.dto.BandMemberDTO;
import com.project.dto.BoardReplyDTO;
import com.project.dto.GongjiBoardDTO;
import com.project.dto.MemberDTO;

public interface BandDAO {

	// 규홍
	public MemberDTO selectone(String userid);
	public List<BandBoardDTO> boardlist(int bandcode);
	public List<BandBoardDTO> boardlist2(int bandcode);
	public List<BandBoardDTO> boardlist3(BandBoardDTO boardDTO);
	public List<BandBoardDTO> boardlist4(int bandcode);
	public List<BoardReplyDTO> replylist(int bandcode);
	List<BandBoardDTO> mboardlist(BandBoardDTO boardDTO);
	BandBoardDTO maxboard(int bandcode);
	BandBoardDTO nextboard(BandBoardDTO boardDTO);
	BandBoardDTO minboard(int bandcode);
	BandBoardDTO preboard(BandBoardDTO boardDTO);
	BandBoardDTO boardcont(int boardcode);
	BoardReplyDTO imagereply(int boardcode);
	MemberDTO membername(String userid);
	void insertimage(BandBoardDTO boardDTO);
	List<BandMemberDTO> memberlist2(BandBoardDTO bandBoardDTO);
	List<BandMemberDTO> memberlist(int bandcode);
	void joinband(BandMemberDTO memberdto);
	int bandmember(BandMemberDTO bandMemberDTO);
	void bandout(BandMemberDTO memberdto);
	void updateboardOk2(BandBoardDTO boardDTO);
	void updateboardOk(BandBoardDTO boardDTO);
	BandListDTO banddto(int bandcode);
	void boardwrite(BandBoardDTO boardDTO);
	BoardReplyDTO replydto2(int replycode);
	void deleteboard(int boardcode);
	List<BoardReplyDTO> replylist2(BoardReplyDTO replyDTO);
	void writereply(BoardReplyDTO replydto);
	void deletereply(int replycode);
	BoardReplyDTO replydto();
	void updatereply(BoardReplyDTO replydto);
	void deleteimage(int boardcode);
	void deleteboard2(int boardcode);
	List<BandBoardDTO> boardlist5(BandBoardDTO boardDTO);
	void acceptband(BandInviteDTO inviteDTO);
	void deleteinvite(BandInviteDTO inviteDTO);
	List<BandInviteDTO> invitelist(int i);
	int invitecount(int usercode);
	void invitemember(BandInviteDTO inviteDTO2);
	MemberDTO selectone2(int usercode);
	List<BandInviteDTO> invitedto(int usercode);
	MemberDTO mdto(int usercode);
	List<MemberDTO> mdtolist(String invitename);
	List<BandBoardDTO> mboardlist2(BandBoardDTO boardDTO);
	
	
	// 혜림
	public List<BandListDTO> list(String userid);
	public List<BandListDTO> pop();
	public void bandcreate(BandListDTO dto, String userid);
	public Map<Integer,Integer> count(String userid);
	public List<GongjiBoardDTO> gongjilist();
	public List<BandBoardDTO> replylist();
	
	
	// 정현
	public int login(MemberDTO memberDTO);
	
	public MemberDTO findid(MemberDTO memberDTO);

	public MemberDTO findpwd(MemberDTO memberDTO);
	
	public void signUpOk(MemberDTO dto);

	public int checkUserId(String userid);
	
	
	// 현욱
	public MemberDTO member(MemberDTO dto);
		
	public List<BandListDTO> searchBand(String searchTxt);
		
	public List<BandBoardDTO> searchBandboard(BandBoardDTO bandBoardDTO);
		
	public int searchBoardCount(BandBoardDTO bandBoardDTO);

}
