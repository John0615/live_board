import { createPopper } from '@popperjs/core';


let BoardSwitchDropdownHook = {
	init() {
		const popcorn = document.querySelector('.board-name');
		const tooltip = document.querySelector('#board_switch_dropdown_container');

		createPopper(popcorn, tooltip, {
			placement: 'bottom',
			modifiers: [
				{
					name: 'offset',
					options: {
						offset: [-50, 8],
					},
				},
			],
		});
	},
	mounted() {
		window.BoardSwitchDropdownHook = this
		this.init()
	},
	updated() {
		this.init()
	}
}

export { BoardSwitchDropdownHook };