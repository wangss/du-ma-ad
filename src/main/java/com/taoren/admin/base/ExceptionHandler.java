package com.taoren.admin.base;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class ExceptionHandler implements HandlerExceptionResolver {
  
    @Override
    public ModelAndView resolveException(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex){
        // TODO Auto-generated method stub
        try{
            response.getWriter().print("aaa");
        }catch (IOException ioe){

        }

        return null;
    }


}