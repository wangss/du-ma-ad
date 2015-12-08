package com.taoren.admin.user.controller;


import com.taoren.admin.base.common.QueryResult;
import com.taoren.admin.base.controller.BaseController;
import com.taoren.common.util.StringUtils;
import com.taoren.common.util.TaorenUtils;
import com.taoren.model.user.UserInfo;
import com.taoren.model.user.UserReport;
import com.taoren.service.base.model.BaseRespDto;

import com.taoren.service.sc.UserSearchRemoteService;
import com.taoren.service.user.MessageRemoteService;
import com.taoren.service.user.RelationRemoteService;
import com.taoren.service.user.UserRemoteService;
import com.taoren.service.user.UserReportRemoteService;
import com.taoren.service.user.model.UserReportListRespDto;
import com.taoren.service.user.model.UserReportRespDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@Scope("prototype")
@Controller
@RequestMapping("/report")
public class ReportController extends BaseController {
    Logger logger = LoggerFactory.getLogger(ReportController.class);


    @Autowired
    private UserRemoteService userService;

    @Autowired
    private RelationRemoteService relationService;

    @Autowired
    private UserReportRemoteService userReportService;

    @Autowired
    private MessageRemoteService messageService;

    @Autowired
    private UserSearchRemoteService userSearchService;


    /**
     * 用户管理页面
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/page")
    public String userList() throws IOException {
        return "report/report";

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

        try {
            //查询条件
            String uid  = request.getParameter("uid");
            String defendant = request.getParameter("defendant");
            String reason = request.getParameter("reason");
            String status = request.getParameter("status");

            Map<String, Object> queryParam = new HashMap<String, Object>();


            if(!StringUtils.isEmpty(uid)){
                queryParam.put("uid", Long.parseLong(uid));
            }
            if(!StringUtils.isEmpty(defendant)){
                queryParam.put("defendant", Long.parseLong(defendant));
            }
            if(!StringUtils.isEmpty(reason)){
                queryParam.put("reason", Integer.parseInt(reason));
            }

            if(!StringUtils.isEmpty(status)){
                queryParam.put("status", Integer.parseInt(status));
            }

            queryParam.put("curr_page", request.getParameter("curr_page"));
            queryParam.put("page_size", request.getParameter("page_size"));

            QueryResult<UserReport> queryResult = new QueryResult<UserReport>(queryParam);

            UserReportListRespDto userReportRespDto = userReportService.userReportList(queryResult.getParam());



            if(userReportRespDto.getResultCode() == 1){
                queryResult.calculate(userReportRespDto.getTotalRow());
                queryResult.setList(userReportRespDto.getList());
            }

            mav.setViewName("report/report");
            mav.addObject("queryResult", queryResult);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }


    /**
     * 用户查看资料
     * @throws java.io.IOException
     */
    @RequestMapping(value = "/detail")
    public ModelAndView userShow(HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("report/detail");

        try {
            String idStr = request.getParameter("reportId");
            String uidStr = request.getParameter("uid");
            String defendant = request.getParameter("defendant");

            if (StringUtils.isEmpty(idStr) && StringUtils.isEmpty(uidStr) && StringUtils.isEmpty(defendant)) {
                mav.addObject("resultCode", -1);
            }else {

                UserReport userReport = new UserReport();

                if(!StringUtils.isEmpty(idStr)){
                    userReport.setId(Long.parseLong(idStr));
                    mav.addObject("reportId", idStr);
                }
                if(!StringUtils.isEmpty(uidStr)){
                    userReport.setUid(Long.parseLong(uidStr));
                    mav.addObject("uid", uidStr);
                }
                if(!StringUtils.isEmpty(defendant)){
                    userReport.setDefendant(Long.parseLong(defendant));
                    mav.addObject("defendant", defendant);
                }

                UserReportListRespDto respDto = userReportService.getUserReport(userReport);


                if (respDto.getResultCode() == 1) {
                    mav.addObject("reportList", respDto.getList());
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
     * 通知被举报人
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/notice")
    public String notice(
            @RequestParam("reportId") Long reportId,
            @RequestParam("defendant") Long defendant,
            @RequestParam("reason") Integer reason,
            @RequestParam("params") String params,
            HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("");

        try{
            UserReport userReport = new UserReport();
            userReport.setId(reportId);
            userReport.setHaveNoticed(1);


            UserReportRespDto respDto = userReportService.editUserReport(userReport);
            if(respDto.getResultCode() == 1){
                String msg = "尊敬的淘人用户，您已被举报发布[";

                switch (reason){
                    case 1: msg += "色情信息";break;
                    case 2: msg += "骚扰信息";break;
                    case 3: msg += "虚假广告";break;
                    case 4: msg += "欺诈信息";break;
                    case 5: msg += "其它";break;
                }
                msg += "] 等不良信息, 我们将会进一步核实。如果情况属实，请立即停止此类活动，保持友善礼貌合法的社交行为，否则我们将会进行强制处理。 如果没有，欢迎您继续使用我们的服务，祝您愉快！";


                messageService.sendMessage(defendant, msg);
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:detail?" + params;
    }

    /**
     * 状态
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String labelDel(
            @RequestParam("reportId") Long reportId,
            @RequestParam("uid") Long uid,
            @RequestParam("status") Integer status,
            @RequestParam("msg") String msg,
            @RequestParam("params") String params,
            HttpServletRequest request)throws IOException {

        ModelAndView mav = new ModelAndView();
        mav.setViewName("");

        try{

            UserReport userReport = new UserReport();
            userReport.setId(reportId);
            userReport.setStatus(status);
            String note = request.getParameter("note");
            if(StringUtils.isEmpty(note)){
                userReport.setMsg(msg + note);
            }

            UserInfo userInfo = (UserInfo)(request.getSession().getAttribute("userInfo"));
            userReport.setOperator(userInfo.getUid());


            UserReportRespDto respDto = userReportService.editUserReport(userReport);
            if(respDto.getResultCode() == 1){

                 String text = "尊敬的淘人用户：";
                switch (status){
                    case 2: text += "您的举报我们已经收到，我们会尽快处理,感谢您的使用，祝您愉快！"; break;
                    case 3: text += "您的举报我们已经处理，感谢您的支持，祝您愉快！"; ;break;
                    case 4: text += "您的举报我们已经处理，感谢您的使用，祝您愉快！"; ;break;
                }

                messageService.sendMessage(uid, text);
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:detail?" + params;
    }

    /**
     * 状态
     * @throws IOException
     * @Author wangshuisheng
     */
    @RequestMapping(value = "/msgTest", method = RequestMethod.GET)
    public void labelDel(
            @RequestParam("uid") Long uid,
            @RequestParam("msg") String msg)throws IOException {
        messageService.sendMessage(uid, msg);

    }

}