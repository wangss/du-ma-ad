package com.taoren.admin.user.controller;

import com.taoren.admin.base.common.QueryResult;
import com.taoren.admin.base.controller.BaseController;
import com.taoren.common.util.StringUtils;
import com.taoren.common.util.TaorenUtils;

import com.taoren.model.lb.Label;
import com.taoren.model.user.User;
import com.taoren.model.user.UserInfo;
import com.taoren.service.lb.LabelRemoteService;
import com.taoren.service.lb.model.LabelListRespDto;
import com.taoren.service.lb.model.LabelRespDto;
import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.user.MessageRemoteService;
import com.taoren.service.user.UserInfoRemoteService;
import com.taoren.service.user.UserRemoteService;

import com.taoren.service.user.model.EsPositionDto;
import com.taoren.service.user.model.UserInfoListRespDto;
import com.taoren.service.user.model.UserInfoRespDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;


@Scope("prototype")
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    Logger logger = LoggerFactory.getLogger(UserController.class);


    @Autowired
    private UserRemoteService userService;

    @Autowired
    private UserInfoRemoteService userInfoService;

    @Autowired
    private MessageRemoteService messageService;

    @Autowired
    private UserSearchRemoteService userSearchService;

    @Autowired
    LabelRemoteService labelService;



    /**
     * 用户查看资料
     * @throws java.io.IOException
     */
    @RequestMapping(value = "/detail")
    public ModelAndView userShow(HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/detail");

        String uidStr  = request.getParameter("uid");

        if(StringUtils.isEmpty(uidStr)) {
            mav.addObject("resultCode", -1);
        }else {

            long uid = 0L;
            try{
                 uid= Long.parseLong(uidStr);
            }catch (Exception e){
                mav.addObject("resultCode", -2);
                return mav;
            }


            UserInfoRespDto respDto = userInfoService.getUserInfo(uid);

            UserInfo userInfo = respDto.getUserInfo();
            if(respDto == null || respDto.getUserInfo() == null) {
                mav.addObject("resultCode", -3);
            }else{

                try{
                    EsPositionDto positionDto = userSearchService.getUserPosition(uid, null, null);
                    if(positionDto != null){
                        userInfo.setLongitude(positionDto.getLocation().getLon());
                        userInfo.setLatitude(positionDto.getLocation().getLat());
                        userInfo.setArea(positionDto.getArea());
                        userInfo.setActiveTime(positionDto.getActiveTime());
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }


                try{
                    Label label = new Label();
                    label.setUid(uid);


                    LabelListRespDto labelRespDto = labelService.getLabel(label);

                    if(labelRespDto.getResultCode() == 1){
                        mav.addObject("labelList", labelRespDto.getList());
                    }

                }catch (Exception e){
                    e.printStackTrace();
                }

                mav.addObject("userInfo", userInfo);
            }
        }

        return mav;
    }




    /**
     * 用户管理页面
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/page")
    public String userList() throws IOException {
        return "user/user";
    }
    /**
     * 用户查找
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/list")
    public ModelAndView userList(HttpServletRequest request) throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/user");

        try {
            //查询条件
            String uid  = request.getParameter("uid");
            String trId = request.getParameter("trId");
            String areaCode = request.getParameter("areaCode");
            String phone = request.getParameter("phone");
            String nickname = request.getParameter("nickname");
            String status = request.getParameter("status");


            String userType = request.getParameter("userType");

            Map<String, Object> queryParam = new HashMap<String, Object>();


            if(!StringUtils.isEmpty(uid)){
                queryParam.put("uid", Long.parseLong(uid));
            }
            if(!StringUtils.isEmpty(trId)){
                queryParam.put("trId", trId);
            }
            if(!StringUtils.isEmpty(areaCode)){
                queryParam.put("areaCode", Integer.parseInt(areaCode));
            }
            if(!StringUtils.isEmpty(phone)){
                queryParam.put("phone", phone);
            }

            if(!StringUtils.isEmpty(nickname)){
                queryParam.put("nickname", nickname);
            }
            if(!StringUtils.isEmpty(status)){
                queryParam.put("status", Integer.parseInt(status));
            }

            if(!StringUtils.isEmpty(userType)){
                queryParam.put("userType", Integer.parseInt(userType));
            }

            queryParam.put("curr_page", request.getParameter("curr_page"));
            queryParam.put("page_size", request.getParameter("page_size"));

            QueryResult<UserInfo> queryResult = new QueryResult<UserInfo>(queryParam);

            UserInfoListRespDto userInfoRespDto = userInfoService.userInfoList(queryResult.getParam());



            if(userInfoRespDto.getResultCode() == 1){
                queryResult.calculate(userInfoRespDto.getTotalRow());
                queryResult.setList(userInfoRespDto.getList());
            }


            mav.addObject("queryResult", queryResult);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }

    /**
     * 修改用户性别或状态
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/update")
    public String labelDel(
            @RequestParam("uid") Long uid,
            HttpServletRequest request
            )throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("");

        try{

            UserInfo userInfo = new UserInfo();

            String status = request.getParameter("status");
            String gender = request.getParameter("gender");

            String nickname = request.getParameter("nicknameNew");
            String userType = request.getParameter("userType");

            if(!StringUtils.isEmpty(status)){
                userInfo.setStatus(Integer.parseInt(status));
                userInfo.setId(uid);

                UserInfoRespDto respDto = userInfoService.editUserInfo(userInfo);
                try{
                    if(Integer.parseInt(status) == 3){
                        if(respDto.getResultCode() == 1){
                            messageService.sendMessage(uid, "尊敬的淘人用户：因为您的多次违反规定操作，我们不得不强制停止你的帐号的使用,您将无法继续使用该帐号。如果您需要继续使用，请联系我们的客服");
                        }

                    }
                }catch (Exception e){

                }
            }


            if(!StringUtils.isEmpty(userType)){
                UserInfo userOnline = (UserInfo)request.getSession().getAttribute("userOnline");
                if(userOnline.getUserType() == 3){
                    userInfo.setUserType(Integer.parseInt(userType));
                    userInfo.setId(uid);

                    UserInfoRespDto respDto = userInfoService.editUserInfo(userInfo);
                    try{

                            if(respDto.getResultCode() == 1){
                                if(Integer.parseInt(userType) == 1){
                                    messageService.sendMessage(uid, "尊敬的淘人用户：你已经被取消管理员资格，不过您仍旧可以使用我们的app服务，祝您愉快！");
                                }
                                if(Integer.parseInt(userType) == 2){
                                    messageService.sendMessage(uid, "尊敬的淘人用户：你已经被设置为管理员了，您可以从淘人后台登录进行日常管理");
                                }
                            }
                    }catch (Exception e){

                    }
                }
            }


            if(!StringUtils.isEmpty(gender)){
                userInfo.setGender(Integer.parseInt(gender));
                userInfo.setUid(uid);
                userInfoService.editUserInfo(userInfo);
            }
            if(!StringUtils.isEmpty(nickname)){
                userInfo.setNickname(nickname);
                userInfo.setUid(uid);
                userInfoService.editUserInfo(userInfo);
            }

            //更新搜索索引（es）
            try{
                userSearchService.updateUser(userInfo);
            }catch (Exception e){
                //再删除一遍
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:detail" + "?uid=" + uid;

    }


    /**
     * 用户简介
     * @param response
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/userTokenxxx")
    public void nearByUserFind(
            @RequestParam("uid") Long uid,
            HttpServletResponse response)
            throws IOException {
        String token = userService.getTokenByUid(uid);
        User user = userService.getUserbyToken(token);
        if(user != null){
            user.setToken(token);
        }
        responseInfo(response, TaorenUtils.o2jPretty(user, true));
    }

}