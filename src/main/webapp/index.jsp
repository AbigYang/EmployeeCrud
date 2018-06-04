<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <title>列表</title>
    <!--web路径
    不以/开始的相对路径，找资源，以当前资源路径为基准
    以/开始的相对路径，找资源，以服务器的路径为标准，需加上项目名
    -->
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript" src="${APP_PATH}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/css/bootstrap.min.css">
</head>
<body>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked" > 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--员工修改--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked" > 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<%--员工删除--%>
<div class="modal fade" id="empDeleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >确定删除员工？</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_delete_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="email_delete_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline disabled">
                                <input type="radio" name="gender" id="gender1_delete_input" value="M" checked="checked" disabled> 男
                            </label>
                            <label class="radio-inline disabled">
                                <input type="radio" name="gender" id="gender2_delete_input" value="F" disabled> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select" disabled>
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_delete_btn">删除</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--分页显示--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>

        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord;
    var nowPage;
//1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });
    
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.分页条
                build_page_nav(result);
            }
        });
    }

    //显示表格中信息
    function build_emps_table(result) {
        //清空
        $("#emps_tables tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
//            var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /*
            * <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
            * */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>")
                .addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为按钮添加一个自定义属性表示当前员工id
            editBtn.attr("edit_id",item.empId);
            //editBtn.attr("edit_pn",result.extend.pageInfo.pageNum);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>")
                .addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("delete_id",item.empId);
            //delBtn.attr("delete_pn",result.extend.pageInfo.pageNum);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_tables tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages+"页，总"+result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        nowPage = result.extend.pageInfo.pageNum;
    }
    //分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击翻页时间
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false ){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item ){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //表单重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        //$("#dept_add_select").empty();
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    
    //查出所有部门信息并显示在下拉列表
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
           url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //console:log(result);
                //显示部门信息在下拉列表
                //$("#empAddModal select").append("")
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option ></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }
    
    //校验表单方法
    function validate_add_form() {
        //拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;//6到16位
        if(!regName.test(empName)){
            //alert("用户名可以使2-5位中文或者6-16位英文或数字组合");
            show_validate_msg("#empName_add_input","error","用户名可以使2-5位中文或者6-16位英文或数字组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        };
        //校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //校验邮箱是否可用
    $("#email_add_input").change(function () {
        var email = this.value;
        $.ajax({
           url:"${APP_PATH}/checkemail",
           data:"email="+email,
           type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#email_add_input","success","邮箱可用");
                    $("#emp_save_btn").attr("ajax-ve","success");
                }else{
                    show_validate_msg("#email_add_input","error",result.extend.ve_msg);
                    $("#emp_save_btn").attr("ajax-ve","error");
                }
            }

        });
    });
    
    //点击保存按钮 保存员工
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据交给服务器进行保存
        //1.先对要提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        };//前端校验

        //判断之前的ajax用户名校验是否成功，成功才继续
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        if($(this).attr("ajax-ve")=="error"){
            return false;
        }
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code == 100){
                    //员工保存成功
                    //1.关系模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页，显示刚才保存的数据
                    //发送ajax请求来显示最后一页
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    //console.log(result);
                    //有那个字段的错误信息就显示哪个字段的
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示名字错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        });

    });

    //按钮创建之前就绑定了click，所以绑不上
    //可以在创建按钮的时候绑定事件或绑定点击on
    //点击编辑按钮弹出模态框
    $(document).on("click",".edit_btn",function () {
        //查出部门信息并显示
        getDepts("#empUpdateModal select");
        //查出员工信息并显示
        getEmp($(this).attr("edit_id"));
        //传递员工id
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //$("#emp_update_btn").attr("edit_pn",$(this).attr("edit_pn"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    function getEmp2(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_delete_static").text(empData.empName);
                $("#email_delete_static").text(empData.email);
                $("#empDeleteModal input[name=gender]").val([empData.gender]);
                $("#empDeleteModal select").val([empData.dId]);
            }
        });
    }

    $("#email_update_input").change(function () {
        var email = this.value;
        $.ajax({
            url:"${APP_PATH}/checkemail",
            data:"email="+email,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#email_update_input","success","邮箱可用");
                    $("#emp_save_btn").attr("ajax-ve","success");
                }else{
                    show_validate_msg("#email_update_input","error",result.extend.ve_msg);
                    $("#emp_save_btn").attr("ajax-ve","error");
                }
            }

        });
    });

    //更新按钮
    $("#emp_update_btn").click(function () {
        //var pnn = $(this).attr("edit_pn");
        //验证邮箱
        //2.发送ajax请求保存更新的员工
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            type:"POST",//Rest风格，不能直接用PUT
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function (result) {
                $("#empUpdateModal").modal('hide');
                to_page(nowPage);
            }
        });

    });
    //点击删除弹出模态框
    $(document).on("click",".delete_btn",function () {
        //找到父元素tr再找到第0个td就是当前id
        //$(this).parents("tr").find("td:eq(0)").text()
        getDepts("#empDeleteModal select");
        getEmp2($(this).attr("delete_id"));
        //deleteEmp($(this).attr("delete_id"));
        $("#emp_delete_btn").attr("delete_id",$(this).attr("delete_id"));
        //$("#emp_delete_btn").attr("delete_pn",$(this).attr("delete_pn"));
        $("#empDeleteModal").modal({
            backdrop:"static"
        });
    });
    //确定删除按钮
    $("#emp_delete_btn").click(function () {
        //var pnn = $(this).attr("delete_pn");
        $.ajax({
        url:"${APP_PATH}/del/"+$(this).attr("delete_id"),
            type:"POST",//可以直接用DELETE
            data:$("#empUpdateModal form").serialize()+"&_method=DELETE",
            success:function () {
                $("#empDeleteModal").modal('hide');

                to_page(nowPage);

            }

        });
    });

    //完成全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefind;
        //原生dom属性用prop，attr获取自定义属性的值
       // alert($(this).prop("checked"))
       $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //为check_item绑定事件
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {

        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            //alert($(this).parents("tr").find("td:eq(2)").text());
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";

        });
        //去除empNames多余的,  截取字符串
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/del/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(nowPage);
                }
            });
        }
    });

</script>

</body>
</html>