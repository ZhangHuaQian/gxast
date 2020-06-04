<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../../commViews/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>layout 后台大布局 - Layui</title>
<%@ include file="../../../commViews/head.jsp"%>
<script
	src="${ctx }resource/plugins/wangEditor-3.1.1/release/wangEditor.min.js"
	type="text/javascript" charset="utf-8"></script>
</head>
<style>
.layui-input-block{
	width: 120px;        
}
</style>
<div class="" id="div1">
	<!-- 内容主体区域 -->
	<div style="padding: 10px;">

		<form class="layui-form" id="main_form">
			<!-- <div class="layui-form-item" id="x-city">
				<label class="layui-form-label">地区</label>
				<div class="layui-input-inline" style="width: 100px">
					<select name="province" id="province" lay-filter="province">
						<option value="">请选择省</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<select name="city" id="city" lay-filter="city">
						<option value="">请选择市</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<select name="area" id="area" lay-filter="area">
						<option value="">请选择县/区</option>
					</select>
				</div>
			</div> -->
			<div class="layui-form-item" >
				<label class="layui-form-label">地区选择</label> 
				<div class="layui-input-inline" style="width: 120px;display: none">
					<select id="province"  lay-verify="required">
						<option value="450">广西壮族自治区</option>
					</select>  
				</div>
				<div class="layui-input-inline" style="width: 120px"> 
					<select id="city_" lay-verify="required" lay-filter="filter">    
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="country_"  lay-verify="required" lay-filter="filter2">
					</select>             
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="town"  lay-verify="required" lay-filter="filter3">
						<option value=""></option> 
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px">
					<select id="village"  lay-verify="required" lay-filter="filter4">
						<option value=""></option>
					</select>
				</div>  
			</div>
			<div class="layui-form-item">
				<!-- <label class="layui-form-label">帮扶村名</label>
				<div class="layui-input-inline">
					<input type="text" name="name" lay-verify="required"
						maxlength="200" placeholder="帮扶村名" autocomplete="off"
						class="layui-input">
				</div> -->
				<label class="layui-form-label">农特产品</label>
				<div class="layui-input-inline">
					<input name="product" lay-verify="required" maxlength="30"
						placeholder="主要农特产品" autocomplete="off" class="layui-input">
				</div>

				<label class="layui-form-label">总户数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="totalHouseholds" lay-verify="min" placeholder="总户数"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">总人口数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="totalPopulation" lay-verify="min" placeholder="总人口数"
						autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">贫困人口数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="poorPopulation" lay-verify="min" placeholder="贫困人口数"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">低保户数</label>
				<div class="layui-input-inline" style="width: 90px">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="lowInsured" lay-verify="min" placeholder="低保户数"
						autocomplete="off" class="layui-input">
				</div>
				<div class="layui-input-inline" style="width: 90px">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="lowInsuredPopulation" lay-verify="min"
						placeholder="低保人数" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">五保户数</label>
				<div class="layui-input-inline" style="width: 90px">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="fiveInsured" lay-verify="min" placeholder="户数"
						autocomplete="off" class="layui-input">
				</div>
				<div class="layui-input-inline" style="width: 90px">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="fiveInsuredPopulation" lay-verify="min"
						placeholder="人数" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">残疾人数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="disabled" lay-verify="min" placeholder="残疾人数"
						autocomplete="off" class="layui-input">
				</div>

				<label class="layui-form-label">贫困户户数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="poorHouseholds" lay-verify="min" placeholder="贫困户户数"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">主要经济来源</label>
				<div class="layui-input-inline">
					<input type="text" name="mainEconomy" lay-verify="required"
						placeholder="主要经济来源 如：务工" autocomplete="off" class="layui-input">
				</div>

				<label class="layui-form-label">支柱产业</label>
				<div class="layui-input-inline">
					<input type="text" name="pillarIndustry" lay-verify="required"
						placeholder="支柱产业" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">贫困户有劳动力人数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="laborForcePopulation" lay-verify="min"
						placeholder="贫困户有劳动力人数" autocomplete="off" class="layui-input">
				</div>

				<label class="layui-form-label">贫困户无劳动力人数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="nonLabourForcePopulation" lay-verify="min"
						placeholder="贫困户有劳动力人数" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">年人均收入</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="perCapitaIncome" lay-verify="min" placeholder="年人均收入"
						autocomplete="off" class="layui-input">
				</div>

				<label class="layui-form-label">在校学生数</label>
				<div class="layui-input-inline">
					<input type="number"
						oninput="if(value.length>10)value=value.slice(0,10)"
						name="enrolment" lay-verify="min" placeholder="在校学生数"
						autocomplete="off" class="layui-input">
				</div>
				<div class="layui-input-inline" style="display:none">
					<input type="text" name="name" lay-verify="required" id="name"
						maxlength="200" placeholder="帮扶村名" autocomplete="off"
						class="layui-input"> 
				</div> 
			</div>

			
			<div class="layui-form-item">
				<div class="layui-input-block">
					<!--  <button class="layui-btn" lay-submit lay-filter="formDemo" >立即提交</button> -->
					<button class="layui-btn layui-btn-warm" lay-submit=""
						lay-filter="demo1" id="subBtn">立即提交</button>
				</div>
			</div>
		</form>
	</div>

