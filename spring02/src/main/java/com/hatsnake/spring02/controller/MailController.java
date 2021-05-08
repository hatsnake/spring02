package com.hatsnake.spring02.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailController {

	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/sendMail", method = RequestMethod.GET)
  public void sendMailTest() throws Exception{    
    String subject = "test 메일";
    String content = "메일 테스트 내용";
    String from = "springemailtest123@gmail.com";
    String to = "hatsnake@naver.com";
    
    try {
      MimeMessage mail = mailSender.createMimeMessage();
      MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
      // true는 멀티파트 메세지를 사용하겠다는 의미
      
      /*
       * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
       * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
       */
      
      mailHelper.setFrom(from);
      // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
      // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
      //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
      mailHelper.setTo(to);
      mailHelper.setSubject(subject);
      mailHelper.setText(content, true);
      // true는 html을 사용하겠다는 의미입니다.
      
      /*
       * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
       */
      
      mailSender.send(mail); 
    } catch(Exception e) {
      e.printStackTrace();
    }
  }	
	
	//이메일 인증
	@RequestMapping(value="/mailCheck", method=RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {
		logger.info("이메일 데이터전송 확인");
		logger.info("인증아이디 : "+email);
		
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		logger.info("인증번호 : "+checkNum);
		
    String setFrom = "springemailtest123@gmail.com";
    String toMail = email;
    String title = "회원가입 인증 이메일입니다.";
    String content = 
    		"홈페이지를 방문해주셔서 감사합니다."+
    		"<br><br>"+
    		"인증 번호는 "+checkNum+"입니다."+
    		"<br>"+
    		"해당 인증번호를 인증번호 확인란에 기입해 주세요.";
    
    try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
      helper.setFrom(setFrom);
      helper.setTo(toMail);
      helper.setSubject(title);
      helper.setText(content,true);
      mailSender.send(message);
	  }catch(Exception e) {
	      e.printStackTrace();
	  }
    
    String num = Integer.toString(checkNum);
    return num;
	}
	
}
