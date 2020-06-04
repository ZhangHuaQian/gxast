/**
 * 反表单序列化
 */
$.fn.extend({
    //表单加载json对象数据
    setForm: function (jsonValue) {
        var obj = this;
        $.each(jsonValue, function (name, ival) {
            var $oinput = obj.find("input[name=" + name + "]");
            if ($oinput.attr("type") == "checkbox") {
                if (ival !== null) {
                    var checkboxObj = $("[name=" + name + "]");
                    var checkArray = ival.split(";");
                    for (var i = 0; i < checkboxObj.length; i++) {
                        for (var j = 0; j < checkArray.length; j++) {
                            if (checkboxObj[i].value == checkArray[j]) {
                                checkboxObj[i].click();
                            }
                        }
                    }
                }
            }
            else if ($oinput.attr("type") == "radio") {
                $oinput.each(function () {
                    var radioObj = $("[name=" + name + "]");
                    for (var i = 0; i < radioObj.length; i++) {
                        if (radioObj[i].value == ival) {
                            radioObj[i].click();
                        }
                    }
                });
            }
            else if ($oinput.attr("type") == "textarea") {
                obj.find("[name=" + name + "]").html(ival);
            }
            else {
                obj.find("[name=" + name + "]").val(ival);
            }
        })

    }
});


/**
 * 时间戳转日期
 * @param now
 * @returns {string}
 */
// yyyy-MM-dd HH:mm:ss
function formatDate_YMD_HMS(timestamp) {
    var curTime = new Date(timestamp).format("yyyy-MM-dd hh:mm:ss");
    return curTime;
}

// yyyy-MM-dd
function formatDate_YMD(timestamp) {
    var curTime = new Date(timestamp).format("yyyy-MM-dd");
    return curTime;
}

// yyyy-MM-dd
function formatDate_HMS(timestamp) {
    var curTime = new Date(timestamp).format("hh:mm:ss");
    return curTime;
}
         
Date.prototype.format = function(fmt) {
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt)) {
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
    return fmt;
}

/* 刷新窗口 */
function reload_parent(url){
    for (var i = 0; i < window.parent.frames.length; i++) {
         if(window.parent.frames[i].location.pathname.indexOf(url) != -1){
            window.parent.frames[i].location.reload();
         }
    }
}

$(function () {

    /**
     * base64 图片上传
     * @param param {dom:文件按钮对象,}
     */
    $.fn.base64img = function (param) {

        var error_fun = param.error;
        var success_fun = param.success;

        //图片转码
        function transcoding(input_file) {

            if (typeof (FileReader) === 'undefined') {
                error_fun("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
            } else {
                try {
                    /*图片转Base64 核心代码*/
                    var file = input_file.files[0];
                    //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
                    if (!/image\/\w+/.test(file.type)) {
                        error_fun('请选择图片文件')
                        return false;
                    }
                    var reader = new FileReader();
                    reader.onload = function() {
                        uploadImage(this.result,input_file);
                    }
                    reader.readAsDataURL(file);
                } catch (e) {
                    error_fun('图片转Base64出错啦,请重试')
                    console.log(e);
                }
            }

        }

        //图片上传
        function uploadImage(img,dom) {
            //判断是否有选择上传文件
            var imgPath = $(dom).val();
            if (imgPath == "") {
                error_fun('请选择上传图片');
                return;
            }

            //判断上传文件的后缀名
            var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
            if (strExtension != 'jpg' && strExtension != 'gif'
                && strExtension != 'png' && strExtension != 'bmp'
                && strExtension != 'jpeg') {
                error_fun("请选择图片支持类型（jpg,jpeg,png,bmp,gif）")
                return;
            }
            var push_data = {base64Data : img}
            if(param.width!=undefined&&param.height!=undefined){
                push_data.width = param.width;
                push_data.height = param.height;
            }

            $.ajax({
                type : "POST",
                url : param.url,
                data : push_data,
                cache : false,
                dataType : "text",
                success : function(data) {
                    success_fun({fname:data,img:img})
                },
                error : function(XMLHttpRequest, textStatus, errorThrown) {
                    error_fun('请检查网络后重试')
                    console.log(XMLHttpRequest);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }

        this.change(function() {
            transcoding(this)
        });

    };

})


var parseParam=function(param, key){
    var paramStr="";
    if(param instanceof String||param instanceof Number||param instanceof Boolean){
        paramStr+="&"+key+"="+encodeURIComponent(param);
    }else{
        $.each(param,function(i){
            var k=key==null?i:key+(param instanceof Array?"["+i+"]":"."+i);
            paramStr+='&'+parseParam(this, k);
        });
    }
    return paramStr.substr(1);
};
function parseParamObjNotNull(obj){
    var object={};
    for(var item in obj){
        if(!isEmpty(obj[item])){
            object[item]= obj[item];
        }
    }
    return object;
}
function isEmpty(obj) {
    if(obj==undefined||obj==null||obj==''){
        return true;
    }
    return false;
}
//关闭当前弹出窗口
function closeWindowByName(framesName) {
    window.parent.frames[framesName].location.reload() ;// 刷新父窗口

    setTimeout(function (){
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    },1000)

}


// 新建窗口
function showWin(param) {
    parent.layer.open({
        type: param.type,
        area: [param.width, param.height],
        title: param.title,
        closeBtn: 1,
        shadeClose: false,
        resize: true,
        success: function (layero, index) {
        },
        content: param.url,

    });

    function htmlspecialchars_decode(str) {
        str = str.replace(/&lt;/g, '<');
        str = str.replace(/&gt;/g, '>');
        str = str.replace(/&#40;/g, "(");
        str = str.replace(/&#41;/g, ")");
        str = str.replace(/&#39;/g, "\'");
        return str;
    }
}
