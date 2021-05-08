package com.hatsnake.spring02.common.error;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/error")
public class CommonErrorController {
	@RequestMapping("/404")
	public String errorPage404(Model model) {
		String title = "404에러";
		String content = "없는 페이지입니다.";
		model.addAttribute("errMsgTitle", title);
		model.addAttribute("errMsgContent", content);
		return "error/errorPage";
	}
}
