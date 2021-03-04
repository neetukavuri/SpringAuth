package com.kwality.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kwality.demo.model.User;
import com.kwality.demo.payload.request.UpdateUserRequest;
import com.kwality.demo.repository.UserRepository;

@Service
@Transactional (propagation = Propagation.REQUIRED)
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	public void updateUser (UpdateUserRequest request) throws Exception
	{
		User dbUser = userRepository.getOne(request.getId());
		dbUser.setEmail(request.getEmail());
	}
	
}
