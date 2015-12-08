package com.taoren.admin.label.controller;

import com.taoren.admin.base.common.QueryResult;
import com.taoren.admin.base.controller.BaseController;
import com.taoren.common.util.StringUtils;

import com.taoren.model.lb.Label;
import com.taoren.service.lb.LabelRemoteService;
import com.taoren.service.lb.model.LabelListRespDto;
import com.taoren.service.lb.model.LabelRespDto;

import com.taoren.service.sc.LabelSearchRemoteService;
import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.user.MessageRemoteService;
import com.taoren.service.user.UserRemoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


/**
 *
 * wangshuisheng
 */
@Scope("prototype")
@Controller
@RequestMapping("/label")
public class LabelController extends BaseController{
    Logger logger = LoggerFactory.getLogger(LabelController.class);


    @Autowired
    LabelRemoteService labelService;

    @Autowired
    UserRemoteService userService;

    @Autowired
    private MessageRemoteService messageService;

    @Autowired
    LabelSearchRemoteService labelSearchService;

    @Autowired
    private UserSearchRemoteService userSearchService;

    /**
     * 用户查看资料
     * @throws java.io.IOException
     */
    @RequestMapping(value = "/detail")
    public ModelAndView userShow(HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("label/detail");


        try {
            String uidStr = request.getParameter("uid");
            String lableIdStr = request.getParameter("labelId");

            if (StringUtils.isEmpty(uidStr) && StringUtils.isEmpty(lableIdStr)) {
                mav.addObject("resultCode", -1);
            } else {

                Label label = new Label();

                if (!StringUtils.isEmpty(uidStr)) {
                    label.setUid(Long.parseLong(uidStr));
                }

                if (!StringUtils.isEmpty(lableIdStr)) {
                    label.setId(Long.parseLong(lableIdStr));
                }


                LabelListRespDto labelListRespDto = labelService.getLabel(label);

                mav.addObject("uid", uidStr);
                mav.addObject("labelId", lableIdStr);

                if (labelListRespDto.getResultCode() == 1) {
                    mav.addObject("labelList", labelListRespDto.getList());
                }else {
                    mav.addObject("resultCode", -3);
                }
            }
        }catch (NumberFormatException e){
            mav.addObject("resultCode", -2);
        }catch (Exception e){
            e.printStackTrace();
            mav.addObject("resultCode", -4);
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
        return "label/label";

    }
    /**
     * 用户查找
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/list")
    public ModelAndView userList(
            HttpServletRequest request)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("label/label");
        try {
            //查询条件
            String uid  = request.getParameter("uid");
            String labelId = request.getParameter("labelId");
            String labelName = request.getParameter("labelName");

            Map<String, Object> queryParam = new HashMap<String, Object>();


            if(!StringUtils.isEmpty(uid)){
                queryParam.put("uid", Long.parseLong(uid));
            }
            if(!StringUtils.isEmpty(labelId)){
                queryParam.put("labelId", Long.parseLong(labelId));
            }
            if(!StringUtils.isEmpty(labelName)){
                queryParam.put("labelName", labelName);
            }

            queryParam.put("curr_page", request.getParameter("curr_page"));
            queryParam.put("page_size", request.getParameter("page_size"));

            QueryResult<Label> queryResult = new QueryResult<Label>(queryParam);

            LabelListRespDto labelListRespDto = labelService.labelList(queryParam);


            if(labelListRespDto.getResultCode() == 1){
                queryResult.calculate(labelListRespDto.getTotalRow());
                queryResult.setList(labelListRespDto.getList());
            }


            mav.addObject("queryResult", queryResult);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }


    /**
     * 强制删除
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/del")
    public String labelDel(
            @RequestParam("uid") Long uid,
            @RequestParam("labelId") Long labelId,
            @RequestParam("from") String from)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName(from);

        try{
            Label label = new Label();
            label.setId(labelId);
            label.setUid(uid);
            System.out.println("OK");

            LabelRespDto dto = labelService.delLabel(label);

            //删除搜索索引（es）
            try{

                if(dto.getResultCode() == 1){

                    try {
                        messageService.sendMessage(uid, "尊敬的淘人用户：因您发布了不良标签，我们已经强制删除。请保持友善礼貌合法的社交行为，欢迎您继续使用我们的服务，祝您愉快！");
                    }catch (Exception e){

                    }

                    labelSearchService.deleteLabel(label.getUid(), label.getId());
                }
            }catch (Exception e){
                //再删除一遍
                if(dto.getResultCode() == 1){
                    labelSearchService.deleteLabel(label.getUid(), label.getId());
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:/" + from + "?uid=" + uid;

    }

}


