package com.taoren.admin.nearby.controller;

import com.taoren.admin.base.controller.BaseController;
import com.taoren.admin.util.GsonUtil;
import com.taoren.common.util.StringUtils;
import com.taoren.common.util.TaorenUtils;
import com.taoren.service.sc.NearByAskingSearchRemoteService;
import com.taoren.service.sc.NearBySearchRemoteService;
import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.sc.model.SearchParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


/**
 *
 * wangshuisheng
 */
@Scope("prototype")
@Controller
@RequestMapping("/search")
public class NearbyController extends BaseController{

    Logger logger = LoggerFactory.getLogger(NearbyController.class);

    @Autowired
    NearBySearchRemoteService nearBySearchService;

    @Autowired
    NearByAskingSearchRemoteService nearByAskingSearchService;

    @Autowired
    protected UserSearchRemoteService userSearchService;



    /**
     * 用户管理页面
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/page")
    public String page() throws IOException {
        return "search/search";
    }

    /**
     *
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/search")
    public ModelAndView nearbyLabel(
            @ModelAttribute SearchParams searchParams)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("search/search");
        mav.addObject("searchParams", searchParams);
        if(searchParams.getLat() == null && searchParams.getLon() == null){
            mav.addObject("content", "需要输入经纬度");
        }else {
            mav.addObject("content", TaorenUtils.o2jPretty(nearBySearchService.nearByLabel(searchParams), true));
        }

        return mav;
    }



    /**
     * 用户简介
     * @param response
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/search2")
    public ModelAndView nearByUserFind(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("search/search");

        String ids = request.getParameter("ids");
        String trId = request.getParameter("trId");

        mav.addObject("ids", ids);
        mav.addObject("trId", trId);

        if(!StringUtils.isEmpty(trId)){
                    mav.addObject("content", TaorenUtils.o2jPretty(userSearchService.findUserByTrId(trId), true));
        }else {
            String json = "[]";
            if(StringUtils.areNotEmpty(ids)){

                List<String> idList = Arrays.asList(ids.split(","));
                if(idList.size() > 20){
                    idList = idList.subList(0, 20);
                }
                mav.addObject("content", TaorenUtils.o2jPretty(userSearchService.findUsersByIds(idList), true));

            }
        }

        return mav;
    }

    /**
     *
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/asking")
    public ModelAndView nearbyAsking(
            @ModelAttribute SearchParams searchParams)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("search/search");
        mav.addObject("searchParams", searchParams);
        if(searchParams.getLat() == null && searchParams.getLon() == null){
            mav.addObject("content", "需要输入经纬度");
        }else {
            mav.addObject("content", TaorenUtils.o2jPretty(nearByAskingSearchService.nearByAsking(searchParams), true));
        }


        return mav;
    }

    /**
     * 用户简介
     * @param response
     * @throws java.io.IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/reIndex")
    public ModelAndView reIndex(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("search/reIndex");

        String ids = request.getParameter("ids");

        if(!StringUtils.isEmpty(ids)){
            mav.addObject("ids", ids);

            List<String> idList = Arrays.asList(ids.split("\n"));

            String content = "";
            for(int i=0; i<idList.size(); i++){
                String id = idList.get(i).trim();

                try{
                     userSearchService.reIndexUser(Long.parseLong(id));
                    content += id  + ": OK\n";
                }catch (Exception e){
                    content += id  + ": " + "error\n";
                }
            }
            mav.addObject("content", content);
        }

        return mav;
    }

}