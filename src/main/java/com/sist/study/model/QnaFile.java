package com.sist.study.model;

import java.io.Serializable;

public class QnaFile implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private long qnaBoardSeq;
	private long qnaBoardFileSeq;
	private String fileOrgName;
	private String fileName;
	private String fileExt;
	private long fileSize;
	private String regDate;
	
	public QnaFile()
	{
		qnaBoardSeq = 0;
		qnaBoardFileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regDate = "";
	}

	public long getqnaBoardSeq() {
		return qnaBoardSeq;
	}

	public void setqnaBoardSeq(long qnaBoardSeq) {
		this.qnaBoardSeq = qnaBoardSeq;
	}

	public long getQnaBoardFileSeq() {
		return qnaBoardFileSeq;
	}

	public void setQnaBoardFileSeq(long qnaboardFileSeq) {
		this.qnaBoardFileSeq = qnaboardFileSeq;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

}
