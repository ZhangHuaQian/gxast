
function getUrlParam(name){
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
};

//输入的时间格式为yyyy-MM-dd
function convertDateFromString(dateString) {
    if (dateString) {
        var date = new Date(dateString.replace(/-/,"/"))
        return date;
    }
}
//输入的时间格式为yyyy-MM-dd hh:mm:ss
//返回时间类型
function convertDateFromString2(dateString) {
    if (dateString) {
        var arr1 = dateString.split(" ");
        var sdate = arr1[0].split('-');
        var mdate = arr1[1].split(':');
        var date = new Date(sdate[0], sdate[1]-1, sdate[2],mdate[0],mdate[1],mdate[2]);
        return date;
    }
}

function timestampToTime(timestamp) {
    var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    Y = date.getFullYear() + '-';
    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    D = (date.getDate()<10?'0'+date.getDate():date.getDate()) + ' ';
    h = (date.getHours()<10?'0'+date.getHours():date.getHours()) + ':';
    m = (date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes()) + ':';
    s = (date.getSeconds()<10?'0'+date.getSeconds():date.getSeconds());
    //alert(Y+M+D+h+m+s);
    return Y+M+D+h+m+s;
}

function addTimestampToTime(timestamp) {
    //console.log(timestamp);
    var now = new Date().getTime();
    //console.log(now);
    var newtime = now+timestamp;
    //console.log(newtime);
    return timestampToTime(newtime);
}
function timeAddTimestampToTime(timestamp1,timestamp2) {
    //console.log(timestamp2);
    var firsttime = timestamp1;
    //console.log(firsttime);
    var newtime = firsttime+timestamp2;
    //console.log(newtime);
    return timestampToTime(newtime);
}