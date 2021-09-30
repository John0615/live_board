
import Editor from '@toast-ui/editor';
let CardDescHook = {
	initViewEditor() {
        new Editor.factory({
            el: document.querySelector('#md-editor'),
            height: 200 + 'px',
            viewer: true,
            initialValue: document.querySelector('#card-desk-info-value').value
        });
    },
    initEditEditor() {
        new Editor({
            el: document.querySelector('#md-editor'),
            initialEditType: 'markdown', // 编辑器markdown 还是 其他形式
            previewStyle: 'tab', // 是否是切一半的页面，另外参数 vertical
            height: '400px', // 高度
            hideModeSwitch: true, // 不展示底部tab切换
            placeholder: '请输入正文...'
         });
    },
	mounted() {
        window.CardDescHook = this     
	}
}

export { CardDescHook };