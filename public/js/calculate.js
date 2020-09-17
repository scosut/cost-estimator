(function() {
	var data = {};
	data.materials = {};
	data.tasks     = {};

	function Material(id, value, quantity) {
		this.id       = id;
		this.value    = value;
		this.quantity = quantity;

		this.calculate();
	}

	Material.prototype.calculate = function() {
		this.cost = Number((this.value * this.quantity).toFixed(2));
	}

	function Task(id, minutes, seconds, rate) {
		this.id      = id;
		this.minutes = minutes;
		this.seconds = seconds;
		this.rate    = rate;

		this.calculate();
	}

	Task.prototype.calculate = function() {
		this.cost = Number((((this.minutes/60) + (this.seconds/(60*60))) * this.rate).toFixed(2));
	}

	function material_click(el) {
		if (el.checked) {
			var selQty = document.getElementById(el.id+"Qty");
			var valQty = selQty ? Number(selQty.value) : 1;
			data.materials[el.id] = new Material(el.id, Number(el.value), valQty);
		}
		else {
			delete data.materials[el.id];
		}
	}

	function quantity_change(el) {
		var id = el.id.replace("Qty", "");
		if (data.materials.hasOwnProperty(id)) {
			data.materials[id].quantity = Number(el.value);
			data.materials[id].calculate();
		}
	}

	function task_click(el) {
		if (el.checked) {
			var arr = el.value.split(";;;").map(function(item) { return Number(item); });
			data.tasks[el.id] = new Task(el.id, arr[0], arr[1], arr[2]);
		}
		else {
			delete data.tasks[el.id];
		}
	}

	function formatCurrency(num) {
		return '$' + Number(num).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
	}	

	function getArray(col) {
		return Array.prototype.slice.call(col);
	}

	function getCost(obj) {
		var costs = Object.keys(obj).map(function(o) {
			return obj[o].cost;
		});

		if (costs.length > 0) {
			return costs.reduce(function(total, num) {
				return total+num;
			});
		}
		else {
			return costs;
		}
	}
	
	function getMessage(txt) {
		var div = document.createElement("div");
		var txt = document.createTextNode(txt)
		var ul  = document.createElement("ul");	

		div.className = "form-errors fadeIn";
		div.appendChild(txt);
		div.appendChild(ul);

		return div;
	}

	function stripNonNumbers(qty) {
		qty.value = qty.value.replace(/[^0-9]/g, "");;
	}

	function toggleCheckboxes(col, bln, func, e) {
		e.preventDefault();

		getArray(col).forEach(function(c) {
			c.checked = bln;
			func(c);

			var qty = document.getElementById(c.id+"Qty");

			if (qty) {
				qty.selectedIndex = 0;
			}
		});
	}
	
	function togglePages(btn1, btn2, pg1, pg2, qty, e) {
		var val = btn1.innerHTML.toLowerCase();
		var bln = e && val === "next";
		qty.parentElement.className = bln ? "form-group fadeOut" : "form-group fadeIn";
		pg1.className  = bln ? "fadeOut"   : "fadeIn";
		pg2.className  = bln ? "fadeIn"    : "fadeOut";
		btn1.innerHTML = bln ? "Back"      : "Next";
		btn2.innerHTML = bln ? "Calculate" : "Reset";
	}

	function clearErrors() {
			var div = document.querySelector(".form-errors");

			if (div) {
				div.className = ".form-errors fadeOut";
			}	
		}

	function displayErrors(arr, frm) {
		var div = getMessage("Errors:");

		arr.forEach(function(err) {
			var li = document.createElement("li");
			li.innerHTML = err;

			div.lastElementChild.appendChild(li);
		});

		frm.parentElement.insertBefore(div, frm);
		div.scrollIntoView();
	}

	function displayTotals(obj, frm) {
		var div = getMessage("Costs:");
		div.lastElementChild.className = "costs";

		Object.keys(obj).forEach(function(key) {
			var li = document.createElement("li");
			var s1 = document.createElement("span");
			var s2 = document.createElement("span");

			s1.innerHTML = key + ":";
			s2.innerHTML = obj[key];

			li.appendChild(s1);
			li.appendChild(s2);
			div.lastElementChild.appendChild(li);
		});

		frm.parentElement.insertBefore(div, frm);
		div.scrollIntoView();
	}

	function validate(qty, mat, tsk) {
		var err = [];

		if (qty.value.length === 0) {
			err.push("Please provide a quantity.");
		}

		if (mat.length === 0) {
			err.push("Please select a material.");
		}

		if (tsk.length === 0) {
			err.push("Please select a task.");
		}

		return err.length > 0 ? err : null;
	}

	function calculate(btn, qty, mat, tsk, frm) {	
		var val = btn.innerHTML.toLowerCase();

		clearErrors();

		if (val === "reset") {
			frm.reset();
			data.materials = {};
			data.tasks = {};
			return;
		}

		var mat = getCost(data.materials);
		var tsk = getCost(data.tasks);

		err = validate(qty, mat, tsk);

		if (err) {
			displayErrors(err, frm);			
			return;
		}

		var sum = mat + tsk;
		var ttl = Number(qty.value) * sum;

		var obj = {
			"Materials": formatCurrency(mat),
			"Labor": formatCurrency(tsk),
			"Per Leo": formatCurrency(sum),
			"Quantity": qty.value,
			"Total": formatCurrency(ttl)
		}

		displayTotals(obj, frm);
	}

	function events() {
		var mat    = document.querySelectorAll("input[type='checkbox'][id^='materials']");
		var tsk    = document.querySelectorAll("input[type='checkbox'][id^='tasks']");
		var selQty = document.querySelectorAll("select[id$='Qty']");		
		var all    = document.querySelectorAll("[id$='-select'], [id$='-clear']");
		var txtQty = document.getElementById("quantity");
		var btn1   = document.getElementById("btn1");
		var btn2   = document.getElementById("btn2");	
		var pg1    = document.getElementById("materials-page");
		var pg2    = document.getElementById("tasks-page");
		var frm    = document.getElementById("frmCalculate");

		getArray(mat).forEach(function(m) {
			m.addEventListener("click", material_click.bind(this, m));
		});

		getArray(tsk).forEach(function(t) {
			t.addEventListener("click", task_click.bind(this, t));
		});

		getArray(selQty).forEach(function(q) {
			q.addEventListener("change", quantity_change.bind(this, q));
		});

		getArray(all).forEach(function(a) {
			var col  = a.id.indexOf("materials") >= 0 ? mat  : tsk;
			var bln  = a.id.indexOf("-select")   >= 0 ? true : false;
			var func = a.id.indexOf("materials") >= 0 ? material_click : task_click;

			a.addEventListener("click", toggleCheckboxes.bind(this, col, bln, func));
		});

		txtQty.addEventListener("blur", stripNonNumbers.bind(this, txtQty));
		btn1.addEventListener("click", togglePages.bind(this, btn1, btn2, pg1, pg2, txtQty));
		btn2.addEventListener("click", calculate.bind(this, btn2, txtQty, mat, tsk, frm));

		togglePages(btn1, btn2, pg1, pg2, txtQty);
	}

	events();
})();