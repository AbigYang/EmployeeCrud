package com.yang.bean;


import javax.validation.constraints.Pattern;

public class Emplovee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "用户名必须是2-5位中文或者6-16位英文或数字组合")
    private String empName;

    private String gender;

    //@Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "请输入正确格式的邮箱")
    private String email;

    private Integer dId;

    //希望查询员工时部门信息也是查询好的
    public Department getDepartment() {
        return department;
    }

    public Emplovee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Emplovee() {
    }

    @Override
    public String toString() {
        return "Emplovee [empId=" + empId + ",empName=" + empName + ",gender=" + gender + ",email=" + email + ",did=" + dId + "]";
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    private Department department;

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}