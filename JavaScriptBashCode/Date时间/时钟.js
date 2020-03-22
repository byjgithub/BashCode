// Date时间对象案例3：使用Date对象表示时钟
<script type="text/javascript">
	function startTime() {
		var date = new Date(); //获取时间对象
		var year = date.getFullYear(); //年
		var month = checkTime(date.getMonth() + 1); //月
		var day = checkTime(date.getDate()); //日
		var hourse = date.getHours(); //时
		var minutes = checkTime(date.getMinutes()); //分
		var seconds = checkTime(date.getSeconds()); //秒
		var week = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
		var weekDay = week[date.getDay()]; //星期

		// 向HTML页面输出时间
		document.getElementById("txt3").innerHTML = year + "-" + month + "-" + day + "-  " + hourse + ":" + minutes + ":" + seconds + "    " + weekDay;
		t = setTimeout('startTime()', 500);
	}

	// 如果传入的参数小于10，则在参数前多输出一个0
	function checkTime(i) {
		if(i < 10) {
			i = "0" + 1;
		}
		return i;
	}
</script>