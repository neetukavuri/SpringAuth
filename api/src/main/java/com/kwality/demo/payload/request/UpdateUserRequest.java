package com.kwality.demo.payload.request;

import javax.validation.constraints.NotBlank;

public class UpdateUserRequest extends SignUpRequest{

	@NotBlank
	private Long id;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
}
