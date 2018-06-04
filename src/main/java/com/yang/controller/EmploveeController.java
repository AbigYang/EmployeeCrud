package com.yang.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.Emplovee;
import com.yang.bean.Msg;
import com.yang.service.EmploveeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/*
* 处理CRUD请求
* */
@Controller
public class EmploveeController {

    @Autowired
    EmploveeService emploveeService;

    //删除 单个批量二合一
    //批量删除：1-2-3
    //单个删除：1
    @RequestMapping(value = "/del/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){//批量删除
            List<Integer> del_ids = new ArrayList<>();
            //分割字符串根据"-"
            String[] str_ids = ids.split("-");
            //组装id的集合
            for(String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            emploveeService.deleteBatch(del_ids);
        }else{//单个删除
            Integer id = Integer.parseInt(ids);
            emploveeService.delete(id);
        }
        return Msg.success();
    }


    /*
    * 保存更新员工
    * 如果直接发送ajax=PUT形式的请求
    * Employee对象封装不上
    * tomcat：1.将请求体中的数据，封装一个map
    *         2.request.getParameter("empName")就会从这个map中取值
    *         3.SpringMVC封装POJO对象的时候，会把POJO中对象每个属性的值，
    *tomcat一看是PUT请求就不会封装请求体中的数据map，只有POST形式的请求才封装
    * */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Emplovee emplovee){
        System.out.println("将要更新的员工数据："+emplovee);
        emploveeService.updateEmp(emplovee);
        return Msg.success();
    }

    //根据id查询
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Emplovee emplovee = emploveeService.getEmp(id);
        return Msg.success().add("emp",emplovee);
    }

    //检查用户名是否可用
    //支持JSR303校验 导入Hibernate-Validator
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法字符
        String regx = "(^[a-zA-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库用户名重复校验
        boolean b = emploveeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已存在");
        }
    }
    @ResponseBody
    @RequestMapping("/checkemail")
    public Msg checkemail(@RequestParam("email") String email){
        String regx = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
        if(!email.matches(regx)){
            return Msg.fail().add("ve_msg","请输入正确的邮箱格式");
        }
        boolean e = emploveeService.checkEmail(email);
        if(e){
            return Msg.success();
        }else {
            return Msg.fail().add("ve_msg","邮箱已存在");
        }
    }

    //员工保存
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emplovee emplovee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误的字段名" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            emploveeService.saveEmp(emplovee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //不是分页
        //引入PageHelper
        //查询之前至于要调用，传入页码，以及每页大小
        PageHelper.startPage(pn,5);
        //startPage紧跟一个分页查询
        List<Emplovee> emps = emploveeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面
        //封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps,5);//连续显示的页数
        return Msg.success().add("pageInfo",page);
    }
/*
* 查询员工数据（分页）
* */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model){
        //不是分页
        //引入PageHelper
        //查询之前至于要调用，传入页码，以及每页大小
        PageHelper.startPage(pn,5);
        //startPage紧跟一个分页查询
        List<Emplovee> emps = emploveeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面
        //封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps,5);//连续显示的页数
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
