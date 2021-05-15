package com.hatsnake.spring02.common.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Component
@Aspect
public class MessageAdvice {
	private static final Logger logger = LoggerFactory.getLogger(MessageAdvice.class);
	
	//매개변수 확인, @Before(대상:호출전)
	@Before("execution(* com.hatsnake.spring02.service.message.MessageService*.*(..))")
	public void startLog(JoinPoint jp) {
		//핵심업무의 클래스,메소드,매개변수 로깅
		logger.info("핵심업무 코드정보 : "+jp.getSignature());
		logger.info("메소드 : "+jp.getSignature().getName());
		logger.info("매개변수 : "+Arrays.toString(jp.getArgs()));
	}
	
	//method 실행 시간 확인,@Around:핵심업무 전후에 자동호출, ProceedingJoinPoint
	@Around("execution(* com.hatsnake.spring02.service.message.MessageService*.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		//핵심업무 실행 전
		long start = System.currentTimeMillis();
		//핵심업무 실행
		Object result = pjp.proceed();
		//핵심업무 실행 후
		long end = System.currentTimeMillis();
		//핵심업무 실행시간 연산
		logger.info(pjp.getSignature().getName()+"메소드 실행시간 : "+(end-start));
		logger.info("=====================================");
		return result;
	}
}
