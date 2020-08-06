<%@ page import="entity.Material" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>物料管理</title>
    <link rel="icon" href="../../static/image/logo.ico" type="image/x-icon" />
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .conts{
            position: absolute;
            left: 40%;
            top: 15%;
            background-color: #deede3;
            border-radius: 5px;
            width: 20%;
            height: 60%;
            filter: alpha(opacity = 60);
            display: none;
            z-Index: 3;
        }
        input{
            border-radius: 5px;
            padding-right: 5px;
            width: 150px;
        }
        select {
            border-radius: 5px;
            width: 150px;
            height: 25px;
        }
        button{
            border-radius: 5px;
        }
        a{
            padding: 5px;
        }
        td{
            text-align:center
        }
        th{
            text-align:center
        }
        button:hover{
            background: #2adaed;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <h3>
                物料管理
            </h3>
        </div>
    </div>
    <hr>
    <%--    搜索表单--%>
    <div class="row-fluid">
        <div class="span12">
            <form class="form-horizontal" action="/selectMaterial" method="post">
                <div class="control-group">
                    <div class="controls">
                        物料编码:<input type="text" name="itemCode">&emsp;
                        物料描述:<input type="text" name="itemDescription" >&emsp;
                        物料单位:<select name="itemUom" >
                                    <option value="米">米</option>
                                    <option value="平方米">平方米</option>
                                    <option value="立方米">立方米</option>
                                    <option value="千克">千克</option>
                                    <option value="个">个</option>
                                    <option value="其他">其他</option>
                                 </select>
                    </div>
                </div>
                <br>
                <div class="control-group">
                    <div class="controls">
                        生效时间:<input type="date" name="startActiveDate">&emsp;
                        失效时间:<input type="date" name="endActiveDate">&emsp;
                        是否启用:<select name="enabledFlag" >
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                    </div>
                </div>
                <br>
                <div class="control-group">
                    <div class="controls">
                        <button type="submit" class="btn">查询</button>
                        <button type="reset" class="btn">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <hr>
    <br>
    <%--    表格--%>
    <div class="row-fluid">
        <div class="span12">
            <table class="table table-hover table-bordered" id="materialTable">
                <thead>
                <tr>
                    <th></th>
                    <th>
                        物料编码
                    </th>
                    <th>
                        物料描述
                    </th>
                    <th>
                        物料单位
                    </th>
                    <th>
                        生效时间
                    </th>
                    <th>
                        失效时间
                    </th>
                    <th>
                        是否启用
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${pageInfo.list.size()==0}">
                <tr><td colspan="7">未查询到数据</td></tr>
                </c:if>
                <c:if test="${pageInfo.list.size()!=0}">
                <c:forEach var="material" items="${pageInfo.list}">
                <tr>
                    <td><label>
                        <input style="width: 50px" type="checkbox" value="${material.itemId}" name="itemId"/>
                    </label></td>
                    <td>${material.itemCode}</td>
                    <td>${material.itemDescription}</td>
                    <td>${material.itemUom}</td>
                    <td>${material.getStartActiveDate()}</td>
                    <td>${material.getEndActiveDate()}</td>
                    <td>
                        <c:if test="${material.enabledFlag==1}">是</c:if>
                        <c:if test="${material.enabledFlag==0}">否</c:if>
                    </td>
                    </tr>
                </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <button type="button" class="btn" onclick="openAdd()">新建</button>
    <button type="button" class="btn" onclick="findMaterial()">编辑</button>
    <button type="button" class="btn" onclick="deleteMaterial()">删除</button>
    <button type="button" class="btn" onclick="method5('materialTable')">导出Excel</button>
    <br>
    <hr>
    <%--    页码--%>
    <div class="row-fluid" >
        <div class="span12" style="text-align: center">
            <div class="pagination pagination-centered pagination-large" style="width:100%">
                <p>当前第 <span>${pageInfo.pageNum}</span> 页,总 <span>${pageInfo.pages}</span> 页,共 <span>${pageInfo.total}</span> 条记录</p>
                <a href="main?pageNum=1">首页</a>
                <a <c:if test="${pageInfo.pageNum != pageInfo.firstPage}">href="main?pageNum=${pageInfo.pageNum - 1 }"</c:if>
                        <c:if test="${pageInfo.pageNum == pageInfo.firstPage}"> href="javascript:void(0)"</c:if>>上一页</a>
                <!-- foreach 从 1 开始 到 总页数结束  遍历输出 -->
                <c:forEach begin="1" end="${pageInfo.pages }" varStatus="status">
                    <a href="main?pageNum=${status.count }" <c:if test="${status.count == pageInfo.pageNum}">class="select"</c:if>>${status.count }</a>
                </c:forEach>
                <!-- 当前页为最后一页时href="javascript:void(0)" 禁用 a 标签的点击时间事件-->
                <a <c:if test="${pageInfo.pageNum == pageInfo.lastPage}">href="javascript:void(0)"</c:if>
                   <c:if test="${pageInfo.pageNum != pageInfo.lastPage}">href="main?pageNum=${pageInfo.pageNum + 1 }"</c:if>>下一页</a>
                <a href="main?pageNum=${pageInfo.pages}">尾页</a>
            </div>
        </div>
    </div>-
</div>
<%--隐藏编辑表单--%>
<div id="conts" class="conts" >
    <div class="row-fluid">
        <div class="span12">
            <form style="padding: 10px">
                <br>请修改<hr>
                        <input type="hidden" name="itemId" id="itemId">
                物料编码:<input type="text" name="itemCode" id="itemCode" disabled><br><br>
                物料描述:<input type="text" name="itemDescription" id="itemDescription" ><br><br>
                物料单位:<select name="itemUom" id="itemUom" >
                            <option value="米">米</option>
                            <option value="平方米">平方米</option>
                            <option value="立方米">立方米</option>
                            <option value="千克">千克</option>
                            <option value="个">个</option>
                            <option value="其他">其他</option>
                        </select><br><br>
                生效时间:<input type="date" name="startActiveDate" id="startActiveDate" ><br><br>
                失效时间:<input type="date" name="endActiveDate" id="endActiveDate" ><br><br>
                是否启用:<select name="enabledFlag" id="enabledFlag" >
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select><br><br>
                <button type="button" class="btn" onclick="editMaterial()">提交</button>
                <button type="button" class="btn" onclick="closeForm()">取消</button>
        </form>
        </div>
    </div>
</div>
<%--隐藏新增表单--%>
<div id="conts1" class="conts" >
    <div class="row-fluid">
        <div class="span12">
            <form style="padding: 10px">
                <br>请添加<hr>
                物料描述:<input type="text" name="itemDescription" id="itemDescription1" ><br><br>
                物料单位:<select name="itemUom" id="itemUom1" >
                <option value="米">米</option>
                <option value="平方米">平方米</option>
                <option value="立方米">立方米</option>
                <option value="千克">千克</option>
                <option value="个" selected>个</option>
                <option value="其他">其他</option>
            </select><br><br>
                生效时间:<input type="date" name="startActiveDate" id="startActiveDate1" ><br><br>
                失效时间:<input type="date" name="endActiveDate" id="endActiveDate1" ><br><br>
                是否启用:<select name="enabledFlag" id="enabledFlag1" >
                <option value="1" >是</option>
                <option value="0" selected>否</option>
            </select><br><br>
                <button type="button" class="btn" onclick="addMaterial()">提交</button>
                <button type="button" class="btn" onclick="closeForm1()">取消</button>
            </form>
        </div>
    </div>
</div>
<div id="cover"
     style="background: #6f5554; position: absolute; left: 0; top: 0; width: 100%;height:100%; filter: alpha(opacity=30); opacity: 0.3; display: none; z-index: 2 ">
</div>
<script>
    //日期格式化
    Date.prototype.Format = function(fmt)
    {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt))
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
            if(new RegExp("("+ k +")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    };

    //打开编辑页面
    function findMaterial() {
        var str1 = [];
        var str = document.getElementsByName("itemId");
        for (var i = 0; i < str.length; i++) {
            if (str[i].checked)
                str1.push(str[i].value);
        }
        if (str1.length !== 1)
            alert("未选中或选中多个");
        else {
            $.ajax({
                async: true,
                dataType: 'json',
                type: "POST",
                url: '/findMaterial',
                data: {"id": str1},
                traditional: true,  //这里设置为true
                success: function (result) {
                    document.getElementById("itemId").value = result.itemId;
                    document.getElementById("itemCode").value = result.itemCode;
                    document.getElementById("itemDescription").value = result.itemDescription;
                    document.getElementById("itemUom").value = result.itemUom;
                    document.getElementById("startActiveDate").value= new Date(result.startActiveDate).Format("yyyy-MM-dd");
                    document.getElementById("endActiveDate").value = new Date(result.endActiveDate).Format("yyyy-MM-dd");
                    document.getElementById("enabledFlag").value = result.enabledFlag;

                    document.getElementById("cover").style.display = 'block';
                    document.getElementById("conts").style.display = 'block';
                }
            });
        }
    }

    //编辑
    function editMaterial(){
            $.ajax({
                async: true,
                dataType: 'json',
                type: "POST",
                url: '/editMaterial',
                data: {
                    "itemId": document.getElementById("itemId").value,
                    "itemCode": document.getElementById("itemCode").value,
                    "itemDescription": document.getElementById("itemDescription").value,
                    "itemUom": document.getElementById("itemUom").value,
                    "startActiveDate": document.getElementById("startActiveDate").value,
                    "endActiveDate": document.getElementById("endActiveDate").value,
                    "enabledFlag": document.getElementById("enabledFlag").value
                },
                traditional: true,
                success: function (result) {
                    alert(result);
                    window.location.reload();
                },
                error: function (result) {
                    alert(result.responseText);
                }
            });
    }

    //删除
    function deleteMaterial() {
        var str1 = [];
        var str = document.getElementsByName("itemId");
        for (var i = 0; i < str.length; i++) {
            if (str[i].checked)
                str1.push(str[i].value);
        }
        if (str1.length === 0)
            alert("请先选中")
        else {
            var mymessage=confirm("确认删除吗？");
            if(mymessage==true)
            {
                $.ajax({
                    async: true,
                    dataType: 'json',
                    type: "POST",
                    url: '/deleteMaterial',
                    data: {"id": str1},
                    traditional: true,  //这里设置为true
                    success: function (result) {
                        alert("删除了" + result + "条数据");
                        window.location.reload();
                    }
                });
            }
            else {}
        }
    }
    //关闭编辑页面
    function closeForm() {
        document.getElementById("conts").style.display = 'none';
        document.getElementById("cover").style.display = 'none';
    }

    //打开新增页面
    function openAdd(){
        document.getElementById("cover").style.display = 'block';
        document.getElementById("conts1").style.display = 'block';

    }
    //新增
    function addMaterial() {
            $.ajax({
                async: true,
                dataType: 'json',
                type: "POST",
                url: '/addMaterial',
                data: {
                    "itemDescription": document.getElementById("itemDescription1").value,
                    "itemUom": document.getElementById("itemUom1").value,
                    "startActiveDate": document.getElementById("startActiveDate1").value,
                    "endActiveDate": document.getElementById("endActiveDate1").value,
                    "enabledFlag": document.getElementById("enabledFlag1").value
                },
                traditional: true,
                success: function (result) {
                    alert(result);
                    window.location.reload();
                },
                error: function (result) {
                    alert(result.responseText);
                }
            })
    }
    //关闭新增页面
    function closeForm1(){
        document.getElementById("conts1").style.display = 'none';
        document.getElementById("cover").style.display = 'none';
    }
</script>

<%--//打印表格--%>
<script>
    var idTmr;
    function getExplorer() {
        var explorer = window.navigator.userAgent;
        //ie
        if(explorer.indexOf("MSIE") >= 0) {
            return 'ie';
        }
        //firefox
        else if(explorer.indexOf("Firefox") >= 0) {
            return 'Firefox';
        }
        //Chrome
        else if(explorer.indexOf("Chrome") >= 0) {
            return 'Chrome';
        }
        //Opera
        else if(explorer.indexOf("Opera") >= 0) {
            return 'Opera';
        }
        //Safari
        else if(explorer.indexOf("Safari") >= 0) {
            return 'Safari';
        }
    }

    function method5(tableid) {
        if(getExplorer() == 'ie') {
            var curTbl = document.getElementById(tableid);
            var oXL = new ActiveXObject("Excel.Application");
            var oWB = oXL.Workbooks.Add();
            var xlsheet = oWB.Worksheets(1);
            var sel = document.body.createTextRange();
            sel.moveToElementText(curTbl);
            sel.select();
            sel.execCommand("Copy");
            xlsheet.Paste();
            oXL.Visible = true;

            try {
                var fname = oXL.Application.GetSaveAsFilename("Excel.xls",
                    "Excel Spreadsheets (*.xls), *.xls");
            } catch(e) {
                print("Nested catch caught " + e);
            } finally {
                oWB.SaveAs(fname);
                oWB.Close(savechanges = false);
                oXL.Quit();
                oXL = null;
                idTmr = window.setInterval("Cleanup();", 1);
            }

        } else {
            tableToExcel(tableid)
        }
    }

    function Cleanup() {
        window.clearInterval(idTmr);
        CollectGarbage();
    }
    var tableToExcel = (function() {
        var uri = 'data:application/vnd.ms-excel;base64,',
            template = '<html><head><meta charset="UTF-8"></head><body><table  border="1">{table}</table></body></html>',
            base64 = function(
                s) {
                return window.btoa(unescape(encodeURIComponent(s)))
            },
            format = function(s, c) {
                return s.replace(/{(\w+)}/g, function(m, p) {
                    return c[p];
                })
            }
        return function(table, name) {
            if(!table.nodeType)
                table = document.getElementById(table)
            var ctx = {
                worksheet: name || 'Worksheet',
                table: table.innerHTML
            }
            window.location.href = uri + base64(format(template, ctx))
        }
    })()
</script>
<script src="../../static/js/jquery-3.2.1.min.js"></script>
</body>
</html>