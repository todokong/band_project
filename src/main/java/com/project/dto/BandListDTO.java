package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

public class BandListDTO {
	private int bandcode;
	private String bandname;
	private String bandinfo;
	private String bandimage;
	private MultipartFile upfile;
	public int getBandcode() {
		return bandcode;
	}
	public void setBandcode(int bandcode) {
		this.bandcode = bandcode;
	}
	public String getBandname() {
		return bandname;
	}
	public void setBandname(String bandname) {
		this.bandname = bandname;
	}
	public String getBandimage() {
		return bandimage;
	}
	public void setBandimage(String bandimage) {
		this.bandimage = bandimage;
	}
	public String getBandinfo() {
		return bandinfo;
	}
	public void setBandinfo(String bandinfo) {
		this.bandinfo = bandinfo;
	}
	public MultipartFile getUpfile() {
		return upfile;
	}
	public void setUpfile(MultipartFile upfile) {
		this.upfile = upfile;
	}
	
}
