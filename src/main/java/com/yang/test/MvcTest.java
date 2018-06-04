package com.yang.test;
//使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
//Spring4测试需要servlet3.0的支持


import com.github.pagehelper.PageInfo;
import com.yang.bean.Emplovee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:F:\\web\\crud\\src\\main\\webapp\\WEB-INF\\dispatcherServlet-servlet.xml"})
public class MvcTest {
    //传入SpringMvc的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;
    @Before
    public void intMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();

        //请求成功以后，请求域中会有pageInfo，我们可以取出pageInfo进行验证（pageInfo在Controller中）
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码  ："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for(int i :nums){
            System.out.println(" "+i);
        }

        //获取员工数据
        List<Emplovee> list = pi.getList();
        for(Emplovee emplovee : list){
            System.out.println("ID:"+emplovee.getEmpId()+"-->Name:"+emplovee.getEmpName());
        }

    }
}
