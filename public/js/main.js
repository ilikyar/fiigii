$(document).ready(function() {
	$("#send").click(function() {
		var to_url = "" + $("#url").val() + $("#format").val();
		var args = "";
		var inupt_arg = $("#arguments").val();
		console.log(inupt_arg)
		if (inupt_arg === "") {
			args = null;
		} else {
			try {
				args = JSON.parse(inupt_arg || "null");
			} catch(e) {
				alert("参数不正确\n" + e);
				return {};
			}
		};
		$.ajax({
			url: to_url,
			type: $("#method").val(),
			data: args,
			dataType: $("#format").find("option:selected").text(),

			success: function(response, x, xhr) {
				$("#show").val(add_indentation(JSON.stringify(xhr.responseText)));
				console.log(JSON.stringify(xhr.responseText))
				$("#error_show").val("");
			},
			error: function(xhr, str, x) {
				$("#show").val("");
				$("#error_show").val("" + str + ": " + xhr.status.toString());
			},
		});
	});

	$("#clear_button").click(function () {
		$("#arguments").val("");
	});
});

function add_indentation (str) {
	var result = "";
	var level = 0;
	for (var i = 0; i < str.length; i++) {
		if (str.charAt(i) === "[" || str.charAt(i) === "{") {
			result += str.charAt(i) + "\n";
			level ++;
			for (var j = 0; j < level; j++) {
				result += "    ";
			};
		} else if (str.charAt(i) === "]" || str.charAt(i) === "}") {
			result += "\n";
			level --;
			for (var j = 0; j < level; j++) {
				result += "    ";
			};
			result += str.charAt(i);
		} else if (str.charAt(i) === ":") {
			result += str.charAt(i) + " ";
		} else if (str.charAt(i) === ",") {
			result += str.charAt(i) + "\n";
			for (var j = 0; j < level; j++) {
				result += "    ";
			};
		} else {
			if (str.charAt(i) !== "\\") {
				result += str.charAt(i);
			}
		};
	};
	return result;
}
