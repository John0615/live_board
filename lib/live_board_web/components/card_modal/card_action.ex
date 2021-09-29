defmodule CardAction do
  use Surface.LiveComponent

  def render(assigns) do
    ~F"""
    <div id="card_action_container">
      <span class="text-gray-600 font-bold">添加</span>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z" />
        </svg>
        <span class="text-sm ml-2">成员</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M17.707 9.293a1 1 0 010 1.414l-7 7a1 1 0 01-1.414 0l-7-7A.997.997 0 012 10V5a3 3 0 013-3h5c.256 0 .512.098.707.293l7 7zM5 6a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">标签</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">检查项</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M5 4a3 3 0 00-3 3v6a3 3 0 003 3h10a3 3 0 003-3V7a3 3 0 00-3-3H5zm-1 9v-1h5v2H5a1 1 0 01-1-1zm7 1h4a1 1 0 001-1v-1h-5v2zm0-4h5V8h-5v2zM9 8H4v2h5V8z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">工作量</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">附件</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">关联</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">开始时间</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">截止时间</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M7.707 3.293a1 1 0 010 1.414L5.414 7H11a7 7 0 017 7v2a1 1 0 11-2 0v-2a5 5 0 00-5-5H5.414l2.293 2.293a1 1 0 11-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">引用</span>
      </button>
      <span class="text-gray-600 font-bold">操作</span>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">移动</span>
      </button>
      <button type="button" class="mt-1 w-[90%] h-[32px] px-[12px] py-[5px] border rounded flex items-center hover:bg-[#e6e6e6] hover:text-[#333] hover:border-[#adadad]">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
        </svg>
        <span class="text-sm ml-2">删除</span>
      </button>
    </div>
    """
  end
end
