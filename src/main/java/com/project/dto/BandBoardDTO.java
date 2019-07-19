package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

public class BandBoardDTO extends Paging{
	private int bandcode;
	private String userid;
	private String username;
	private int boardcode;
	private String boardcontent;
	private String boarddate;
	private String boardimage;
	private MultipartFile file;
	private String bandname;
	   public String getBandname() {
	      return bandname;
	   }
	   public void setBandname(String bandname) {
	      this.bandname = bandname;
	   }
	public int getBandcode() {
		return bandcode;
	}
	public void setBandcode(int bandcode) {
		this.bandcode = bandcode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getBoardcode() {
		return boardcode;
	}
	public void setBoardcode(int boardcode) {
		this.boardcode = boardcode;
	}
	public String getBoardcontent() {
		return boardcontent;
	}
	public void setBoardcontent(String boardcontent) {
		this.boardcontent = boardcontent;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getBoarddate() {
		return boarddate;
	}
	public void setBoarddate(String boarddate) {
		this.boarddate = boarddate;
	}
	public String getBoardimage() {
		return boardimage;
	}
	public void setBoardimage(String boardimage) {
		this.boardimage = boardimage;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
