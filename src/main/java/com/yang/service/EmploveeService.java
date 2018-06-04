package com.yang.service;

import com.yang.bean.Emplovee;
import com.yang.bean.EmploveeExample;
import com.yang.dao.EmploveeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmploveeService {

    @Autowired
    EmploveeMapper emploveeMapper;
    //查询所有员工
    public List<Emplovee> getAll() {
        return emploveeMapper.selectByExampleWithDept(null);
    }

    //员工保存
    public void saveEmp(Emplovee emplovee) {
        emploveeMapper.insertSelective(emplovee);
    }

    //检验用户名是否可用 ==0返回false 代表当前姓名可用
    public boolean checkUser(String empName) {
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = emploveeMapper.countByExample(example);
        return count == 0;
    }

    public boolean checkEmail(String email) {
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        long count = emploveeMapper.countByExample(example);
        return count == 0;
    }

    //按照id查询
    public Emplovee getEmp(Integer id) {
        return emploveeMapper.selectByPrimaryKey(id);
    }
    //员工更新
    public void updateEmp(Emplovee emplovee) {
        emploveeMapper.updateByPrimaryKeySelective(emplovee);
    }

    //根据id删除
    public void delete(Integer id) {
       emploveeMapper.deleteByPrimaryKey(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids){
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        emploveeMapper.deleteByExample(example);
    }

}
