package com.taoren.admin.asking.controller;

import com.taoren.admin.base.common.QueryResult;
import com.taoren.admin.base.controller.BaseController;
import com.taoren.common.util.StringUtils;
import com.taoren.model.ask.Asking;
import com.taoren.model.lb.Label;
import com.taoren.service.ask.AskingRemoteService;
import com.taoren.service.ask.model.AskingListRespDto;
import com.taoren.service.ask.model.AskingRespDto;
import com.taoren.service.lb.LabelRemoteService;
import com.taoren.service.lb.model.LabelListRespDto;
import com.taoren.service.lb.model.LabelRespDto;
import com.taoren.service.sc.AskingSearchRemoteService;
import com.taoren.service.sc.LabelSearchRemoteService;
import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.user.MessageRemoteService;
import com.taoren.service.user.UserRemoteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
@RequestMapping("/asking")
public class AskingController extends BaseController{
    Logger logger = LoggerFactory.getLogger(AskingController.class);


    @Autowired
    AskingRemoteService askingService;

    @Autowired
    UserRemoteService userService;

    @Autowired
    private MessageRemoteService messageService;

    @Autowired
    AskingSearchRemoteService askingSearchService;


    /**
     * 用户查看资料
     * @throws IOException
     */
    @RequestMapping(value = "/detail")
    public ModelAndView userShow(HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("asking/detail");


        try {
            String uidStr = request.getParameter("uid");
            String askingIdStr = request.getParameter("askingId");

            if (StringUtils.isEmpty(uidStr) && StringUtils.isEmpty(askingIdStr)) {
                mav.addObject("resultCode", -1);
            } else {

                Asking asking = new Asking();

                if (!StringUtils.isEmpty(uidStr)) {
                    asking.setUid(Long.parseLong(uidStr));
                }

                if (!StringUtils.isEmpty(askingIdStr)) {
                    asking.setId(Long.parseLong(askingIdStr));
                }


                AskingListRespDto askingListRespDto = askingService.getAsking(asking);

                mav.addObject("uid", uidStr);
                mav.addObject("askingId", askingIdStr);

                if (askingListRespDto.getResultCode() == 1) {
                    mav.addObject("askingList", askingListRespDto.getList());
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
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/page")
    public String userList() throws IOException {
        return "asking/asking";

    }
    /**
     * 用户查找
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/list")
    public ModelAndView userList(
            HttpServletRequest request)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("asking/asking");
        try {
            //查询条件
            String uid  = request.getParameter("uid");
            String askingId = request.getParameter("askingId");

            Map<String, Object> queryParam = new HashMap<String, Object>();


            if(!StringUtils.isEmpty(uid)){
                queryParam.put("uid", Long.parseLong(uid));
            }
            if(!StringUtils.isEmpty(askingId)){
                queryParam.put("askingId", Long.parseLong(askingId));
            }
            queryParam.put("curr_page", request.getParameter("curr_page"));
            queryParam.put("page_size", request.getParameter("page_size"));

            QueryResult<Asking> queryResult = new QueryResult<Asking>(queryParam);

            AskingListRespDto askingListRespDto = askingService.askingList(queryParam);


            if(askingListRespDto.getResultCode() == 1){
                queryResult.calculate(askingListRespDto.getTotalRow());
                queryResult.setList(askingListRespDto.getList());
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
    public String askingDel(
            @RequestParam("uid") Long uid,
            @RequestParam("askingId") Long askingId,
            @RequestParam("from") String from)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName(from);

        try{
            Asking asking = new Asking();
            asking.setId(askingId);
            asking.setUid(uid);
            System.out.println("OK");

            AskingRespDto dto = askingService.delAsking(asking);

            //删除搜索索引（es）
            try{

                if(dto.getResultCode() == 1){

                    try {
                        messageService.sendMessage(uid, "尊敬的淘人用户：因您发布了不良喊话，我们已经强制删除。请保持友善礼貌合法的社交行为，欢迎您继续使用我们的服务，祝您愉快！");
                    }catch (Exception e){

                    }

                    askingSearchService.deleteAsking(asking.getUid(), asking.getId());
                }
            }catch (Exception e){
                //再删除一遍
                if(dto.getResultCode() == 1){
                    askingSearchService.deleteAsking(asking.getUid(), asking.getId());
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:/" + from + "?uid=" + uid;

    }

}


