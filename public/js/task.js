(function() {
	function formatCurrency(el) {
		var num = el.value.replace(/[^\d\.]/g, "").replace(/\./, "x").replace(/\./g, "").replace(/x/, ".").replace(/^\.$/, '');
		el.value = num.length > 0 ? '$' + Number(num).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') : '';
	}
	
	function formatInteger(el) {
		el.value = el.value.replace(/[^\d]/g, "");
	}
	
	function events() {
		var minutes = document.getElementById("minutes");
		var seconds = document.getElementById("seconds");
		var rate    = document.getElementById("rate");

		minutes.addEventListener("blur", formatInteger.bind(this, minutes));
		seconds.addEventListener("blur", formatInteger.bind(this, seconds));
		rate.addEventListener("blur", formatCurrency.bind(this, rate));
	}
	
	events();
})();