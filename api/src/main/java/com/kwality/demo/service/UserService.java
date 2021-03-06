package com.kwality.demo.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	
	
	@Autowired
	private UserRepository userRepository;
	
	public void updateUser (UpdateUserRequest request) throws Exception
	{
		User dbUser = userRepository.getOne(request.getId());
		dbUser.setEmail(request.getEmail());
	}
	
	
	@Scheduled(fixedDelay = 60000)
	public void getUsers() {
		System.out.println("finding users");
		List<User> users = userRepository.findAll();
		System.out.println("Found users " + users);
		try {
			System.out.println("HostAndPort :" + getHostAndPort());
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
