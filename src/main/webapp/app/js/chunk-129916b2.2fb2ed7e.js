(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-129916b2"],{"0653":function(t,e,i){"use strict";i("68ef")},1146:function(t,e,i){},"34e9":function(t,e,i){"use strict";var n=i("861b"),a=i.n(n),s=i("a142"),r=i("ba31"),l=Object(s["k"])("cell-group"),o=l[0],c=l[1];function u(t,e,i,n){var s=t("div",a()([{class:[c(),{"van-hairline--top-bottom":e.border}]},Object(r["b"])(n,!0)]),[i["default"]&&i["default"]()]);return e.title?t("div",[t("div",{class:c("title")},[e.title]),s]):s}u.props={title:String,border:{type:Boolean,default:!0}},e["a"]=o(u)},"3d01":function(t,e,i){"use strict";i.r(e);var n,a=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{attrs:{id:"login"}},[t._m(0),i("van-cell-group",[i("van-field",{attrs:{placeholder:"手机号"},model:{value:t.name,callback:function(e){t.name=e},expression:"name"}})],1),i("van-cell-group",{staticStyle:{"margin-top":"15px"}},[i("van-field",{attrs:{type:"password",placeholder:"请输入密码"},model:{value:t.password,callback:function(e){t.password=e},expression:"password"}})],1),i("van-cell-group",{staticStyle:{"margin-top":"15px"},attrs:{id:"verification"}},[i("van-field",{attrs:{center:"",clearable:"",placeholder:"请输入验证码"}},[i("van-button",{attrs:{slot:"button",size:"small",type:"primary"},slot:"button"},[t._v("获取验证码")])],1)],1),i("van-button",{attrs:{size:"normal"}},[t._v("立即注册")]),i("div",{staticStyle:{"text-align":"center",width:"100%",height:"100px","margin-top":"20px","font-size":"10px",color:"gray"}})],1)},s=[function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticStyle:{"text-align":"center",width:"100%",height:"60px"}},[i("p",{staticStyle:{margin:"90px 0px 0px 0px","font-weight":"bold","font-size":"20px"}},[t._v("账号注册")])])}],r=i("bd86"),l=(i("66b9"),i("b650")),o=(i("0653"),i("34e9")),c=(i("c194"),i("7744")),u=(i("be7f"),i("565f")),h={components:(n={},Object(r["a"])(n,u["a"].name,u["a"]),Object(r["a"])(n,c["a"].name,c["a"]),Object(r["a"])(n,o["a"].name,o["a"]),Object(r["a"])(n,l["a"].name,l["a"]),n),data:function(){return{name:"",password:""}},methods:{}},d=h,f=(i("4040"),i("2877")),b=Object(f["a"])(d,a,s,!1,null,null,null);e["default"]=b.exports},4040:function(t,e,i){"use strict";var n=i("8628"),a=i.n(n);a.a},"565f":function(t,e,i){"use strict";var n=i("861b"),a=i.n(n),s=i("1988"),r=i("ad06"),l=i("7744"),o=i("dfaf"),c=i("a142"),u=i("db78"),h=i("023d"),d=i("90c6"),f=Object(c["k"])("field"),b=f[0],p=f[1];e["a"]=b({inheritAttrs:!1,props:Object(s["a"])({},o["a"],{error:Boolean,leftIcon:String,rightIcon:String,readonly:Boolean,clearable:Boolean,labelWidth:[String,Number],labelAlign:String,inputAlign:String,onIconClick:Function,autosize:[Boolean,Object],errorMessage:String,errorMessageAlign:String,type:{type:String,default:"text"}}),data:function(){return{focused:!1}},watch:{value:function(){this.$nextTick(this.adjustSize)}},mounted:function(){this.format(),this.$nextTick(this.adjustSize)},computed:{showClear:function(){return this.clearable&&this.focused&&""!==this.value&&Object(c["d"])(this.value)&&!this.readonly},listeners:function(){return Object(s["a"])({},this.$listeners,{input:this.onInput,keypress:this.onKeypress,focus:this.onFocus,blur:this.onBlur})},labelStyle:function(){var t=this.labelWidth;if(t){var e=Object(d["a"])(String(t))?t+"px":t;return{maxWidth:e,minWidth:e}}}},methods:{focus:function(){this.$refs.input&&this.$refs.input.focus()},blur:function(){this.$refs.input&&this.$refs.input.blur()},format:function(t){void 0===t&&(t=this.$refs.input);var e=t,i=e.value,n=this.$attrs.maxlength;return"number"===this.type&&Object(c["d"])(n)&&i.length>n&&(i=i.slice(0,n),t.value=i),i},onInput:function(t){this.$emit("input",this.format(t.target))},onFocus:function(t){this.focused=!0,this.$emit("focus",t),this.readonly&&this.blur()},onBlur:function(t){this.focused=!1,this.$emit("blur",t),Object(c["e"])()&&window.scrollTo(0,Object(h["b"])())},onClickLeftIcon:function(){this.$emit("click-left-icon")},onClickRightIcon:function(){this.$emit("click-icon"),this.$emit("click-right-icon"),this.onIconClick&&this.onIconClick()},onClear:function(t){Object(u["c"])(t),this.$emit("input",""),this.$emit("clear")},onKeypress:function(t){if("number"===this.type){var e=t.keyCode,i=-1===String(this.value).indexOf("."),n=e>=48&&e<=57||46===e&&i||45===e;n||Object(u["c"])(t)}"search"===this.type&&13===t.keyCode&&this.blur(),this.$emit("keypress",t)},adjustSize:function(){var t=this.$refs.input;if("textarea"===this.type&&this.autosize&&t){t.style.height="auto";var e=t.scrollHeight;if(Object(c["g"])(this.autosize)){var i=this.autosize,n=i.maxHeight,a=i.minHeight;n&&(e=Math.min(e,n)),a&&(e=Math.max(e,a))}e&&(t.style.height=e+"px")}},renderInput:function(){var t=this.$createElement,e={ref:"input",class:p("control",this.inputAlign),domProps:{value:this.value},attrs:Object(s["a"])({},this.$attrs,{readonly:this.readonly}),on:this.listeners};return"textarea"===this.type?t("textarea",a()([{},e])):t("input",a()([{attrs:{type:this.type}},e]))},renderLeftIcon:function(){var t=this.$createElement,e=this.slots("left-icon")||this.leftIcon;if(e)return t("div",{class:p("left-icon"),on:{click:this.onClickLeftIcon}},[this.slots("left-icon")||t(r["a"],{attrs:{name:this.leftIcon}})])},renderRightIcon:function(){var t=this.$createElement,e=this.slots,i=e("right-icon")||e("icon")||this.rightIcon||this.icon;if(i)return t("div",{class:p("right-icon"),on:{click:this.onClickRightIcon}},[e("right-icon")||e("icon")||t(r["a"],{attrs:{name:this.rightIcon||this.icon}})])}},render:function(t){var e,i=this.slots,n=this.labelAlign,a={icon:this.renderLeftIcon};return i("label")&&(a.title=function(){return i("label")}),t(l["a"],{attrs:{icon:this.leftIcon,size:this.size,title:this.label,center:this.center,border:this.border,isLink:this.isLink,required:this.required,titleStyle:this.labelStyle,titleClass:p("label",n)},class:p((e={error:this.error,disabled:this.$attrs.disabled},e["label-"+n]=n,e["min-height"]="textarea"===this.type&&!this.autosize,e)),scopedSlots:a},[t("div",{class:p("body")},[this.renderInput(),this.showClear&&t(r["a"],{attrs:{name:"clear"},class:p("clear"),on:{touchstart:this.onClear}}),this.renderRightIcon(),i("button")&&t("div",{class:p("button")},[i("button")])]),this.errorMessage&&t("div",{class:p("error-message",this.errorMessageAlign)},[this.errorMessage])])}})},"66b9":function(t,e,i){"use strict";i("68ef")},7744:function(t,e,i){"use strict";var n=i("1988"),a=i("861b"),s=i.n(a),r=i("a142"),l=i("dfaf"),o=i("ba31"),c=i("48f4"),u=i("ad06"),h=Object(r["k"])("cell"),d=h[0],f=h[1];function b(t,e,i,n){var a=e.icon,l=e.size,h=e.title,d=e.label,b=e.value,p=e.isLink,g=e.arrowDirection,v=i.title||Object(r["d"])(h),m=i["default"]||Object(r["d"])(b),y=i.label||Object(r["d"])(d),k=y&&t("div",{class:[f("label"),e.labelClass]},[i.label?i.label():d]),S=v&&t("div",{class:[f("title"),e.titleClass],style:e.titleStyle},[i.title?i.title():t("span",[h]),k]),x=m&&t("div",{class:[f("value",{alone:!i.title&&!h}),e.valueClass]},[i["default"]?i["default"]():t("span",[b])]),j=i.icon?i.icon():a&&t(u["a"],{class:f("left-icon"),attrs:{name:a}}),O=i["right-icon"],$=O?O():p&&t(u["a"],{class:f("right-icon"),attrs:{name:g?"arrow-"+g:"arrow"}}),w=function(t){Object(o["a"])(n,"click",t),Object(c["a"])(n)},I={center:e.center,required:e.required,borderless:!e.border,clickable:p||e.clickable};return l&&(I[l]=l),t("div",s()([{class:f(I),on:{click:w}},Object(o["b"])(n)]),[j,S,x,$,i.extra&&i.extra()])}b.props=Object(n["a"])({},l["a"],c["c"],{clickable:Boolean,arrowDirection:String}),e["a"]=d(b)},8628:function(t,e,i){},"90c6":function(t,e,i){"use strict";function n(t){return/^\d+$/.test(t)}i.d(e,"a",function(){return n})},b650:function(t,e,i){"use strict";var n=i("1988"),a=i("861b"),s=i.n(a),r=i("a142"),l=i("ba31"),o=i("48f4"),c=i("543e"),u=Object(r["k"])("button"),h=u[0],d=u[1];function f(t,e,i,n){var a=e.tag,r=e.type,u=e.disabled,h=e.loading,f=e.hairline,b=e.loadingText,p=function(t){h||u||(Object(l["a"])(n,"click",t),Object(o["a"])(n))},g=function(t){Object(l["a"])(n,"touchstart",t)},v=[d([r,e.size,{loading:h,disabled:u,hairline:f,block:e.block,plain:e.plain,round:e.round,square:e.square,"bottom-action":e.bottomAction}]),{"van-hairline--surround":f}];return t(a,s()([{class:v,attrs:{type:e.nativeType,disabled:u},on:{click:p,touchstart:g}},Object(l["b"])(n)]),[h?[t(c["a"],{attrs:{size:e.loadingSize,color:"default"===r?void 0:""}}),b&&t("span",{class:d("loading-text")},[b])]:t("span",{class:d("text")},[i["default"]?i["default"]():e.text])])}f.props=Object(n["a"])({},o["c"],{text:String,block:Boolean,plain:Boolean,round:Boolean,square:Boolean,loading:Boolean,hairline:Boolean,disabled:Boolean,nativeType:String,loadingText:String,bottomAction:Boolean,tag:{type:String,default:"button"},type:{type:String,default:"default"},size:{type:String,default:"normal"},loadingSize:{type:String,default:"20px"}}),e["a"]=h(f)},be7f:function(t,e,i){"use strict";i("68ef"),i("1146")},c194:function(t,e,i){"use strict";i("68ef")},dfaf:function(t,e,i){"use strict";i.d(e,"a",function(){return n});var n={icon:String,size:String,center:Boolean,isLink:Boolean,required:Boolean,titleStyle:null,titleClass:null,valueClass:null,labelClass:null,title:[String,Number],value:[String,Number],label:[String,Number],border:{type:Boolean,default:!0}}}}]);