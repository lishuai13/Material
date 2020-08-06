package controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Material;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.MaterialService;
import utils.JsonUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MaterialController {

    @Autowired
    MaterialService materialService;

    @RequestMapping({"/","/main"})
    public String test(Model model,@RequestParam(defaultValue = "1",value = "pageNum") Integer pageNum){
        PageHelper.startPage(pageNum,5);
        List<Material> list = materialService.test();
        PageInfo<Material> pageInfo = new PageInfo<>(list);
        model.addAttribute("pageInfo",pageInfo);
        return "main";
    }

    @RequestMapping({"/selectMaterial"})
    public String selectMaterial(Model model,@RequestParam(defaultValue = "1",value = "pageNum") Integer pageNum,HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        if (request.getParameter("itemCode") != null)
            map.put("itemCode","%"+request.getParameter("itemCode")+"%");
        if (request.getParameter("itemDescription") != null)
            map.put("itemDescription","%"+request.getParameter("itemDescription")+"%");
        if (request.getParameter("itemUom") != null)
            map.put("itemUom",request.getParameter("itemUom"));
        if (request.getParameter("startActiveDate") != null)
            map.put("startActiveDate", request.getParameter("startActiveDate"));
        if (request.getParameter("endActiveDate") != null)
            map.put("endActiveDate", request.getParameter("endActiveDate"));
        if (request.getParameter("enabledFlag") != null)
            map.put("enabledFlag",request.getParameter("enabledFlag"));

        PageHelper.startPage(pageNum,5);
        List<Material> list = materialService.selectMaterial(map);
        PageInfo<Material> pageInfo = new PageInfo<>(list);
        model.addAttribute("pageInfo",pageInfo);
        return "main";
    }

    @ResponseBody
    @RequestMapping("/editMaterial")
    public String editMaterial(@Validated Material material, BindingResult bindingResult,HttpServletRequest request){
        // 如果校验时有不符合校验规则的情况出现，springMVC会将错误信息放在BindingResult对象的错误提示信息里面
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            String message = null;
            for (FieldError error : errors) {
                message=error.getDefaultMessage()+"\n";
            }
            return message;
        }
        else {
        Map<String,Object> map = new HashMap<>();
        map.put("itemId",request.getParameter("itemId"));
        map.put("itemCode",request.getParameter("itemCode"));
        map.put("itemDescription",request.getParameter("itemDescription"));
        map.put("itemUom",request.getParameter("itemUom"));
        if (request.getParameter("startActiveDate") != null)
            map.put("startActiveDate", request.getParameter("startActiveDate"));
        if (request.getParameter("endActiveDate") != null)
            map.put("endActiveDate", request.getParameter("endActiveDate"));
        map.put("startActiveDate",request.getParameter("startActiveDate"));
        map.put("endActiveDate",request.getParameter("endActiveDate"));
        map.put("enabledFlag",request.getParameter("enabledFlag"));
        map.put("lastUpdateDate",new Date());
        materialService.editMaterial(map);
        return JsonUtils.getJson("修改了一条数据");
        }
    }


    @ResponseBody
    @RequestMapping("/deleteMaterial")
    public int deleteMaterial(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        int i= 0;
        for (String id : ids) {
            System.out.println(id);
            materialService.deleteMaterial(Integer.parseInt(id));
            i++;
        }
        return i;
    }

    @ResponseBody
    @RequestMapping("/findMaterial")
    public Material findMaterial(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        Material material = materialService.findMaterial(Integer.parseInt(ids[0]));
        System.out.println(material.toString());
        return material;
    }

    @ResponseBody
    @RequestMapping("/addMaterial")
    public String addMaterial(@Validated Material material, BindingResult bindingResult,
                           HttpServletRequest request){
        // 如果校验时有不符合校验规则的情况出现，springMVC会将错误信息放在BindingResult对象的错误提示信息里面
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            String message = null;
            for (FieldError error : errors) {
                message=error.getDefaultMessage()+"\n";
            }
            return message;
        }
        else {
            Map<String, Object> map = new HashMap<>();

            String maxId = materialService.findMaxId();
            String[] s = maxId.split("_");
            map.put("itemCode", s[0] + "_" + (Integer.parseInt(s[1]) + 1));

            map.put("itemDescription", request.getParameter("itemDescription"));
            map.put("itemUom", request.getParameter("itemUom"));

            if (request.getParameter("startActiveDate") != null)
                map.put("startActiveDate", request.getParameter("startActiveDate"));
            if (request.getParameter("endActiveDate") != null)
                map.put("endActiveDate", request.getParameter("endActiveDate"));

            map.put("endActiveDate", request.getParameter("endActiveDate"));
            map.put("enabledFlag", request.getParameter("enabledFlag"));
            map.put("objectVersionNumber", 1);
            map.put("creationDate", new Date());
            map.put("createBy", -1);
            map.put("lastUpdatedBy", -1);
            map.put("lastUpdateDate", new Date());
            materialService.addMaterial(map);
            return JsonUtils.getJson("新增一条数据");
        }
    }
}
