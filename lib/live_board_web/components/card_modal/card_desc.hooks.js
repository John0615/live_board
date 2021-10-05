
import Editor from '@toast-ui/editor';

let editorObj = null;
let CardDescHook = {
	initViewEditor: () => {
        document.querySelector('#md-editor').style = ""
        editorObj = new Editor.factory({
            el: document.querySelector('#md-editor'),
            height: '200px',
            viewer: true,
            initialValue: document.querySelector('#card-desc-info-value').value
        });
    },
    initEditEditor: () => {
        editorObj = new Editor({
            el: document.querySelector('#md-editor'),
            initialEditType: 'markdown', // 编辑器markdown 还是 其他形式
            initialValue: document.querySelector('#card-desc-info-value').value,
            previewStyle: 'tab', // 是否是切一半的页面，另外参数 vertical
            height: '400px', // 高度
            hideModeSwitch: true, // 不展示底部tab切换
            placeholder: '请输入正文...'
         });
    },
    saveContent: () => {
        BoardLiveHook.pushEventTo("#card_desc_container", "save_card_desc", {
            task_desc: editorObj.getMarkdown()
        })
        document.querySelector('#card-desc-info-value').value=editorObj.getMarkdown()
        CardDescHook.initViewEditor()
    },
	mounted() {
        window.CardDescHook = this     
	},
    updated(){
        this.initViewEditor()
    }
}

export { CardDescHook };