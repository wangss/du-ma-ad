package com.taoren.admin.base.controller;

import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * controller 基础类
 */
public class BaseController {

    public void responseInfo(HttpServletResponse response, String info) throws IOException{
        response.setContentType("text/html;charset=utf-8");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().print(info);
    }

}