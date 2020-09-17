(function() {
	function toggleNewGroup(group, newGroup) {
		var isNew = group.value === "new";
		newGroup.parentElement.style.display = isNew ? "block" : "none";
	}
	
	function formatCurrency(el) {
		var num = el.value.replace(/[^\d\.]/g, "").replace(/\./, "x").replace(/\./g, "").replace(/x/, ".").replace(/^\.$/, '');
		el.value = num.length > 0 ? '$' + Number(num).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') : '';
	}
	
	function events() {
		var group    = document.getElementById("group");
		var newGroup = document.getElementById("newGroup");
		var cost     = document.getElementById("cost");

		group.addEventListener("change", toggleNewGroup.bind(this, group, newGroup));
		cost.addEventListener("blur", formatCurrency.bind(this, cost));
	}
	
	events();	
	toggleNewGroup(group, newGroup);
})();