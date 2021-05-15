package com.hatsnake.spring02.common.security;

import javax.annotation.Resource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;

@Service("shaEncoder")
public class ShaEncoder {

 @Resource(name="passwordEncoder")
 private ShaPasswordEncoder encoder;

 public String encoding(String str){
  return encoder.encodePassword(str,null);
 }

 public String saltEncoding(String str,String salt){
  return encoder.encodePassword(str,salt);
 }
}