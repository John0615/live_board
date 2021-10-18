import { createPopper } from '@popperjs/core';

let BackgroundSetting = {
    init() {
		const popcorn = document.querySelector('.personal_action');
		const tooltip = document.querySelector('#background_setting_container');

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
		window.BackgroundSetting = this
	}
}

export { BackgroundSetting }