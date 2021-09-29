import ClipboardJS from "clipboard";

let CardCheckListHook = {
    init() {
		document.querySelector('#card_check_list_container').addEventListener('click', function (e) {
			let event = e || window.event;
			let target = event.target || event.srcElement;
			let currentTarget = event.currentTarget;
			while (target !== currentTarget) {
				if (target.matches('a')) {
                    event.stopPropagation(); 
				}
				target = target.parentNode;
			}
		})
	},
	initClipboard() {
		this.clipboard = new ClipboardJS('.copy-check-list-item');
		this.clipboard.on('success', (e) => {
			console.log("复制成功")
			e.clearSelection();
		});
		this.clipboard.on('error', (e) => console.log("复制失败"));
	},
    mounted() {
        this.init()
		this.initClipboard()
		window.CardCheckListHook = this
    }
}

export {CardCheckListHook};