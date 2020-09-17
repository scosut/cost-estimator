(function() {
	function getArray(col) {
		return Array.prototype.slice.call(col);
	}

	function deactivateLinks(lnk) {
		getArray(lnk).forEach(function(l) {
			l.className = "";
		});
	}

	function hideAllPages(pgs) {
		getArray(pgs).forEach(function(pg) {
			pg.style.display = "none";
		});
	}

	function displayPage(pgs, lnk, ndx, e) {
		if (e) {
			e.preventDefault();
		}

		deactivateLinks(lnk);
		hideAllPages(pgs);

		pgs[ndx].style.display = "table";
		lnk[ndx].className = "active";

	}

	function events() {
		var pgs = document.querySelectorAll(".pg");
		var lnk = document.querySelectorAll(".dashboard-pages a");

		getArray(lnk).forEach(function(l, ndx) {
			l.addEventListener("click", displayPage.bind(this, pgs, lnk, ndx));
		});

		displayPage(pgs, lnk, 0);
	}

	events();
})();