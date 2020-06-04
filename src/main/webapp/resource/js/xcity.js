$.fn.xcity = function(pName,cName,aName){

    var p = $(this).find('select[lay-filter=province]');

    var c = $(this).find('select[lay-filter=city]');

    var a = $(this).find('select[lay-filter=area]');

    var cityList = [];

    var areaList = [];

    showP(provinceList);

    showC(cityList);

    showA(areaList);

    function showP(provinceList) {
        p.html('');

        is_pName = false;
        
        for (var i in provinceList) {
            
            if(pName==provinceList[i].name){
                is_pName = true;
                cityList = provinceList[i].cityList;
                p.append("<option selected value='"+provinceList[i].name+"'>"+provinceList[i].name+"</option>")
            }else{
                p.append("<option value='"+provinceList[i].name+"'>"+provinceList[i].name+"</option>")
            }
        }
        if(!is_pName){
            cityList = provinceList[0].cityList;
        }
        
    }

    function showC(cityList) {

        c.html('');

        is_cName = false;

        for (var i in cityList) {
            if(cName==cityList[i].name){
                is_cName = true;
                areaList = cityList[i].areaList;
                c.append("<option selected value='"+cityList[i].name+"'>"+cityList[i].name+"</option>")
            }else{
                c.append("<option value='"+cityList[i].name+"'>"+cityList[i].name+"</option>")
            }
        }

        if(!is_cName){
            areaList = cityList[0].areaList;
        }
    }

    function showA(areaList) {
        a.html('');           
                             
        for (var i in areaList) {
            
            if(aName==areaList[i]){
                a.append("<option selected value='"+areaList[i]+"'>"+areaList[i]+"</option>")
            }else{
                a.append("<option value='"+areaList[i]+"'>"+areaList[i]+"</option>")
            }
        }
    }

    form.render('select');

    form.on('select(province)', function(data){
        pName = data.value;
        showP(provinceList);
        showC(cityList);
        showA(areaList);
        form.render('select');
    });

    form.on('select(city)', function(data){
        cName = data.value;
        showC(cityList);
        showA(areaList);
        form.render('select');
    });



}
var provinceList = [          
{name:'广西壮族自治区', cityList:[		        
	{name:'南宁市',                                   
		areaList:['','兴宁区','青秀区','江南区','西乡塘区','良庆区','邕宁区','武鸣区','隆安县','马山县','上林县','宾阳县','横县']},		   
	{name:'柳州市', areaList:['','城中区','鱼峰区','柳南区','柳北区','柳江县','柳城县','鹿寨县','融安县','融水苗族自治县','三江侗族自治县']},		   
	{name:'桂林市', areaList:['','秀峰区','叠彩区','象山区','七星区','雁山区','阳朔县','临桂县','灵川县','全州县','兴安县','永福县','灌阳县','龙胜各族自治县','资源县','平乐县','荔蒲县','恭城瑶族自治县']},		   
	{name:'梧州市', areaList:['','万秀区','长洲区','苍梧县','藤县','蒙山县','岑溪市','龙圩区']},		   
	{name:'北海市', areaList:['','海城区','银海区','铁山港区','合浦县']},		   
	{name:'防城港市', areaList:['','港口区','防城区','上思县','东兴市']},		   
	{name:'钦州市', areaList:['','钦南区','钦北区','灵山县','浦北县']},		   
	{name:'贵港市', areaList:['','港北区','港南区','覃塘区','平南县','桂平市']},		   
	{name:'玉林市', areaList:['','玉州区','容县','陆川县','博白县','兴业县','北流市','福绵区']},		   
	{name:'百色市', areaList:['','右江区','田阳县','田东县','平果县','德保县','靖西县','那坡县','凌云县','乐业县','田林县','西林县','隆林各族自治县']},		   
	{name:'贺州市', areaList:['','八步区','昭平县','钟山县','富川瑶族自治县','平桂区']},		   
	{name:'河池市', areaList:['','金城江区','南丹县','天峨县','凤山县','东兰县','罗城仫佬族自治县','环江毛南族自治县','巴马瑶族自治县','都安瑶族自治县','大化瑶族自治县','宜州市']},		   
	{name:'来宾市', areaList:['','兴宾区','忻城县','象州县','武宣县','金秀瑶族自治县','合山市']},		   
	{name:'崇左市', areaList:['','江洲区','扶绥县','宁明县','龙州县','大新县','天等县','凭祥市']}
]}
];
