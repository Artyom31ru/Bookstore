<?php require 'TEMPLATES/header.php';  ?>

<div id="booksApp">
	<h1>Книги</h1>
	<table>
		<tr>
			<td colspan="3">Сортировка:</td>
			<td>Фильтр по жанру:</td>
			<td>Поиск:</td>
		</tr>
		<tr>
			<form>
			<td>
				<input type="radio" id="dSort" value=" order by id_book" v-model="sort.sort1" v-on:change="GetBooks">
				<label for="dSort">Отключить</label>
			</td>
			<td>
				<input type="radio" id="up_down_price" value=" order by price" v-model="sort.sort1" v-on:change="GetBooks">
				<label for="up_down_price">По возрастанию цены</label>
			</td>
			<td>
				<input type="radio" id="down_up_price" value=" order by price desc" v-model="sort.sort1" v-on:change="GetBooks">
				<label for="down_up_price">По убыванию цены</label>
			</td>
			</form>
			<td>
				<select v-model="sort.sort2" v-on:change="GetBooks">
					<option v-bind:value="''">Без фильтра</option>
					<option v-for="genre in genres" v-bind:value="genre.id_genre">
						{{genre.genre}}
					</option>
				</select>
			</td>
			<td>
				<input type="text" v-model="sort.sort3" v-on:input="GetBooks">
			</td>
		</tr>
	</table>

	<table class="table">
		<tr>
			<th>Название</th>
			<th>Автор</th>
			<th>Жанр</th>
			<th>Цена</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="book in books" v-if="book.id_book !== updateBook.id">
			
				<td>{{book.title}}</td>
				<td>{{book.author}}</td>
				<td>{{book.genre}}</td>
				<td>{{book.price}}</td>
				<td>
					<button v-on:click="GetUpdateBook(book)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteBook(book.id_book)">Удалить</button>
				</td>
			
			<tr v-else>
				<td><input type="text" v-model.trim="updateBook.title"></td>
				<td><input type="text" v-model.trim="updateBook.author"></td>
				<td>
					<select v-model="updateBook.genre_id">
						<option v-for="genre in genres" v-bind:value="genre.id_genre">
							{{genre.genre}}
						</option>
					</select>
				</td>
				<td><input type="number" step="0.01" v-model="updateBook.price"></td>
				<td><button v-on:click="UpdateBook(book.id_book)">Обновить</button></td>
				<td><button v-on:click="updateBook.id = 0">Отмена</button></td>
			</tr>
		</tr>

		<tr>
			<td><input type="text" v-model="newBook.title"></td>
			<td><input type="text" v-model="newBook.author"></td>
			<td>
				<select v-model="newBook.genre_id">
					<option disabled value="0">Выберете жанр:</option>
					<option v-for="genre in genres" v-bind:value="genre.id_genre">
						{{genre.genre}}
					</option>
				</select>
			</td>
			<td><input type="number" step="0.01" v-model="newBook.price"></td>
			<td colspan="2"><button v-on:click="AddBook">Добавить!</button></td>
		</tr>
	</table>

</div>

<script src="JS/books.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>