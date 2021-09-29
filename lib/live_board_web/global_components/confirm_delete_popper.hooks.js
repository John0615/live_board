import { createPopper } from '@popperjs/core';


let ConfirmDeletePopperHook = {
	initPopper(position_id) {
		const popcorn = document.getElementById(position_id) || document.querySelector('body');
		const tooltip = document.querySelector('#confirm_delete_popper_container');

		createPopper(popcorn, tooltip, {
			placement: 'right',
			modifiers: [
				{
					name: 'offset',
					options: {
						offset: [0, 8],
					},
				},
			],
		});
		window.dispatchEvent(new CustomEvent("showconfirmdeletepopper"))
	},
	updated() {
		this.initPopper(this.el.dataset.position_id)
	}
}

export { ConfirmDeletePopperHook };