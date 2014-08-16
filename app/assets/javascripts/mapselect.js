// 遅くなってごめん，JS地図座標取得の添付してます．
// mapselect.jsのlat_rawとlng_rawの変数，
// あとHTMLの方のid="indicator_lat"とid="indicator_lng"の要素に取得した緯度経度を引っ張り出してきてる．
// 
// new.html.erbとそのコントローラから
// GETのパラメータか，クエリパラメータとして他のユーザ登録情報と一緒にサーバに投げるとDBに緯度経度を格納できるかな
// 参考：http://www.rubylife.jp/rails/controller/index6.html
// 
// 補足として，indicateCenter関数の中の緯度経度の桁揃え整形処理は見た目の問題のための処理なので，
// 緯度経度の数字自体をユーザには数字で見せないなら，ここはif (isShowLL)のブロックをガッツリ削ってOKです．

//パラメータ
var center_lat = 35.0;	//デフォルト緯度
var center_lng = 135.0;	//デフォルト経度
var map_zoom = 3;		//デフォルトズームレベル

var info_window_max_width = 300; //検索ボックスのサイズ

var decimal_places = 6;		//緯度・経度の小数点以下の表示桁数
var isShowLL = true //緯度経度の数値をユーザに見せるか(桁揃えを行うか行わないか)

var center_cross_image_file = "/assets/mapselect.png" //カーソル画像


//地図状態保持用変数
var map = null;
var center_cross_marker = null;

//検索結果格納用変数
var geocoder = null;
var geocode_results = null;
var geocode_index = 0;
var infowindow_search = null;

//取得緯度経度
var lat_raw = 35.0; //緯度
var lng_raw = 135.0; //経度

//初期設定
function load() {
	//地図初期設定
	var map_options = {
		zoom: map_zoom,
		center: new google.maps.LatLng(center_lat, center_lng),
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		scaleControl: true,
		overviewMapControl: true
	};
	map = new google.maps.Map(document.getElementById("map_canvas"), map_options);

	// 地図中心へのカーソルの表示
	var center_cross_image = new google.maps.MarkerImage(
		center_cross_image_file,
		new google.maps.Size(100, 100),
		new google.maps.Point(0, 0),
		new google.maps.Point(50, 50)
	);
	center_cross_marker = new google.maps.Marker(
		{
			map: map,
			position: map.getCenter(),
			icon: center_cross_image,
			clickable: false
		}
	);

	//ポイント移動時イベントハンドラ
	//緯度経度の更新&カーソルを常に中心に表示する
	google.maps.event.addListener(map, "center_changed", indicateCenter);
	google.maps.event.addListener(map, "zoom_changed", function () { indicateCenter(); });
	google.maps.event.addListener(map, "maptypeid_changed", function () { indicateCenter(); });
	indicateCenter();


	//検索ボックスの生成
	if (document.getElementById("search_box") != null) {
		if (document.getElementById("place") == null) {
			document.getElementById("search_box").innerHTML = ('<form action=\"#\" method=\"post\" onsubmit=\"searchPlace(this.place.value); return false;\">'
				+ '<input type=\"text\" id=\"place\" name=\"place\" size=\"60\" maxlength=\"2048\" value=\"\" title=\"地図を検索\"> '
				+ '<input type=\"submit\" value=\"検索\" id=\"button\">'
				+ '</form>');
		}
		geocoder = new google.maps.Geocoder();
		infowindow_search = new google.maps.InfoWindow({
			content: "",
			maxWidth: info_window_max_width
		});
		google.maps.event.addListener(infowindow_search, 'closeclick', function () {
			document.getElementById("place").value = "";
			document.getElementById("place").blur();
		});

	}

}