</div>
<script type="text/javascript" src="${ctx}resource/js/xcity.js"></script>
<script type="text/javascript">
	$(function () {   
		init();
		renderForm(); 
	});                
	function init_city(id){
		$.ajax({
			type : 'get',    
			url : '${ctx }city/select?provinceId=450&cityId='+id,    
			success : function(result) {      
				console.log(result);
				var city = result.city;   
				console.log(city)   
				var html="<option value=''></option>";        
				for(var i = 0;i<city.length;i++){           
					html+="<option value='"+city[i].countyId+"'>"+city[i].countyName+"</option>";
				}   
				$("#country_").html(html);   
				renderForm();
			},                
			error : function(msg) {
				alert("错误");
			}     
		});
	} 
	function init_country(id){
		$.ajax({
			type : 'get',    
			url : '${ctx }city/select?provinceId=450&countyId='+id,    
			success : function(result) {      
				console.log(result);
				var city = result.city;     
				console.log(city)   
				var html="<option value=''></option>";        
				for(var i = 0;i<city.length;i++){           
					html+="<option value='"+city[i].townId+"'>"+city[i].townName+"</option>";
				}   
				$("#town").html(html);
				console.log(html);   
				renderForm();     
			},                
			error : function(msg) {
				alert("错误");
			}     
		});
	} 
	function init_town(id){  
		$.ajax({
			type : 'get',    
			url : '${ctx }city/select?provinceId=450&townId='+id,    
			success : function(result) {       
				console.log(result);
				var city = result.city;      
				console.log(city)   
				var html="<option value=''></option>";         
				for(var i = 0;i<city.length;i++){           
					html+="<option value='"+city[i].villageId+"'>"+city[i].villageName+"</option>";
				}   
				$("#village").html(html);
				renderForm();      
			},                
			error : function(msg) {
				alert("错误");
			}     
		});
	} 
	function init(){
		$.ajax({
			type : 'get',    
			url : '${ctx }city/select?provinceId=450',    
			async : false,
			success : function(result) {
				console.log(result);
				var city = result.city;
				console.log(city)   
				var html="<option value=''></option>";        
				for(var i = 0;i<city.length;i++){           
					html+="<option value='"+city[i].cityId+"'>"+city[i].cityName+"</option>";
				}
				console.log(html); 
				$("#city_").html(html);
			},                
			error : function(msg) {
				alert("错误");
			}     
		});
	}
	/* layui.use([ 'form' ], function() {
		form = layui.form;

		//$('#x-city').xcity('广西','百色市','田东县');
		$('#x-city').xcity('广西');

	}); */
	//关闭当前弹出窗口
	function closeWindow() {
		if ($(window.parent.frames["帮扶村屯列表"]).length > 0) {
			window.parent.frames["帮扶村屯列表"].location.reload();// 刷新父窗口
			setTimeout(function() {
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭
				//layer.closeAll(); //疯狂模式，关闭所有层
			}, 1000)
		}
	}
	function sendData() {
		var fromDate = $('#main_form').serialize();
		$.ajax({
			type : 'post', 
			url : '${ctx }sys/village/insert?villageid='+$("#village").val()+"&province=广西" 
					+"&city="+$("#city_").find("option:selected").text()+"&area="+$("#country_").find("option:selected").text(),
			data : fromDate,
			async : false,
			success : function(result) {
				closeWindow();
				layer.msg(result.msg);
			},
			error : function(msg) {
				alert("错误");
			}
		});
	};
	function village(id){
		$("#name").val(id);
		console.log($("#name").val());   
	}
	function renderForm(){
		layui.use('form', function() {
			var form = layui.form;
			form.on('submit(demo1)', function() {
				sendData();
				return false;
			});   
			form.verify({
                min: function (value) {  
                	if(value.length>11){
                	      return '填写内容不能超过11位'; 
                	}
                	if(value==null||value==""){
              	      return '不能留空'; 
              	}
                }
            });
			form.on('select(filter)', function(data){
				  //console.log(data.elem); //得到select原始DOM对象
				  console.log(data.value); //得到被选中的值 
				  $("#country_").html("");
				  $("#town").html("");
				  $("#village").html("");
				  init_city(data.value);  
				  //console.log(data.othis); //得到美化后的DOM对象
			});
			form.on('select(filter2)', function(data){
				  //console.log(data.elem); //得到select原始DOM对象
				  console.log(data.value); //得到被选中的值
				  $("#town").html("");
				  $("#village").html("");
				  init_country(data.value);  
				  //console.log(data.othis); //得到美化后的DOM对象  
			});
			form.on('select(filter3)', function(data){
				  //console.log(data.elem); //得到select原始DOM对象
				  console.log(data.value); //得到被选中的值
				  $("#village").html("");
				  init_town(data.value);  
				  //console.log(data.othis); //得到美化后的DOM对象
			});
			form.on('select(filter4)', function(data){
				  //console.log(data.elem); //得到select原始DOM对象
				  //console.log(data.value); //得到被选中的值
				  village($("#village").find("option:selected").text());    
				  //console.log(data.othis); //得到美化后的DOM对象
			});
			form.render();  
		});
	}
</script>
</body>
</html>