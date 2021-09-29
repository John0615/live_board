

let BoardAsideMenuHook = {
	updated() {
		if(this.el.dataset.active_tab) {
			window.dispatchEvent(new CustomEvent("showasidemenu"))
		}
	}
}

export { BoardAsideMenuHook };