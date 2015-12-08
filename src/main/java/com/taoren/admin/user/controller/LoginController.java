package com.taoren.admin.user.controller;


import com.taoren.admin.base.controller.BaseController;
import com.taoren.common.util.TaorenUtils;

import com.taoren.model.user.User;
import com.taoren.model.user.UserInfo;
import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.user.LoginRemoteService;
import com.taoren.service.user.UserRemoteService;
import com.taoren.service.user.model.LoginRespDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


/**
 *
 * wangshuisheng
 */
@Scope("prototype")
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController{
    Logger logger = LoggerFactory.getLogger(LoginController.class);


    @Autowired
    private LoginRemoteService loginService;

    @Autowired
    private UserRemoteService userService;

    @Autowired
    private UserSearchRemoteService userSearchService;


    /**
     * 用户登录
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/in")
    public String login(
            @RequestParam(value="phone", required=false) String phone,
            @RequestParam(value="trId", required=false) String trId,
            @RequestParam("password") String password,
                                    HttpServletRequest request)throws IOException {

        String json = "";

        User user = new User();

        user.setPhone(phone);
        user.setTrId(trId);
        user.setPassword(password);


        LoginRespDto loginRespDto = loginService.loginAdmin(user);

        if(loginRespDto.getResultCode() == 1){//表示登录成功
            UserInfo userInfo = loginRespDto.getUserInfo();
            request.getSession().setAttribute("userOnline", userInfo);
            return "common/head";
        }else{
            return "../login";
        }

    }


    /**
     * 用户登录
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/out")
    public String login(
            HttpServletRequest request)throws IOException {

        request.getSession().removeAttribute("userOnline");
        return "../login";
    }

}