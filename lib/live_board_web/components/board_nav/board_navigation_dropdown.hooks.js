import { createPopper } from '@popperjs/core';

let BoardNavigationDropdownHook = {
    init() {
		const popcorn = document.querySelector('.board_navgation');
		const tooltip = document.querySelector('#board_navgation_dropdown_container');

		createPopper(popcorn, tooltip, {
			placement: 'bottom',
			modifiers: [
				{
					name: 'offset',
					options: {
						offset: [-100, 8],
					},
				},
			],
		});
	},
    mounted() {
		window.BoardNavigationDropdownHook = this
	}
}

export { BoardNavigationDropdownHook };