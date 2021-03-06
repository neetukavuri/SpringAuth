package com.kwality.demo.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
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
	Environment environment;

	// Port via annotation
	//@Value('${server.port}')
	//int aPort;
    Logger logger = LoggerFactory.getLogger(UserService.class);

	
	@Autowired
	private UserRepository userRepository;
	
	public void updateUser (UpdateUserRequest request) throws Exception
	{
		User dbUser = userRepository.getOne(request.getId());
		dbUser.setEmail(request.getEmail());
	}
	
	
	@Scheduled(fixedDelay = 60000)
	public void getUsers() {
		logger.error("finding users");
		List<User> users = userRepository.findAll();
		logger.error("Found users " + users);
		try {
			logger.error("HostAndPort :"  + getHostAndPort());
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private String getHostAndPort() throws UnknownHostException {
	    // Port
	    String port = environment.getProperty("local.server.port");
	    
	    // Local address
	    String ip = InetAddress.getLocalHost().getHostAddress();
	    String hostName = InetAddress.getLocalHost().getHostName();
	    
	    // Remote address
	    String lip= InetAddress.getLoopbackAddress().getHostAddress();
	    String lHostName = InetAddress.getLoopbackAddress().getHostName();
	    
	    StringBuilder ret = new StringBuilder()
	    		.append(" IP: ")
	    		.append(ip)
	    		.append(" Port: ")
	    		.append(port)
	    		.append(" Host: ").append(hostName)
	    		.append(" LoopBack IP: ")
	    		.append(lip)
	    		.append(" LoopBack Host: ").append(lHostName);
	    return ret.toString();
	}
	
}
