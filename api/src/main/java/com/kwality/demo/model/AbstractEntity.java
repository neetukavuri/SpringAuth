package com.kwality.demo.model;

import java.util.Date;

import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;

import org.springframework.security.core.context.SecurityContextHolder;

@MappedSuperclass
public abstract class AbstractEntity {

	private String createdBy;
	private Date createdDate;
	private String modifiedBy;
	private Date modifiedDate;
	
	@PrePersist
	public void populateModifiedFields () {
		
		if (getId() == null)
		{
			createdBy = getUsername ();
			createdDate = new Date ();
		}
		
		modifiedDate = new Date();
		modifiedBy = getUsername();
	}
	
	private String getUsername () {
		
		if (SecurityContextHolder.getContext() != null 
				&& SecurityContextHolder.getContext().getAuthentication() != null
				&& SecurityContextHolder.getContext().getAuthentication().getPrincipal() != null)
		{
			return SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString();
		}
		
		return "Anonymous";
	}

	public abstract Long getId ();
	
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
}
