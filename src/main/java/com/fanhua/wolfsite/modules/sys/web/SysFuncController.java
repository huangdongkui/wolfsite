/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.web;

import com.fanhua.wolfsite.common.persistence.PageResult;
import com.fanhua.wolfsite.common.persistence.ResultVo;
import com.fanhua.wolfsite.common.utils.StringUtils;
import com.fanhua.wolfsite.common.web.BaseController;
import com.fanhua.wolfsite.modules.sys.entity.SysFunc;
import com.fanhua.wolfsite.modules.sys.service.SysFuncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

/**
 * 功能按钮Controller
 *
 * @author huangdk
 * @version 2017-08-19
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysFunc")
public class SysFuncController extends BaseController {

    @Autowired
    private SysFuncService sysFuncService;


    @RequestMapping(value = {"list"})
    public String list() {
        return "modules/sys/sysFuncList";
    }

    @RequestMapping(value = {"lists"},method= RequestMethod.GET)
    @ResponseBody
    public PageResult lists(SysFunc sysFunc, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        //解析搜索表单
        String p_where_string = StringUtils.genWhere(request.getParameter("searchParams"));

        String selectSql="select *,(select name from sys_user where id=create_by) as create_by_name from sys_func where del_flag=0";
        PageResult pageResult = new PageResult();
        HashMap hashMap = new HashMap();
        hashMap.put("p_table_name", selectSql);
        hashMap.put("p_fields", "*");
        hashMap.put("p_page_size", request.getParameter("limit"));
        hashMap.put("p_page_no", request.getParameter("offset"));
        hashMap.put("p_order_string", "create_date");
        hashMap.put("p_where_string", p_where_string);
        pageResult.setRows(sysFuncService.listPage(hashMap));
        return pageResult;
    }

    @RequestMapping(method=RequestMethod.GET)
    public String form(SysFunc sysFunc, Model model) {
        SysFunc entity = null;
        if (StringUtils.isNotBlank(sysFunc.getId())) {
            entity = sysFuncService.get(sysFunc.getId());
        }
        if (entity == null) {
            entity = new SysFunc();
        }
        model.addAttribute("sysFunc", entity);
		return "modules/sys/sysFuncForm";
    }


    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public ResultVo save(SysFunc sysFunc, Model model, RedirectAttributes redirectAttributes) {
        ResultVo r = new ResultVo();
        if (!beanValidator(model, sysFunc)) {
            return r.error(1, model.asMap().toString());
        }

        try {
            sysFuncService.save(sysFunc);
            return r.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return r.error(1, e.getMessage());
        }

    }


    @RequestMapping(method =RequestMethod.DELETE)
    @ResponseBody
    public ResultVo dalete(SysFunc sysFunc) {
        ResultVo r = new ResultVo();
   
        try {
            sysFuncService.delete(sysFunc);
            return r.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return r.error(1, "删除失败");
        }

    }


}