(function(e){function n(n){for(var c,a,r=n[0],i=n[1],h=n[2],l=0,s=[];l<r.length;l++)a=r[l],u[a]&&s.push(u[a][0]),u[a]=0;for(c in i)Object.prototype.hasOwnProperty.call(i,c)&&(e[c]=i[c]);d&&d(n);while(s.length)s.shift()();return o.push.apply(o,h||[]),t()}function t(){for(var e,n=0;n<o.length;n++){for(var t=o[n],c=!0,a=1;a<t.length;a++){var r=t[a];0!==u[r]&&(c=!1)}c&&(o.splice(n--,1),e=i(i.s=t[0]))}return e}var c={},a={app:0},u={app:0},o=[];function r(e){return i.p+"js/"+({}[e]||e)+"."+{"chunk-02520f7f":"6205dd24","chunk-02672fb4":"8b3c2cc3","chunk-0baf5ea2":"bef582d7","chunk-5273bd77":"d4c20bce","chunk-ef2ff39e":"176b5e47","chunk-0d94ceac":"ffa09a8c","chunk-129916b2":"2fb2ed7e","chunk-138f16d9":"2d909471","chunk-151ae29a":"b2ea9157","chunk-1e574bee":"aa17eb92","chunk-2d3062ec":"6b818d96","chunk-2de5bab9":"9fe4e2f3","chunk-4d592360":"bd8b3269","chunk-544a5523":"a16eef18","chunk-5ccbc672":"50ceb938","chunk-6eda6e79":"716bd69b","chunk-11e9f0c4":"dfad86fb","chunk-44654e08":"7fc0210a","chunk-12d41ee5":"b65bb960","chunk-624da486":"6e712d68","chunk-655de42e":"682f0122","chunk-75c6062c":"c9be437c","chunk-785271b2":"3e5faddb","chunk-7fa05cea":"d44770a4","chunk-82329978":"aa42d381","chunk-978cf9d0":"e51f9c7f","chunk-ad4f6e82":"0763b6f9","chunk-ae21b65a":"89e5d4b9","chunk-13b77940":"30c36b9d","chunk-1cb90784":"4c86f6d0","chunk-350d4616":"36f39430","chunk-4d3e6d46":"bee2a26e","chunk-c2c5cdf6":"2265b1e2","chunk-0a094505":"d782f366","chunk-0a637a4a":"fa134e75","chunk-24b77e34":"f2321f7a","chunk-cc82f330":"e5124d35","chunk-1687e95c":"bd14ff3c","chunk-56142cea":"981823cf"}[e]+".js"}function i(n){if(c[n])return c[n].exports;var t=c[n]={i:n,l:!1,exports:{}};return e[n].call(t.exports,t,t.exports,i),t.l=!0,t.exports}i.e=function(e){var n=[],t={"chunk-02520f7f":1,"chunk-02672fb4":1,"chunk-0baf5ea2":1,"chunk-5273bd77":1,"chunk-ef2ff39e":1,"chunk-0d94ceac":1,"chunk-129916b2":1,"chunk-138f16d9":1,"chunk-151ae29a":1,"chunk-1e574bee":1,"chunk-2d3062ec":1,"chunk-2de5bab9":1,"chunk-4d592360":1,"chunk-544a5523":1,"chunk-5ccbc672":1,"chunk-6eda6e79":1,"chunk-11e9f0c4":1,"chunk-44654e08":1,"chunk-12d41ee5":1,"chunk-624da486":1,"chunk-655de42e":1,"chunk-75c6062c":1,"chunk-785271b2":1,"chunk-7fa05cea":1,"chunk-82329978":1,"chunk-978cf9d0":1,"chunk-ad4f6e82":1,"chunk-ae21b65a":1,"chunk-13b77940":1,"chunk-1cb90784":1,"chunk-350d4616":1,"chunk-4d3e6d46":1,"chunk-c2c5cdf6":1,"chunk-0a094505":1,"chunk-0a637a4a":1,"chunk-24b77e34":1,"chunk-cc82f330":1,"chunk-1687e95c":1,"chunk-56142cea":1};a[e]?n.push(a[e]):0!==a[e]&&t[e]&&n.push(a[e]=new Promise(function(n,t){for(var c="css/"+({}[e]||e)+"."+{"chunk-02520f7f":"37893ed1","chunk-02672fb4":"4a9a597b","chunk-0baf5ea2":"396dcc60","chunk-5273bd77":"f4b25038","chunk-ef2ff39e":"81dac7c3","chunk-0d94ceac":"9c24141f","chunk-129916b2":"af354d34","chunk-138f16d9":"d890b63b","chunk-151ae29a":"8e64dc01","chunk-1e574bee":"3d7d1684","chunk-2d3062ec":"24c69ad9","chunk-2de5bab9":"406d1440","chunk-4d592360":"3fa17dcb","chunk-544a5523":"aad11306","chunk-5ccbc672":"aad11306","chunk-6eda6e79":"69a718d7","chunk-11e9f0c4":"e699b4f4","chunk-44654e08":"f261db70","chunk-12d41ee5":"21a81727","chunk-624da486":"9592b3e5","chunk-655de42e":"48a0f2d6","chunk-75c6062c":"4a910eed","chunk-785271b2":"53dc8178","chunk-7fa05cea":"a608543f","chunk-82329978":"f869f6bc","chunk-978cf9d0":"2ff1fc7a","chunk-ad4f6e82":"0fa95cf4","chunk-ae21b65a":"ad8a4920","chunk-13b77940":"01f77e50","chunk-1cb90784":"37820abe","chunk-350d4616":"983302d4","chunk-4d3e6d46":"cce70961","chunk-c2c5cdf6":"ddd7eac8","chunk-0a094505":"37f0f8af","chunk-0a637a4a":"4c0350c1","chunk-24b77e34":"21a55f31","chunk-cc82f330":"aa60822e","chunk-1687e95c":"35402d21","chunk-56142cea":"9e5ff8de"}[e]+".css",u=i.p+c,o=document.getElementsByTagName("link"),r=0;r<o.length;r++){var h=o[r],l=h.getAttribute("data-href")||h.getAttribute("href");if("stylesheet"===h.rel&&(l===c||l===u))return n()}var s=document.getElementsByTagName("style");for(r=0;r<s.length;r++){h=s[r],l=h.getAttribute("data-href");if(l===c||l===u)return n()}var d=document.createElement("link");d.rel="stylesheet",d.type="text/css",d.onload=n,d.onerror=function(n){var c=n&&n.target&&n.target.src||u,o=new Error("Loading CSS chunk "+e+" failed.\n("+c+")");o.request=c,delete a[e],d.parentNode.removeChild(d),t(o)},d.href=u;var f=document.getElementsByTagName("head")[0];f.appendChild(d)}).then(function(){a[e]=0}));var c=u[e];if(0!==c)if(c)n.push(c[2]);else{var o=new Promise(function(n,t){c=u[e]=[n,t]});n.push(c[2]=o);var h,l=document.createElement("script");l.charset="utf-8",l.timeout=120,i.nc&&l.setAttribute("nonce",i.nc),l.src=r(e),h=function(n){l.onerror=l.onload=null,clearTimeout(s);var t=u[e];if(0!==t){if(t){var c=n&&("load"===n.type?"missing":n.type),a=n&&n.target&&n.target.src,o=new Error("Loading chunk "+e+" failed.\n("+c+": "+a+")");o.type=c,o.request=a,t[1](o)}u[e]=void 0}};var s=setTimeout(function(){h({type:"timeout",target:l})},12e4);l.onerror=l.onload=h,document.head.appendChild(l)}return Promise.all(n)},i.m=e,i.c=c,i.d=function(e,n,t){i.o(e,n)||Object.defineProperty(e,n,{enumerable:!0,get:t})},i.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},i.t=function(e,n){if(1&n&&(e=i(e)),8&n)return e;if(4&n&&"object"===typeof e&&e&&e.__esModule)return e;var t=Object.create(null);if(i.r(t),Object.defineProperty(t,"default",{enumerable:!0,value:e}),2&n&&"string"!=typeof e)for(var c in e)i.d(t,c,function(n){return e[n]}.bind(null,c));return t},i.n=function(e){var n=e&&e.__esModule?function(){return e["default"]}:function(){return e};return i.d(n,"a",n),n},i.o=function(e,n){return Object.prototype.hasOwnProperty.call(e,n)},i.p="",i.oe=function(e){throw console.error(e),e};var h=window["webpackJsonp"]=window["webpackJsonp"]||[],l=h.push.bind(h);h.push=n,h=h.slice();for(var s=0;s<h.length;s++)n(h[s]);var d=l;o.push([0,"chunk-vendors"]),t()})({0:function(e,n,t){e.exports=t("56d7")},"034f":function(e,n,t){"use strict";var c=t("64a9"),a=t.n(c);a.a},"56d7":function(e,n,t){"use strict";t.r(n);t("cadf"),t("551c"),t("f751"),t("097d");var c,a=t("2b0e"),u=function(){var e=this,n=e.$createElement,t=e._self._c||n;return t("div",{attrs:{id:"app"}},[t("van-nav-bar",{attrs:{title:"","left-text":"","left-arrow":""},on:{"click-left":e.onClickLeft}}),t("router-view"),t("van-popup",{attrs:{position:"top",overlay:!1},model:{value:e.show,callback:function(n){e.show=n},expression:"show"}},[t("router-link",{attrs:{to:"/home"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("网站首页")])])]),t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span",on:{click:function(n){return e.change(0)}}},[e._v("新闻中心")])]),t("router-link",{attrs:{to:"/introduction"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("中心简介")])])]),t("router-link",{attrs:{to:"/mechanism"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("机构职能")])])]),t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span",on:{click:function(n){return e.change(1)}}},[e._v("党建工作")])]),t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span",on:{click:function(n){return e.change(2)}}},[e._v("政务公开")])]),t("router-link",{attrs:{to:"/goods_list"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("订书订报")])])]),t("router-link",{attrs:{to:"/xbsb_list"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("小博士报")])])]),t("router-link",{attrs:{to:"/bbs_list"}},[t("div",{staticClass:"pop"},[t("p",{staticClass:"pop_span"},[e._v("论坛")])])])],1),t("van-tabbar",{directives:[{name:"show",rawName:"v-show",value:e.tabbarShow,expression:"tabbarShow"}],model:{value:e.active,callback:function(n){e.active=n},expression:"active"}},[t("van-tabbar-item",{attrs:{icon:"home-o"},on:{click:function(n){return e.go("/home")}}},[e._v("\n\t\t\t首页\n\t\t")]),t("van-tabbar-item",{on:{click:function(n){return e.go("/user")}},scopedSlots:e._u([{key:"icon",fn:function(n){return t("img",{attrs:{src:n.active?e.icon.active:e.icon.normal}})}}])},[t("span",[e._v("个人中心")])])],1)],1)},o=[],r=t("bd86"),i=(t("a52c"),t("2ed4")),h=(t("537a"),t("ac28")),l=(t("8a58"),t("e41f")),s=(t("5246"),t("6b41")),d={watch:{$route:function(e,n){for(var t=0;t<this.tabbarMap.length;t++)if(this.tabbarMap[t]==e.path){this.active=t;break}for(t=0;t<this.tabbarList.length;t++){if(e.path==this.tabbarList[t]){this.tabbarShow=!0,document.body.style.marginBottom="50px";break}this.tabbarShow=!1,document.body.style.marginBottom="0px"}this.show=!1}},components:(c={},Object(r["a"])(c,s["a"].name,s["a"]),Object(r["a"])(c,l["a"].name,l["a"]),Object(r["a"])(c,h["a"].name,h["a"]),Object(r["a"])(c,i["a"].name,i["a"]),c),data:function(){return{tabbarMap:["/home","/goods_list","/cart","/user"],tabbarList:["/news_list","/home","/user","/goods_list","/news_details","/introduction","/mechanism"],tabbarShow:!0,show:!1,active:0,icon:{normal:"https://img.yzcdn.cn/public_files/2017/10/13/c547715be149dd3faa817e4a948b40c4.png",active:"https://img.yzcdn.cn/public_files/2017/10/13/793c77793db8641c4c325b7f25bf130d.png"}}},created:function(){null!=this.$route.query.active&&(this.active=this.$route.query.active),console.log(this.$route.query)},methods:{go:function(e){this.$router.push({path:e})},change:function(e){var n=this,t=!1;"/news_list"==this.$route.path&&(t=!0),this.$router.push({path:"/news_list",query:{index:e}}),console.log(t),1==t&&setTimeout(function(){n.$router.go(0)},300)},onClickLeft:function(){this.$router.back()},onClickRight:function(){this.show=!this.show}}},f=d,b=(t("034f"),t("2877")),p=Object(b["a"])(f,u,o,!1,null,null,null),k=p.exports,m=(t("ac6a"),t("e7e5"),t("d399")),g=t("8c4f"),v=t("2b27"),_=t.n(v),w=t("bc3a"),y=t.n(w),L=t("b1ef");a["a"].use(m["a"]),a["a"].use(_.a),a["a"].use(g["a"]);var x=[{path:"*",redirect:"/home"},{name:"user",component:function(){return t.e("chunk-2d3062ec").then(t.bind(null,"718b"))},meta:{title:"会员中心",requireLogin:!0}},{name:"message",component:function(){return Promise.all([t.e("chunk-ae21b65a"),t.e("chunk-1cb90784")]).then(t.bind(null,"1e62"))},meta:{title:"我的消息",requireLogin:!0}},{name:"collection",component:function(){return Promise.all([t.e("chunk-ae21b65a"),t.e("chunk-13b77940")]).then(t.bind(null,"8df8"))},meta:{title:"我的收藏",requireLogin:!0}},{name:"change_password",component:function(){return t.e("chunk-82329978").then(t.bind(null,"01b2"))},meta:{title:"修改密码",requireLogin:!0}},{name:"cart",component:function(){return t.e("chunk-544a5523").then(t.bind(null,"da2a"))},meta:{title:"购物车",requireLogin:!0}},{name:"xbsb_cart",component:function(){return t.e("chunk-5ccbc672").then(t.bind(null,"913f"))},meta:{title:"购物车"}},{name:"goods",component:function(){return Promise.all([t.e("chunk-6eda6e79"),t.e("chunk-44654e08"),t.e("chunk-624da486")]).then(t.bind(null,"c2c6"))},meta:{title:"商品详情"}},{name:"xbsb_goods",component:function(){return Promise.all([t.e("chunk-6eda6e79"),t.e("chunk-44654e08"),t.e("chunk-12d41ee5")]).then(t.bind(null,"f9a8"))},meta:{title:"欢迎订阅《小博士报》"}},{name:"xbsb_address",component:function(){return Promise.all([t.e("chunk-c2c5cdf6"),t.e("chunk-0a637a4a")]).then(t.bind(null,"f3d9"))},meta:{title:"填写信息"}},{name:"xbsb_list",component:function(){return Promise.all([t.e("chunk-0baf5ea2"),t.e("chunk-ef2ff39e")]).then(t.bind(null,"92d2"))},meta:{title:"欢迎订阅《小博士报》"}},{name:"goods_list",component:function(){return t.e("chunk-785271b2").then(t.bind(null,"d74f"))},meta:{title:"订书订报"}},{name:"home",component:function(){return t.e("chunk-02520f7f").then(t.bind(null,"a411"))},meta:{title:"首页"}},{name:"person",component:function(){return t.e("chunk-7fa05cea").then(t.bind(null,"05a7"))},meta:{title:"个人中心",requireLogin:!0}},{name:"person_update",component:function(){return t.e("chunk-75c6062c").then(t.bind(null,"b542"))},meta:{title:"用户设置",requireLogin:!0}},{name:"forget",component:function(){return t.e("chunk-1e574bee").then(t.bind(null,"c413"))},meta:{title:"重置密码"}},{name:"login",component:function(){return t.e("chunk-02672fb4").then(t.bind(null,"e49c"))},meta:{title:"登录"}},{name:"register",component:function(){return t.e("chunk-129916b2").then(t.bind(null,"3d01"))},meta:{title:"注册"}},{name:"news_list",component:function(){return t.e("chunk-4d592360").then(t.bind(null,"443a"))},meta:{title:"新闻中心"}},{name:"news_details",component:function(){return Promise.all([t.e("chunk-6eda6e79"),t.e("chunk-11e9f0c4")]).then(t.bind(null,"afcb"))},meta:{title:"新闻详情"}},{name:"introduction",component:function(){return t.e("chunk-151ae29a").then(t.bind(null,"3832"))},meta:{title:"中心简介"}},{name:"mechanism",component:function(){return t.e("chunk-138f16d9").then(t.bind(null,"2964"))},meta:{title:"机构职能"}},{name:"address_list",component:function(){return t.e("chunk-ad4f6e82").then(t.bind(null,"8428"))},meta:{title:"地址管理",requireLogin:!0}},{name:"address_add",component:function(){return Promise.all([t.e("chunk-c2c5cdf6"),t.e("chunk-0a094505")]).then(t.bind(null,"7342"))},meta:{title:"添加地址",requireLogin:!0}},{name:"address_update",component:function(){return Promise.all([t.e("chunk-c2c5cdf6"),t.e("chunk-24b77e34")]).then(t.bind(null,"9e1f"))},meta:{title:"修改地址",requireLogin:!0}},{name:"order_add",component:function(){return Promise.all([t.e("chunk-0baf5ea2"),t.e("chunk-5273bd77")]).then(t.bind(null,"1547"))},meta:{title:"填写订单",requireLogin:!0}},{name:"order_finish",component:function(){return t.e("chunk-2de5bab9").then(t.bind(null,"1633"))},meta:{title:"完成订单",requireLogin:!0}},{name:"order_list",component:function(){return t.e("chunk-0d94ceac").then(t.bind(null,"16bf"))},meta:{title:"我的订单",requireLogin:!0}},{name:"order_details",component:function(){return t.e("chunk-978cf9d0").then(t.bind(null,"34ef"))},meta:{title:"订单详情",requireLogin:!0}},{name:"bbs_list",component:function(){return Promise.all([t.e("chunk-ae21b65a"),t.e("chunk-350d4616")]).then(t.bind(null,"d4b3"))},meta:{title:"论坛列表"}},{name:"my_bbs_list",component:function(){return Promise.all([t.e("chunk-ae21b65a"),t.e("chunk-4d3e6d46")]).then(t.bind(null,"b554"))},meta:{title:"我的帖子",requireLogin:!0}},{name:"bbs_details",component:function(){return Promise.all([t.e("chunk-6eda6e79"),t.e("chunk-655de42e")]).then(t.bind(null,"dc1d"))},meta:{title:"论坛详情"}},{name:"bbs_add",component:function(){return Promise.all([t.e("chunk-cc82f330"),t.e("chunk-1687e95c")]).then(t.bind(null,"a44f"))},meta:{title:"新建帖子",requireLogin:!0}},{name:"bbs_edit",component:function(){return Promise.all([t.e("chunk-cc82f330"),t.e("chunk-56142cea")]).then(t.bind(null,"7b83"))},meta:{title:"编辑帖子",requireLogin:!0}}];x.forEach(function(e){e.path=e.path||"/"+(e.name||"")});var C=new g["a"]({routes:x});C.beforeEach(function(e,n,c){var a=e.meta&&e.meta.title,u=t("2b27");C.options.routes.length;a&&(document.title=a),e.meta.requireLogin?(y()({method:"post",url:L["a"].baseURL+"appsite/selectUserInfo",params:{cen_xczhapp_token:u.get("cen_xczhapp_token")}}).then(function(e){0==e.data.status&&(Object(m["a"])("请先登录"),c({path:"/login"}))}).catch(function(e){console.log("请求失败："+e),Object(m["a"])("登录失败"),c({path:"/login"})}),null!=u.get("cen_xczhapp_token")?c():(Object(m["a"])("请先登录"),c({path:"/login"}))):c()});var P=t("953d"),q=t.n(P);t("a753"),t("8096"),t("14e1");a["a"].use(q.a),new a["a"]({router:C,el:"#app",render:function(e){return e(k)}})},"64a9":function(e,n,t){},b1ef:function(e,n,t){"use strict";t("cadf"),t("551c"),t("f751"),t("097d");var c="http://www.gxkpcb.com/",a="http://www.gxkpcb.com/uploadFiles/photo";n["a"]={baseURL:c,resoursePhoto:a}}});