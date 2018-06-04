package com.yang.test;

import com.yang.bean.*;
import com.yang.dao.DepartmentMapper;
import com.yang.dao.EmploveeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;


//测试dao层的工作
//推荐Spring的项目就可以使用SPring的单元测试，可以自动注入我们需要的组件
//1.导入SpringTest模块
//2.@ContextConfiguration指定Spring配置文件的位置
//3.直接autowired要使用的组件

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmploveeMapper emploveeMapper;
    @Autowired
    SqlSession sqlSession;
    @Autowired

    //测试DepartmentMapper
    @Test
    public void testCRUD(){
        /*//1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/

        System.out.println(departmentMapper);

        //插入几个部门
        /*Department d1 = new Department(null,"测试部");
        Department d2 = new Department(null,"生产部");
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(d1);
        departmentMapper.insert(new Department(null,"销售部"));*/

        //插入员工
        emploveeMapper.insertSelective(new Emplovee(null,"jerry","M","11@qq.com",9));

        //批量插入多个员工，使用可以执行批量操作的sqlSession
//        EmploveeMapper mapper = sqlSession.getMapper(EmploveeMapper.class);
//        for(int i = 0;i<100;i++){
//            String uid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Emplovee(null,uid,"M",uid+"@qq.com",9));
//        }
    }

}