//緯度経度の更新&カーソルを中心に表示
function indicateCenter() {
	center_cross_marker.setPosition(map.getCenter());

	//地図から緯度経度取得
	lat_raw = map.getCenter().lat(); 
	lng_raw = map.getCenter().lng();
	//経度を-180～180度の範囲に丸める
	if (lng_raw > 180) {
		lng_raw = (lng_raw + 180) % 360 - 180;
	} else if (lng_raw < -180) {
		lng_raw = -1 * ((-1 * lng_raw + 180) % 360 - 180);
	}

	//緯度経度の桁揃え整形をしてから表示
	if (isShowLL)
	{
		//緯度の桁揃え表示
		var center_lat = (Math.round(lat_raw * Math.pow(10, decimal_places)) / Math.pow(10, decimal_places)) + "";
		var center_lat_decimal_point = center_lat.indexOf(".");
		if (center_lat_decimal_point == -1) {
			var center_lat_int = center_lat;
			var center_lat_dec = "";
		} else {
			var center_lat_int = center_lat.substring(0, center_lat_decimal_point);
			var center_lat_dec = center_lat.substring(center_lat_decimal_point + 1, center_lat.length);
		}
		while (center_lat_dec.length < decimal_places) {
			center_lat_dec += "0";
		}
		var center_lat_exp = center_lat_int + "." + center_lat_dec;
		// document.getElementById("indicator_lat").innerHTML = center_lat_exp;
		document.getElementById("member_latitude").value = center_lat_exp;

		//経度の桁揃え表示
		var center_lng = (Math.round(lng_raw * Math.pow(10, decimal_places)) / Math.pow(10, decimal_places)) + "";
		var center_lng_decimal_point = center_lng.indexOf(".");
		if (center_lng_decimal_point == -1) {
			var center_lng_int = center_lng;
			var center_lng_dec = "";
		} else {
			var center_lng_int = center_lng.substring(0, center_lng_decimal_point);
			var center_lng_dec = center_lng.substring(center_lng_decimal_point + 1, center_lng.length);
		}
		while (center_lng_dec.length < decimal_places) {
			center_lng_dec += "0";
		}
		var center_lng_exp = center_lng_int + "." + center_lng_dec;
		// document.getElementById("indicator_lng").innerHTML = center_lng_exp;
		document.getElementById("member_longitude").value = center_lng_exp;
	}
	else //DB格納用の数値そのまま表示
	{
		// document.getElementById("indicator_lat").innerHTML = lat_raw;
		// document.getElementById("indicator_lng").innerHTML = lng_raw;
		document.getElementById("member_latitude").value = lat_raw;
		document.getElementById("member_longitude").value = lng_raw;
	}

}

//テキスト検索機能関数
function searchPlace(place_query)
{
	if (geocoder)
	{
		infowindow_search.close();
		if (!(place_query.match(/^\s*$/)))
		{
			geocoder.geocode({ 'address': place_query }, function (results, status)
			{
				if (status == google.maps.GeocoderStatus.OK) //該当地点あり
				{
					geocode_results = results;
					geocode_index = 0;
					showResult(0);
				}
				else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) //該当地点無し
				{
					alert(place_query + " という場所は見つかりませんでした。");
					// document.getElementById("place").value = "";
				}
				else
				{
					alert("検索できませんでした。\nStatus: " + status);
				}
			});
		}
		else {
			document.getElementById("place").value = "";
		}
	}
}

//検索結果のポップアップ表示
function showResult(request) {
	if (request == 1) {
		geocode_index += 1;
		if (geocode_index > geocode_results.length - 1) {
			geocode_index = geocode_results.length - 1;
		}
	} else if (request == -1) {
		geocode_index -= 1;
		if (geocode_index < 0) {
			geocode_index = 0;
		}
	}

	map.fitBounds(geocode_results[geocode_index].geometry.viewport);
	map.setCenter(geocode_results[geocode_index].geometry.location);
	var infowindow_html = "<div>" + geocode_results[geocode_index].formatted_address + "</div>";

	//該当地名が複数あった場合(ex:浜松)
	if ((geocode_index > 0) || (geocode_index < geocode_results.length - 1)) {
		infowindow_html += "<div style=\"margin-top:1em; font-size:80%; line-height:150%;\">";
		if (geocode_index > 0) {
			infowindow_html += "<span style=\"color:blue;\" onclick=\"showResult(-1);\">≪ 前の検索結果</span>";
		}
		if ((geocode_index > 0) && (geocode_index < geocode_results.length - 1)) {
			infowindow_html += "<span style=\"color:gray;\"> || </span>";
		}
		if (geocode_index < geocode_results.length - 1) {
			infowindow_html += "<span style=\"color:blue;\" onclick=\"showResult(1);\">次の検索結果 ≫</span>";
		}
		infowindow_html += "</div>";
	}

	//地図に反映
	infowindow_search.setPosition(geocode_results[geocode_index].geometry.location);
	infowindow_search.setContent(infowindow_html);
	infowindow_search.open(map);
}

//HTMLとJSの接続
window.onload = load;
window.onresize = function () { google.maps.event.trigger(map, 'resize'); indicateCenter(); }
