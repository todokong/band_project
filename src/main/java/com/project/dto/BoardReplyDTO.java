package com.project.dto;

public class BoardReplyDTO {		
	private int bandcode;
	private int boardcode;
	private String userid;
	private String username;
	private int replycode;
	private String replycontent;
	private String replydate;
	public int getBoardcode() {
		return boardcode;
	}
	public void setBoardcode(int boardcode) {
		this.boardcode = boardcode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getReplycode() {
		return replycode;
	}
	public void setReplycode(int replycode) {
		this.replycode = replycode;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getReplycontent() {
		return replycontent;
	}
	public void setReplycontent(String replycontent) {
		this.replycontent = replycontent;
	}
	public int getBandcode() {
		return bandcode;
	}
	public void setBandcode(int bandcode) {
		this.bandcode = bandcode;
	}
	public String getReplydate() {
		return replydate;
	}
	public void setReplydate(String replydate) {
		this.replydate = replydate;
	}
	
}
