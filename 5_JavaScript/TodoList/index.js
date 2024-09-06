function addTodo(){

    <li>
        밥먹기
        <div class="todo-remove-btn">
            x
        </div>
    </li>

    const searchInput = document.querySelector("#search-bar input")

    const todoli = document.createElement('li')
    todoli.innerText = searchInput.value;

    const removeBtn = document.createElement('div');
    removeBtn.className = 'todo-remove-btn';
    removeBtn.innerHTML = 'x';
    todoli.appendChild(removeBtn);

    removeBtn.onclick = function(){
        (this.parentNode).remove();
    }

    const todoUl =document.querySelector(".todo-list");
    todoUl.appendChild(todoli);
}