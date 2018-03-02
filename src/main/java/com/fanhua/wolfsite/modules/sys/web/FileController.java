package com.fanhua.wolfsite.modules.sys.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fanhua.wolfsite.common.mapper.JsonMapper;
import com.fanhua.wolfsite.common.web.BaseController;
import com.fanhua.wolfsite.common.web.MsgResult;
import com.fanhua.wolfsite.modules.sys.entity.SysFile;
import com.fanhua.wolfsite.modules.sys.entity.User;
import com.fanhua.wolfsite.modules.sys.service.AreaService;
import com.fanhua.wolfsite.modules.sys.service.SysFileService;
import com.fanhua.wolfsite.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/sys/file")
public class FileController extends BaseController {

	@Autowired
	private SysFileService sysFileService;
	
	@ResponseBody
	@RequestMapping(value = "upload")
	public MsgResult upload(SysFile sysfile, HttpServletResponse response,HttpServletRequest request, Model model,RedirectAttributes redirectAttributes) {
		
		MsgResult msResult=new MsgResult();
		
		if(StringUtils.isEmpty(sysfile.getBussinessId())){
			msResult.setMscode("0");
			msResult.setMstext("请先保存表单");
		}
		else{
			sysFileService.save(sysfile);
			msResult.setMscode("1");
			msResult.setMstext("上传成功");
			msResult.setResults(sysfile);
		}
		
		return msResult;	
	}

	@ResponseBody
	@RequestMapping(value = "delete")
	public MsgResult delete(String id) {
		
		MsgResult msResult=new MsgResult();
		
		SysFile sysfile=new SysFile(id);
	
		//sysfile.setDelFlag("1");
		sysfile.setUpdateBy(UserUtils.getUser());
		sysFileService.delete(sysfile);
		msResult.setMscode("1");
		msResult.setMstext("删除成功");
		return msResult;
	}

	@ResponseBody
	@RequestMapping(value = {"list", ""})
	public  List<SysFile>  list(String bussinessId,  HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {


		SysFile sf=new SysFile();
		sf.setBussinessId(bussinessId);
		return sysFileService.findList(sf);
	}
	//
	// @RequestMapping(value = "download")
	// public String download(User user, HttpServletRequest request, Model
	// model, RedirectAttributes redirectAttributes) {
	// return "";
	// }
}
