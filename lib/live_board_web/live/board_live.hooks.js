import { Sortable, MultiDrag } from 'sortablejs';
import { getElementPagePosition } from '../common/util.js';
Sortable.mount(new MultiDrag());

let BoardLiveHook = {
	blockSortables: [],
	destroyTaskDraggble() {
		if(this.blockSortables.length==0) return
		this.blockSortables.forEach(sortable=>{
			sortable.destroy();
		})
		this.blockSortables=[];
	},
	initSimpleTaskDraggable(){
		const hook = this;
		const selector = '#' + this.el.id;
		this.destroyTaskDraggble()
		document.querySelectorAll('.dropzone').forEach((dropzone) => {
			const blockSortable = new Sortable(dropzone, {
				animation: 0,
				delay: 50,
				delayOnTouchOnly: true,
				group: "shared",
				draggable: '.draggable',
				ghostClass: 'sortable-ghost',
				forceFallback: true,  // 忽略 HTML5拖拽行为，强制回调进行
				multiDrag: false, 
				fallbackClass: "sortable-fallback",  // 当使用forceFallback的时候，被复制的dom的css类名
				fallbackTolerance: 3, // So that we can select items on mobile
				onEnd: function (evt) {
					let task_order_to_arr = []
					document.getElementById(evt.to.id).childNodes.forEach((item) => {
						if (item.tagName == 'LI') {
							task_order_to_arr.push(item.id)
						}
					})
					hook.pushEventTo(selector, 'task_dropped', {
						draggedId: evt.items.length ? evt.items.map(node => node.id).join() : evt.item.id, // id of the dragged item
						dropzoneId: evt.to.id, // id of the drop zone where the drop occured
						draggableIndex: evt.newDraggableIndex, // index where the item was dropped (relative to other items in the drop zone)
						taskOrderTo: task_order_to_arr.join()
					});
				}
			});
			hook.blockSortables.push(blockSortable);
		});
	},
	initMultipleTaskDraggable(){
		const hook = this;
		const selector = '#' + this.el.id;
		this.destroyTaskDraggble()
		document.querySelectorAll('.dropzone').forEach((dropzone) => {
			const blockSortable = new Sortable(dropzone, {
				animation: 0,
				delay: 50,
				delayOnTouchOnly: true,
				group: "shared",
				draggable: '.draggable',
				ghostClass: 'sortable-ghost',
				forceFallback: true,  // 忽略 HTML5拖拽行为，强制回调进行
				fallbackClass: "sortable-fallback",  // 当使用forceFallback的时候，被复制的dom的css类名
				// 支持多选拖动
				multiDrag: true, // Enable multi-drag
				selectedClass: 'card-selected', // The class applied to the selected items
				fallbackTolerance: 3, // So that we can select items on mobile
				onEnd: function (evt) {
					let task_order_to_arr = []
					document.getElementById(evt.to.id).childNodes.forEach((item) => {
						if (item.tagName == 'LI') {
							task_order_to_arr.push(item.id)
						}
					})
					hook.pushEventTo(selector, 'task_dropped', {
						draggedId: evt.items.length ? evt.items.map(node => node.id).join() : evt.item.id, // id of the dragged item
						dropzoneId: evt.to.id, // id of the drop zone where the drop occured
						draggableIndex: evt.newDraggableIndex, // index where the item was dropped (relative to other items in the drop zone)
						taskOrderTo: task_order_to_arr.join()
					});
				}
			});
			hook.blockSortables.push(blockSortable);
		});
	},
	initDraggable() {
		const hook = this;
		const selector = '#' + this.el.id;
		//卡片拖拽
		this.initSimpleTaskDraggable()
		// 列表拖拽
		const list_header_el = document.getElementById('list_header')
		new Sortable(list_header_el, {
			animation: 0,
			delay: 50,
			delayOnTouchOnly: true,
			forceFallback: true,  // 忽略 HTML5拖拽行为，强制回调进行
			fallbackClass: "sortable-fallback",  // 当使用forceFallback的时候，被复制的dom的css类名
			fallbackOnBody: true,
			group: "list_header",
			draggable: '.draggable_list',
			ghostClass: 'sortable-ghost',
			// 开始拖拽的时候
			onStart: function (/**Event*/evt) {
				const el = `div[block_list_id=block_list_${evt.clone.id}]`
				const els = document.querySelector('#lanes_div').querySelectorAll(el)
				let appendHtml = ''
				els.forEach((node) => appendHtml += node.outerHTML)
				let cloneEle = document.querySelector('.sortable-fallback')
				let html = cloneEle.innerHTML + appendHtml
				cloneEle.innerHTML = html
			},
			// 元素从列表中移除进入另一个列表
			onChange: function (/**Event*/evt) {
				const draggedListId = evt.item.id // id of the dragged item
				const draggableIndex = evt.newDraggableIndex // index where the item was dropped (relative to other items in the drop zone)
				const olddraggableIndex = evt.oldDraggableIndex

				document.querySelectorAll('.lanes_container').forEach(laneNode => {
					let changeNode = null
					laneNode.querySelectorAll('.block_container').forEach(blockNode => {
						const id = `block_list_${draggedListId}`
						if (blockNode.getAttribute("block_list_id") == id) {
							changeNode = blockNode
						}
					})
					// 添加样式类
					changeNode.classList.add('sortable-ghost')
					for (var [index, existingnode] of laneNode.querySelectorAll('.block_container').entries()) {
						if (draggableIndex == 0 && index == 0) {
							laneNode.insertBefore(changeNode, existingnode);
						} else if (index == (draggableIndex + 1) && draggableIndex > olddraggableIndex) {
							laneNode.insertBefore(changeNode, existingnode);
						} else if (index == draggableIndex && draggableIndex < olddraggableIndex) {
							laneNode.insertBefore(changeNode, existingnode);
						} else if (Array.from(laneNode.querySelectorAll('.block_container')).length == (draggableIndex + 1)) {
							laneNode.appendChild(changeNode);
						}
					}
				})
			},
			onEnd: function (evt) {
				const draggedListId = evt.item.id // id of the dragged item
				document.querySelectorAll('.lanes_container').forEach(laneNode => {
					laneNode.querySelectorAll('.block_container').forEach(childNode => {
						const id = `block_list_${draggedListId}`
						if (childNode.getAttribute("block_list_id") == id) {
							childNode.classList.remove('sortable-ghost')
						}
					})
				})
				let listIdArr = []
				document.querySelectorAll('.draggable_list').forEach(node => listIdArr.push(node.id))
				hook.pushEventTo(selector, 'list_dropped', {
					draggedId: draggedListId, // id of the dragged item
					listOrder: listIdArr.join()
				});
			}
		});

		//泳道拖拽
		const lane_el = document.querySelector('#lanes_div')
		new Sortable(lane_el, {
			animation: 150,
			delay: 50,
			delayOnTouchOnly: true,
			draggable: '.lanes_container',
			ghostClass: 'sortable-ghost',
			handle: ".block_container", 
			onEnd: function (evt) {
				let laneSortArr = []
				document.querySelectorAll('.lanes_container').forEach(node => laneSortArr.push(node.id))
				hook.pushEventTo(selector, 'lane_dropped', {
					draggedId: evt.item.id, // id of the dragged item
					laneSort: laneSortArr.join()
				});
			}
		});
	},
	clickBlankSpaceEvent() {
		const hook = this;
		document.querySelector('#page_live_container').addEventListener('click', (e) => {
			let event = e || window.event;
			let target = event.target || event.srcElement;
			if (target.classList.contains('lanes_container') || target.classList.contains('board-body')) {
				// 点击空白处
				window.dispatchEvent(new CustomEvent("closepanel"))
			}
			e.preventDefault();
		})
	},
	cardContextMenuEvent() {
		const hook = this;
		document.querySelector('#lanes_div').addEventListener('contextmenu', function (e) {
			let event = e || window.event;
			let target = event.target || event.srcElement;
			let currentTarget = event.currentTarget;
			while (target !== currentTarget) {
				if (target.matches('li')) {
					// 右键单击了卡片
					hook.pushEventTo(`[card_id=card_${target.id}]`, 'show_edit_card_modal', {
						offset: getElementPagePosition(document.querySelector(`[id="${target.id}"]`))
					})
				}
				target = target.parentNode;
			}
			e.preventDefault();
		})
	},
	mounted() {
		window.BoardLiveHook=this
		this.initDraggable()
		this.clickBlankSpaceEvent()
		this.cardContextMenuEvent()
		this.handleEvent("edit_card", ({task_id}) => {
			this.pushEventTo(`[card_id=card_${task_id}]`, 'show_edit_card_modal', {
				offset: getElementPagePosition(document.querySelector(`[id="${task_id}"]`))
			})
		})
		this.handleEvent("set_multiple_draggble_mode", () => {
			this.initMultipleTaskDraggable()
		})
		this.handleEvent("set_simple_draggble_mode", () => this.initSimpleTaskDraggable())

	},
	updated() {
		this.initDraggable()
	}
}


export { BoardLiveHook };