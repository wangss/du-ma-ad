package com.taoren.admin.base.interceptor;

import com.taoren.model.user.UserInfo;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by wangshuisheng on 2015/9/25.
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userOnline");
        if(userInfo == null || userInfo.getUid() == null || userInfo.getUserType() == null || userInfo.getUserType() == 1){
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return false;
        }else{
            return true;
        }


    }
}
