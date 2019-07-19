package com.project.dto;

public class BandFrontDTO {
	 private int bandcode;
	 private String bandname;
	 private String bandimage;
	 private int bandcount;
	 
	
	public BandFrontDTO(int bandcode, String bandname, String bandimage, int bandcount) {
		super();
		this.bandcode = bandcode;
		this.bandname = bandname;
		this.bandimage = bandimage;
		this.bandcount = bandcount;
	}
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
	public int getBandcount() {
		return bandcount;
	}
	public void setBandcount(int bandcount) {
		this.bandcount = bandcount;
	}
	 
	 
}
