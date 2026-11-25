(function () {
	"use strict";

	// Mobile navigation toggle.
	var header = document.querySelector(".site-header");
	var toggle = header && header.querySelector(".nav-toggle");
	if (toggle) {
		var setOpen = function (open) {
			header.classList.toggle("nav-open", open);
			toggle.setAttribute("aria-expanded", String(open));
			toggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
		};
		toggle.addEventListener("click", function () {
			setOpen(!header.classList.contains("nav-open"));
		});
		document.addEventListener("keydown", function (event) {
			if (event.key === "Escape" && header.classList.contains("nav-open")) {
				setOpen(false);
				toggle.focus();
			}
		});
		document.addEventListener("click", function (event) {
			if (header.classList.contains("nav-open") && !header.contains(event.target)) {
				setOpen(false);
			}
		});
	}

	// Contact form: GitHub Pages has no backend, so open a pre-filled email instead.
	var form = document.getElementById("contact-form");
	if (form) {
		form.addEventListener("submit", function (event) {
			event.preventDefault();
			var data = new FormData(form);
			var name = String(data.get("name") || "").trim();
			var email = String(data.get("email") || "").trim();
			var subject = String(data.get("subject") || "").trim() || "Hello from your portfolio";
			var message = String(data.get("message") || "").trim();
			var body = message + "\n\n— " + name + (email ? " <" + email + ">" : "");
			window.location.href = "mailto:" + form.dataset.to +
				"?subject=" + encodeURIComponent(subject) +
				"&body=" + encodeURIComponent(body);
		});
	}
}());
