(function () {	
	function close(el) {	
		if (el) {
			var par = el.parentElement;
			par.className = "fadeOut";
		}
	}
	
	var el = document.getElementById("close");
	el.addEventListener("click", close.bind(this, el));
})();