<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%--输出,条件,迭代标签库--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> <%--数据格式化标签库--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> <%--数据库相关标签库--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <%--常用函数标签库--%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%> <%--shiro标签库--%>
<c:set var="ctx" value="${pageContext.request.contextPath}/"/> 
<c:set var="ctxUphoto" value="${pageContext.request.contextPath}/uploadFiles/photo/"/>
<c:set var="ctxUvideo" value="${pageContext.request.contextPath}/uploadFiles/video/"/>
<c:set var="dnpath" value="http://${pageContext.request.localAddr}:${pageContext.request.localPort}${pageContext.request.contextPath}"/>
<c:set var="ctxRes" value="${pageContext.request.contextPath}/resource/"/>