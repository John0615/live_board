import { createPopper } from '@popperjs/core';

let PersonalActionOptionDropdownHook = {
    init() {
		const popcorn = document.querySelector('.personal_action');
		const tooltip = document.querySelector('#personal_action_option_dropdown_container');

		createPopper(popcorn, tooltip, {
			placement: 'bottom',
			modifiers: [
				{
					name: 'offset',
					options: {
						offset: [-126, 8],
					},
				},
			],
		});
	},
    mounted() {
		window.PersonalActionOptionDropdownHook = this
	}
}

export { PersonalActionOptionDropdownHook };